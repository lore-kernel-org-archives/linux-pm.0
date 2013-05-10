From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk failed, 2nd attempt worked
Date: Fri, 10 May 2013 22:33:18 +0200
Message-ID: <8888229.vfqOe8ZlcS@vostro.rjw.lan>
References: <518CFD77.2000705@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43321 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386Ab3EJUYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2013 16:24:50 -0400
In-Reply-To: <518CFD77.2000705@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Friday, May 10, 2013 04:00:23 PM Toralf F=C3=B6rster wrote:
> At a stable 32 bit Gentoo w/ kernel 3.9.1 I need yesterday 2 attempts=
 to s2disk the system.
> The first s2disk failed with the error msg :
>=20
> echo: write error: Cannot allocate memory
>=20
> at this line of my hibernation script :
> echo $1 > /sys/power/state
>=20
>=20
> 2013-05-09T22:49:31.000+02:00 n22 sudo: tfoerste : TTY=3Dpts/2 ; PWD=3D=
/home/tfoerste ; USER=3Droot ; COMMAND=3D/home/tfoerste/workspace/acpi/=
default.sh ibm/hotkey HKEY 00000080 0000100c
> 2013-05-09T22:49:31.000+02:00 n22 sudo: pam_unix(sudo:session): sessi=
on opened for user root by tfoerste(uid=3D0)
> 2013-05-09T22:49:32.000+02:00 n22 su[27780]: Successful su for boinc =
by root
> 2013-05-09T22:49:32.000+02:00 n22 su[27780]: + /dev/pts/2 root:boinc
> 2013-05-09T22:49:32.000+02:00 n22 su[27780]: pam_unix(su:session): se=
ssion opened for user boinc by tfoerste(uid=3D0)
> 2013-05-09T22:49:32.000+02:00 n22 su[27780]: pam_unix(su:session): se=
ssion closed for user boinc
> 2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Terminating on signal 1=
5
> 2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Connect time 465.1 minu=
tes.
> 2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Sent 2701783 bytes, rec=
eived 27205393 bytes.
> 2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Connection terminated.
> 2013-05-09T22:49:36.000+02:00 n22 /etc/init.d/net.ppp0[27911]: status=
: stopping
> 2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Exit.
> 2013-05-09T22:49:37.327+02:00 n22 kernel: PM: Marking nosave pages: [=
mem 0x0009d000-0x000fffff]
> 2013-05-09T22:49:37.327+02:00 n22 kernel: PM: Marking nosave pages: [=
mem 0x20000000-0x201fffff]
> 2013-05-09T22:49:37.327+02:00 n22 kernel: PM: Basic memory bitmaps cr=
eated
> 2013-05-09T22:49:42.951+02:00 n22 kernel: PM: Syncing filesystems ...=
 done.
> 2013-05-09T22:49:42.951+02:00 n22 kernel: Freezing user space process=
es ... (elapsed 0.01 seconds) done.
> 2013-05-09T22:49:42.951+02:00 n22 kernel: PM: Preallocating image mem=
ory... done (allocated 721313 pages)
> 2013-05-09T22:49:42.951+02:00 n22 kernel: PM: Allocated 2885252 kbyte=
s in 0.95 seconds (3037.10 MB/s)
> 2013-05-09T22:49:42.951+02:00 n22 kernel: Freezing remaining freezabl=
e tasks ... (elapsed 0.01 seconds) done.
> 2013-05-09T22:49:42.951+02:00 n22 kernel: Suspending console(s) (use =
no_console_suspend to debug)
> 2013-05-09T22:49:42.951+02:00 n22 kernel: kthreadd: page allocation f=
ailure: order:1, mode:0x300010
> 2013-05-09T22:49:42.951+02:00 n22 kernel: Pid: 2, comm: kthreadd Not =
tainted 3.9.1 #8
> 2013-05-09T22:49:42.951+02:00 n22 kernel: Call Trace:
> 2013-05-09T22:49:42.951+02:00 n22 kernel: [<c10d9c5f>] warn_alloc_fai=
led+0xbf/0x100
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10dc70b>] __alloc_pages_=
nodemask+0x5cb/0x7d0
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1032ba3>] copy_process+0=
x103/0x10c0
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10548b0>] ? flush_kthrea=
d_work+0xd0/0xd0
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10548b0>] ? flush_kthrea=
d_work+0xd0/0xd0
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1033c3e>] do_fork+0x9e/0=
x2b0
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10548b0>] ? flush_kthrea=
d_work+0xd0/0xd0
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1033e7d>] kernel_thread+=
0x2d/0x40
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1054cb8>] kthreadd+0xd8/=
0x110
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1487477>] ret_from_kerne=
l_thread+0x1b/0x28
> 2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1054be0>] ? kthread_crea=
te_on_cpu+0x60/0x60
> 2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: Deleting interface #3 p=
pp0, 80.171.222.206#123, interface stats: received=3D296, sent=3D296, d=
ropped=3D0, active_time=3D27884 secs
> 2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 178.254.20.157 interfac=
e 80.171.222.206 -> (none)
> 2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 213.239.204.119 interfa=
ce 80.171.222.206 -> (none)
> 2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 46.165.212.204 interfac=
e 80.171.222.206 -> (none)
> 2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 195.50.171.101 interfac=
e 80.171.222.206 -> (none)
> 2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: peers refreshed

This means there was no room to create a new kernel thread after memory=
 for
hibernation has been preallocated.  Most likely you need to reduce the =
image
size for the system in question.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
