From: Johannes Berg <johannes@sipsolutions.net>
Subject: lockdep report in hibernate code
Date: Mon, 22 Oct 2007 16:11:04 +0200
Message-ID: <1193062264.9793.11.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2349547845422435295=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============2349547845422435295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8DzHfbmpEw2+h8W81yFq"


--=-8DzHfbmpEw2+h8W81yFq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I just got this on my quad powermac which then failed to hibernate
(separate mail coming soon):

Oct 22 15:37:59 quad kernel: [  362.782679] [ INFO: possible circular locki=
ng dependency detected ]
Oct 22 15:37:59 quad kernel: [  362.782687] 2.6.23-g55b70a03-dirty #268
Oct 22 15:37:59 quad kernel: [  362.782696] -------------------------------=
------------------------
Oct 22 15:37:59 quad kernel: [  362.782704] pm-hibernate/4231 is trying to =
acquire lock:
Oct 22 15:37:59 quad kernel: [  362.782710]  (pm_mutex){--..}, at: [<c00000=
000008ae28>] .disk_store+0x70/0x17c
Oct 22 15:37:59 quad kernel: [  362.782742]=20
Oct 22 15:37:59 quad kernel: [  362.782744] but task is already holding loc=
k:
Oct 22 15:37:59 quad kernel: [  362.782751]  (&buffer->mutex){--..}, at: [<=
c00000000013a620>] .sysfs_write_file+0x58/0x19c
Oct 22 15:37:59 quad kernel: [  362.782771]=20
Oct 22 15:37:59 quad kernel: [  362.782773] which lock already depends on t=
he new lock.
Oct 22 15:37:59 quad kernel: [  362.782776]=20
Oct 22 15:37:59 quad kernel: [  362.782782]=20
Oct 22 15:37:59 quad kernel: [  362.782783] the existing dependency chain (=
in reverse order) is:
Oct 22 15:37:59 quad kernel: [  362.782795]=20
Oct 22 15:37:59 quad kernel: [  362.782797] -> #1 (&buffer->mutex){--..}:
Oct 22 15:37:59 quad kernel: [  362.782831]        [<c00000000007d190>] .__=
lock_acquire+0xcf0/0xf60
Oct 22 15:37:59 quad kernel: [  362.782910]        [<c00000000007d4d0>] .lo=
ck_acquire+0xd0/0x11c
Oct 22 15:37:59 quad kernel: [  362.782982]        [<c0000000003e0ed8>] .mu=
tex_lock_nested+0x150/0x3e8
Oct 22 15:37:59 quad kernel: [  362.783061]        [<c00000000013a7bc>] .sy=
sfs_read_file+0x58/0x1a0
Oct 22 15:37:59 quad kernel: [  362.783137]        [<c0000000000dd130>] .vf=
s_read+0xd8/0x1b0
Oct 22 15:37:59 quad kernel: [  362.783211]        [<c0000000000dd960>] .sy=
s_read+0x5c/0xac
Oct 22 15:37:59 quad kernel: [  362.783285]        [<c000000000008014>] .tr=
y_name+0x88/0x260
Oct 22 15:37:59 quad kernel: [  362.783362]        [<c000000000008430>] .na=
me_to_dev_t+0x244/0x2e8
Oct 22 15:37:59 quad kernel: [  362.783439]        [<c00000000008b33c>] .so=
ftware_resume+0x7c/0x200
Oct 22 15:37:59 quad kernel: [  362.783516]        [<c00000000054e8f8>] .ke=
rnel_init+0x214/0x3e8
Oct 22 15:37:59 quad kernel: [  362.783588]        [<c000000000024cdc>] .ke=
rnel_thread+0x4c/0x68
Oct 22 15:37:59 quad kernel: [  362.783623]=20
Oct 22 15:37:59 quad kernel: [  362.783625] -> #0 (pm_mutex){--..}:
Oct 22 15:37:59 quad kernel: [  362.783659]        [<c00000000007d088>] .__=
lock_acquire+0xbe8/0xf60
Oct 22 15:37:59 quad kernel: [  362.783733]        [<c00000000007d4d0>] .lo=
ck_acquire+0xd0/0x11c
Oct 22 15:37:59 quad kernel: [  362.783810]        [<c0000000003e0ed8>] .mu=
tex_lock_nested+0x150/0x3e8
Oct 22 15:37:59 quad kernel: [  362.783884]        [<c00000000008ae28>] .di=
sk_store+0x70/0x17c
Oct 22 15:37:59 quad kernel: [  362.783960]        [<c00000000013a160>] .su=
bsys_attr_store+0x58/0x70
Oct 22 15:37:59 quad kernel: [  362.784033]        [<c00000000013a6f4>] .sy=
sfs_write_file+0x12c/0x19c
Oct 22 15:37:59 quad kernel: [  362.784104]        [<c0000000000dcf80>] .vf=
s_write+0xd8/0x1b0
Oct 22 15:37:59 quad kernel: [  362.784179]        [<c0000000000dda0c>] .sy=
s_write+0x5c/0xac
Oct 22 15:37:59 quad kernel: [  362.784255]        [<c000000000007550>] sys=
call_exit+0x0/0x40
Oct 22 15:37:59 quad kernel: [  362.784331]=20
Oct 22 15:37:59 quad kernel: [  362.784333] other info that might help us d=
ebug this:
Oct 22 15:37:59 quad kernel: [  362.784336]=20
Oct 22 15:37:59 quad kernel: [  362.784349] 1 lock held by pm-hibernate/423=
1:
Oct 22 15:37:59 quad kernel: [  362.784360]  #0:  (&buffer->mutex){--..}, a=
t: [<c00000000013a620>] .sysfs_write_file+0x58/0x19c
Oct 22 15:37:59 quad kernel: [  362.784411]=20
Oct 22 15:37:59 quad kernel: [  362.784413] stack backtrace:
Oct 22 15:37:59 quad kernel: [  362.784423] Call Trace:
Oct 22 15:37:59 quad kernel: [  362.784434] [c000000010783650] [c0000000000=
0e758] .show_stack+0x78/0x1a4 (unreliable)
Oct 22 15:37:59 quad kernel: [  362.784473] [c000000010783700] [c0000000000=
0e8a4] .dump_stack+0x20/0x34
Oct 22 15:37:59 quad kernel: [  362.784503] [c000000010783780] [c0000000000=
7a74c] .print_circular_bug_tail+0x88/0xac
Oct 22 15:37:59 quad kernel: [  362.784535] [c000000010783850] [c0000000000=
7d088] .__lock_acquire+0xbe8/0xf60
Oct 22 15:37:59 quad kernel: [  362.784567] [c000000010783940] [c0000000000=
7d4d0] .lock_acquire+0xd0/0x11c
Oct 22 15:37:59 quad kernel: [  362.784599] [c000000010783a00] [c0000000003=
e0ed8] .mutex_lock_nested+0x150/0x3e8
Oct 22 15:37:59 quad kernel: [  362.784619] [c000000010783af0] [c0000000000=
8ae28] .disk_store+0x70/0x17c
Oct 22 15:37:59 quad kernel: [  362.784650] [c000000010783ba0] [c0000000001=
3a160] .subsys_attr_store+0x58/0x70
Oct 22 15:37:59 quad kernel: [  362.784680] [c000000010783c20] [c0000000001=
3a6f4] .sysfs_write_file+0x12c/0x19c
Oct 22 15:37:59 quad kernel: [  362.784712] [c000000010783ce0] [c0000000000=
dcf80] .vfs_write+0xd8/0x1b0
Oct 22 15:37:59 quad kernel: [  362.784742] [c000000010783d80] [c0000000000=
dda0c] .sys_write+0x5c/0xac
Oct 22 15:37:59 quad kernel: [  362.784772] [c000000010783e30] [c0000000000=
07550] syscall_exit+0x0/0x40


