From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report in hibernate code
Date: Tue, 23 Oct 2007 12:34:54 +0200
Message-ID: <1193135694.9793.67.camel@johannes.berg>
References: <1193062264.9793.11.camel@johannes.berg>
	<200710230039.30224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5240781007295126235=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710230039.30224.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============5240781007295126235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RN7ZVN8TIIRXSQS2HNFk"


--=-RN7ZVN8TIIRXSQS2HNFk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-23 at 00:39 +0200, Rafael J. Wysocki wrote:

> > Oct 22 15:37:59 quad kernel: [  362.782679] [ INFO: possible circular l=
ocking dependency detected ]
> > Oct 22 15:37:59 quad kernel: [  362.782687] 2.6.23-g55b70a03-dirty #268
> > Oct 22 15:37:59 quad kernel: [  362.782696] ---------------------------=
----------------------------
> > Oct 22 15:37:59 quad kernel: [  362.782704] pm-hibernate/4231 is trying=
 to acquire lock:
> > Oct 22 15:37:59 quad kernel: [  362.782710]  (pm_mutex){--..}, at: [<c0=
0000000008ae28>] .disk_store+0x70/0x17c
> > Oct 22 15:37:59 quad kernel: [  362.782742]=20
> > Oct 22 15:37:59 quad kernel: [  362.782744] but task is already holding=
 lock:
> > Oct 22 15:37:59 quad kernel: [  362.782751]  (&buffer->mutex){--..}, at=
: [<c00000000013a620>] .sysfs_write_file+0x58/0x19c
> > Oct 22 15:37:59 quad kernel: [  362.782771]=20
> > Oct 22 15:37:59 quad kernel: [  362.782773] which lock already depends =
on the new lock.
>=20
> That's strange and almost certainly not true.

Uh, are you saying lockdep got it wrong? Hard to imagine. See, it tells
you:

> Oct 22 15:37:59 quad kernel: [  362.782783] the existing dependency chain=
 (in reverse order) is:
> Oct 22 15:37:59 quad kernel: [  362.782795]=20
> Oct 22 15:37:59 quad kernel: [  362.782797] -> #1 (&buffer->mutex){--..}:
> Oct 22 15:37:59 quad kernel: [  362.782831]        [<c00000000007d190>] .=
__lock_acquire+0xcf0/0xf60
> Oct 22 15:37:59 quad kernel: [  362.782910]        [<c00000000007d4d0>] .=
lock_acquire+0xd0/0x11c
> Oct 22 15:37:59 quad kernel: [  362.782982]        [<c0000000003e0ed8>] .=
mutex_lock_nested+0x150/0x3e8
> Oct 22 15:37:59 quad kernel: [  362.783061]        [<c00000000013a7bc>] .=
sysfs_read_file+0x58/0x1a0
> Oct 22 15:37:59 quad kernel: [  362.783137]        [<c0000000000dd130>] .=
vfs_read+0xd8/0x1b0
> Oct 22 15:37:59 quad kernel: [  362.783211]        [<c0000000000dd960>] .=
sys_read+0x5c/0xac
> Oct 22 15:37:59 quad kernel: [  362.783285]        [<c000000000008014>] .=
try_name+0x88/0x260
> Oct 22 15:37:59 quad kernel: [  362.783362]        [<c000000000008430>] .=
name_to_dev_t+0x244/0x2e8
> Oct 22 15:37:59 quad kernel: [  362.783439]        [<c00000000008b33c>] .=
software_resume+0x7c/0x200
> Oct 22 15:37:59 quad kernel: [  362.783516]        [<c00000000054e8f8>] .=
kernel_init+0x214/0x3e8
> Oct 22 15:37:59 quad kernel: [  362.783588]        [<c000000000024cdc>] .=
kernel_thread+0x4c/0x68
> Oct 22 15:37:59 quad kernel: [  362.783623]=20

So let's look through the code.

software_resume() does:

459         mutex_lock(&pm_mutex);
[...]
465                 swsusp_resume_device =3D name_to_dev_t(resume_file);

which, according to the trace above takes a buffer mutex. This can be
verified easily, I haven't bothered.

The problem here is that the buffer mutexes are not distinguishable.

johannes

--=-RN7ZVN8TIIRXSQS2HNFk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx3OTaVg1VMiehFYAQIE/w/+P51PANDAB5yw4VjVSC+Azewjfr4yPQ0W
r6UOmlbYVHAkOdWnV8lhaTZR7TeRHOPIhivWIUjs4JuZqhAUFjsypgCYXFm/0Sf4
qwi9HEX3GILS7UIbrN+VcTaQXfdVWAiWhDs0OfyEKCR74foQh6EuRNx0/HyHuMn4
yBBDxKGrruw1MCoshgc48385ppJKgEtHyOvAzrnEOPcWDWdQSDUJSd6BMmmsVxiW
0grNOs8t4Tk8GFanneyQcQnh9x02v1UnKXAOkMliUuIKBwnWpMd4Myv/Y9G9tVQz
bMhioCwENgthZ6kypHbTT3wF+4NmV7UGL2iMGZJO7z4gqmKI8UFjYQLCNeWnUXXG
24J/heSovmoITACk/r4+okapgOWoTble0doh/ex2HIVEmf8JJRN8VJyo/vxdJFT9
KGl4UkLW1BwgjSel7Wswl93HkYgJ+aAEpeSX9y0uqQ90B0kv2qgPx1ibG1indpUA
aDU0Mhe4GYZX/x9e5O32lGMf3gZ6zbpzqLdB+MdPOkbrSXOE1Q/7kO72Madiqx8K
+VMuCP/j485ejt668PSyWvlOHcUOO6wJrMWkTAi+BQuV91s0rtehDafNMaMU3hyo
RpmBd0vqrTeEAtG2n7osmgMAxz0YEZAhOZJX1KyZfxpIyu1UjVgJO1yrzgGiFYqD
TcDC+FO6dko=
=M+FH
-----END PGP SIGNATURE-----

--=-RN7ZVN8TIIRXSQS2HNFk--


--===============5240781007295126235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5240781007295126235==--
