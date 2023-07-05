open Miou

exception Timeout

let with_timeout s fn =
  let p0 = Prm.call_cc fn in
  let p1 = Prm.call_cc @@ fun () -> Miouu.sleep s; raise Timeout in
  Prm.await_first [ p0; p1 ]

let () =
  match Miouu.run @@ fun () -> with_timeout 10. (Fun.const ()) with
  | Ok () -> ()
  | Error _ -> failwith "t23"