--=-8DzHfbmpEw2+h8W81yFq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARxyvd6Vg1VMiehFYAQL6oQ/9HR84Zavh2GLyJfNcH5bc295HUWWw3rsl
crOtFqX7LUTG8bOfRJ2UaPpbeMs7ar3bgP6MV5oP2q1O1S1eVXHxY0Xt4s6WeK2w
s0TeLug6oLnSX/atpIk8pFiqtZP5QjlMQh6MS8Ma2fP41/obgLJegMLFEqk/3eSn
2AC5VOHRnUIVmU0CYowijaLB/c9lliX/3q/bZGevoYAsLid9SZruek9xac3bKkzY
ew69dXxgrdx9bBngG8Lmjlm76wEaVCe4tQgpVgd+eLCVF7LNpDIj1czPCZG0NFLk
KmIyjs4qUnaUfD1BmZdhnQM27WMiP2k9LEri3HYTgWs7ojJa1y4fiIIOvQalxEWw
MxdmJusX7PBbNzfiaFtzIzu5NdnYOPM2WgNaHI9ngqa/X1ZGr6wX5O+W21YXn2zo
1OsJDoCrlpI7ntQzfUSP9nwsBWeWp9JMvwCF9/2Ir9b3S6L1cQnsSPbDXr/4uqAF
z1Us2zujaxC9QlX8zvP/BH/xudyZJ/5QDjaXabpciKYJ29Pi/b8xCLdBiQZWaU8y
imcoFLnEqNtdC+1H2367NXfWPjVkZo7dVYSV9WjSVs4IMOHVzT4Q0B9GBos2Vu/h
jAeO3laWIAaKUEUsBX7mtYXPhqbnxogBZk+usimNNQkpNaQAqyfgRFCycJt+jnr2
tAPLgy4uPUo=
=bool
-----END PGP SIGNATURE-----

--=-8DzHfbmpEw2+h8W81yFq--


--===============2349547845422435295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2349547845422435295==--
