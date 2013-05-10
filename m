From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: s2disk failed, 2nd attempt worked
Date: Fri, 10 May 2013 16:00:23 +0200
Message-ID: <518CFD77.2000705@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:49473 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984Ab3EJOA1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 May 2013 10:00:27 -0400
Received: from mailout-de.gmx.net ([10.1.76.24]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LuJ7B-1URU9F1Mhj-011mKS for
 <linux-pm@vger.kernel.org>; Fri, 10 May 2013 16:00:26 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

At a stable 32 bit Gentoo w/ kernel 3.9.1 I need yesterday 2 attempts t=
o s2disk the system.
The first s2disk failed with the error msg :

echo: write error: Cannot allocate memory

at this line of my hibernation script :
echo $1 > /sys/power/state


2013-05-09T22:49:31.000+02:00 n22 sudo: tfoerste : TTY=3Dpts/2 ; PWD=3D=
/home/tfoerste ; USER=3Droot ; COMMAND=3D/home/tfoerste/workspace/acpi/=
default.sh ibm/hotkey HKEY 00000080 0000100c
2013-05-09T22:49:31.000+02:00 n22 sudo: pam_unix(sudo:session): session=
 opened for user root by tfoerste(uid=3D0)
2013-05-09T22:49:32.000+02:00 n22 su[27780]: Successful su for boinc by=
 root
2013-05-09T22:49:32.000+02:00 n22 su[27780]: + /dev/pts/2 root:boinc
2013-05-09T22:49:32.000+02:00 n22 su[27780]: pam_unix(su:session): sess=
ion opened for user boinc by tfoerste(uid=3D0)
2013-05-09T22:49:32.000+02:00 n22 su[27780]: pam_unix(su:session): sess=
ion closed for user boinc
2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Terminating on signal 15
2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Connect time 465.1 minute=
s.
2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Sent 2701783 bytes, recei=
ved 27205393 bytes.
2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Connection terminated.
2013-05-09T22:49:36.000+02:00 n22 /etc/init.d/net.ppp0[27911]: status: =
stopping
2013-05-09T22:49:36.000+02:00 n22 pppd[5159]: Exit.
2013-05-09T22:49:37.327+02:00 n22 kernel: PM: Marking nosave pages: [me=
m 0x0009d000-0x000fffff]
2013-05-09T22:49:37.327+02:00 n22 kernel: PM: Marking nosave pages: [me=
m 0x20000000-0x201fffff]
2013-05-09T22:49:37.327+02:00 n22 kernel: PM: Basic memory bitmaps crea=
ted
2013-05-09T22:49:42.951+02:00 n22 kernel: PM: Syncing filesystems ... d=
one.
2013-05-09T22:49:42.951+02:00 n22 kernel: Freezing user space processes=
 ... (elapsed 0.01 seconds) done.
2013-05-09T22:49:42.951+02:00 n22 kernel: PM: Preallocating image memor=
y... done (allocated 721313 pages)
2013-05-09T22:49:42.951+02:00 n22 kernel: PM: Allocated 2885252 kbytes =
in 0.95 seconds (3037.10 MB/s)
2013-05-09T22:49:42.951+02:00 n22 kernel: Freezing remaining freezable =
tasks ... (elapsed 0.01 seconds) done.
2013-05-09T22:49:42.951+02:00 n22 kernel: Suspending console(s) (use no=
_console_suspend to debug)
2013-05-09T22:49:42.951+02:00 n22 kernel: kthreadd: page allocation fai=
lure: order:1, mode:0x300010
2013-05-09T22:49:42.951+02:00 n22 kernel: Pid: 2, comm: kthreadd Not ta=
inted 3.9.1 #8
2013-05-09T22:49:42.951+02:00 n22 kernel: Call Trace:
2013-05-09T22:49:42.951+02:00 n22 kernel: [<c10d9c5f>] warn_alloc_faile=
d+0xbf/0x100
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10dc70b>] __alloc_pages_no=
demask+0x5cb/0x7d0
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1032ba3>] copy_process+0x1=
03/0x10c0
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1033c3e>] do_fork+0x9e/0x2=
b0
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1033e7d>] kernel_thread+0x=
2d/0x40
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1054cb8>] kthreadd+0xd8/0x=
110
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1487477>] ret_from_kernel_=
thread+0x1b/0x28
2013-05-09T22:49:43.728+02:00 n22 kernel: [<c1054be0>] ? kthread_create=
_on_cpu+0x60/0x60
2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: Deleting interface #3 ppp=
0, 80.171.222.206#123, interface stats: received=3D296, sent=3D296, dro=
pped=3D0, active_time=3D27884 secs
2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 178.254.20.157 interface =
80.171.222.206 -> (none)
2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 213.239.204.119 interface=
 80.171.222.206 -> (none)
2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 46.165.212.204 interface =
80.171.222.206 -> (none)
2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: 195.50.171.101 interface =
80.171.222.206 -> (none)
2013-05-09T22:49:42.000+02:00 n22 ntpd[5772]: peers refreshed
2013-05-09T22:49:43.729+02:00 n22 kernel: Mem-Info:
2013-05-09T22:49:43.729+02:00 n22 kernel: DMA per-cpu:
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    0: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    1: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    2: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    3: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: Normal per-cpu:
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd: 107
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:  30
2013-05-09T22:49:43.729+02:00 n22 kernel: HighMem per-cpu:
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.729+02:00 n22 kernel: active_anon:72360 inactive_an=
on:72399 isolated_anon:0
2013-05-09T22:49:43.729+02:00 n22 kernel: active_file:22347 inactive_fi=
le:5125 isolated_file:0
2013-05-09T22:49:43.729+02:00 n22 kernel: unevictable:0 dirty:2 writeba=
ck:0 unstable:0
2013-05-09T22:49:43.729+02:00 n22 kernel: free:1131669 slab_reclaimable=
:4534 slab_unreclaimable:5614
2013-05-09T22:49:43.730+02:00 n22 kernel: mapped:17714 shmem:96025 page=
tables:1619 bounce:0
2013-05-09T22:49:43.730+02:00 n22 kernel: free_cma:0
2013-05-09T22:49:43.730+02:00 n22 kernel: DMA free:3868kB min:760kB low=
:948kB high:1140kB active_anon:0kB inactive_anon:0kB active_file:0kB in=
active_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB p=
resent:15984kB managed:15360kB mlocked:0kB dirty:0kB writeback:0kB mapp=
ed:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:16kB kernel_st=
ack:0kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_t=
mp:0kB pages_scanned:0 all_unreclaimable? yes
2013-05-09T22:49:43.730+02:00 n22 kernel: lowmem_reserve[]: 0 779 7964 =
7964
2013-05-09T22:49:43.730+02:00 n22 kernel: Normal free:41632kB min:39628=
kB low:49532kB high:59440kB active_anon:0kB inactive_anon:0kB active_fi=
le:208kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB present:894968kB managed:797924kB mlocked:0kB dirty:0kB write=
back:0kB mapped:8kB shmem:0kB slab_reclaimable:18136kB slab_unreclaimab=
le:22440kB kernel_stack:2632kB pagetables:6476kB unstable:0kB bounce:0k=
B free_cma:0kB writeback_tmp:0kB pages_scanned:43 all_unreclaimable? no
2013-05-09T22:49:43.730+02:00 n22 kernel: lowmem_reserve[]: 0 0 57485 5=
7485
2013-05-09T22:49:43.730+02:00 n22 kernel: HighMem free:4481176kB min:51=
2kB low:91872kB high:183232kB active_anon:289440kB inactive_anon:289596=
kB active_file:89180kB inactive_file:20500kB unevictable:0kB isolated(a=
non):0kB isolated(file):0kB present:7358088kB managed:7358088kB mlocked=
:0kB dirty:8kB writeback:0kB mapped:70848kB shmem:384100kB slab_reclaim=
able:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstabl=
e:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:64 all_un=
reclaimable? no
2013-05-09T22:49:43.730+02:00 n22 kernel: lowmem_reserve[]: 0 0 0 0
2013-05-09T22:49:43.730+02:00 n22 kernel: DMA: 1*4kB (R) 1*8kB (R) 1*16=
kB (R) 0*32kB 0*64kB 0*128kB 1*256kB (R) 1*512kB (R) 1*1024kB (R) 1*204=
8kB (R) 0*4096kB =3D 3868kB
2013-05-09T22:49:43.730+02:00 n22 kernel: Normal: 7464*4kB (UEM) 332*8k=
B (UEM) 56*16kB (UE) 6*32kB (E) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB=
 0*2048kB 2*4096kB (R) =3D 41792kB
2013-05-09T22:49:43.731+02:00 n22 kernel: HighMem: 32646*4kB (UEM) 2791=
1*8kB (UEM) 25180*16kB (UEM) 16711*32kB (UEM) 9814*64kB (UEM) 4119*128k=
B (UEM) 2162*256kB (UEM) 1165*512kB (UEM) 718*1024kB (M) 49*2048kB (M) =
12*4096kB (MR) =3D 4481520kB
2013-05-09T22:49:43.731+02:00 n22 kernel: 123466 total pagecache pages
2013-05-09T22:49:43.731+02:00 n22 kernel: 0 pages in swap cache
2013-05-09T22:49:43.731+02:00 n22 kernel: Swap cache stats: add 0, dele=
te 0, find 0/0
2013-05-09T22:49:43.731+02:00 n22 kernel: Free swap  =3D 9767516kB
2013-05-09T22:49:43.731+02:00 n22 kernel: Total swap =3D 9767516kB
2013-05-09T22:49:43.731+02:00 n22 kernel: 2221567 pages RAM
2013-05-09T22:49:43.731+02:00 n22 kernel: 1993218 pages HighMem
2013-05-09T22:49:43.731+02:00 n22 kernel: 178200 pages reserved
2013-05-09T22:49:43.731+02:00 n22 kernel: 390846 pages shared
2013-05-09T22:49:43.732+02:00 n22 kernel: 857380 pages non-shared
2013-05-09T22:49:43.732+02:00 n22 kernel: kthreadd: page allocation fai=
lure: order:1, mode:0x300010
2013-05-09T22:49:43.732+02:00 n22 kernel: Pid: 2, comm: kthreadd Not ta=
inted 3.9.1 #8
2013-05-09T22:49:43.732+02:00 n22 kernel: Call Trace:
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c10d9c5f>] warn_alloc_faile=
d+0xbf/0x100
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c10dc70b>] __alloc_pages_no=
demask+0x5cb/0x7d0
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1032ba3>] copy_process+0x1=
03/0x10c0
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1033c3e>] do_fork+0x9e/0x2=
b0
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1063690>] ? default_wake_f=
unction+0x10/0x20
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1033e7d>] kernel_thread+0x=
2d/0x40
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1054cb8>] kthreadd+0xd8/0x=
110
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1487477>] ret_from_kernel_=
thread+0x1b/0x28
2013-05-09T22:49:43.732+02:00 n22 kernel: [<c1054be0>] ? kthread_create=
_on_cpu+0x60/0x60
2013-05-09T22:49:43.732+02:00 n22 kernel: Mem-Info:
2013-05-09T22:49:43.732+02:00 n22 kernel: DMA per-cpu:
2013-05-09T22:49:43.732+02:00 n22 kernel: CPU    0: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.732+02:00 n22 kernel: CPU    1: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    2: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    3: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.733+02:00 n22 kernel: Normal per-cpu:
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd: 107
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:  30
2013-05-09T22:49:43.733+02:00 n22 kernel: HighMem per-cpu:
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.733+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.734+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.734+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.734+02:00 n22 kernel: active_anon:72328 inactive_an=
on:72431 isolated_anon:0
2013-05-09T22:49:43.734+02:00 n22 kernel: active_file:22338 inactive_fi=
le:5137 isolated_file:0
2013-05-09T22:49:43.734+02:00 n22 kernel: unevictable:0 dirty:2 writeba=
ck:0 unstable:0
2013-05-09T22:49:43.734+02:00 n22 kernel: free:1131737 slab_reclaimable=
:4516 slab_unreclaimable:5614
2013-05-09T22:49:43.734+02:00 n22 kernel: mapped:17714 shmem:96025 page=
tables:1619 bounce:0
2013-05-09T22:49:43.734+02:00 n22 kernel: free_cma:0
2013-05-09T22:49:43.734+02:00 n22 kernel: DMA free:3868kB min:760kB low=
:948kB high:1140kB active_anon:0kB inactive_anon:0kB active_file:0kB in=
active_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB p=
resent:15984kB managed:15360kB mlocked:0kB dirty:0kB writeback:0kB mapp=
ed:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:16kB kernel_st=
ack:0kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_t=
mp:0kB pages_scanned:0 all_unreclaimable? yes
2013-05-09T22:49:43.734+02:00 n22 kernel: lowmem_reserve[]: 0 779 7964 =
7964
2013-05-09T22:49:43.734+02:00 n22 kernel: Normal free:41720kB min:39628=
kB low:49532kB high:59440kB active_anon:0kB inactive_anon:0kB active_fi=
le:172kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB present:894968kB managed:797924kB mlocked:0kB dirty:0kB write=
back:0kB mapped:8kB shmem:0kB slab_reclaimable:18064kB slab_unreclaimab=
le:22440kB kernel_stack:2632kB pagetables:6476kB unstable:0kB bounce:0k=
B free_cma:0kB writeback_tmp:0kB pages_scanned:86 all_unreclaimable? no
2013-05-09T22:49:43.734+02:00 n22 kernel: lowmem_reserve[]: 0 0 57485 5=
7485
2013-05-09T22:49:43.734+02:00 n22 kernel: HighMem free:4481360kB min:51=
2kB low:91872kB high:183232kB active_anon:289312kB inactive_anon:289724=
kB active_file:89180kB inactive_file:20548kB unevictable:0kB isolated(a=
non):0kB isolated(file):0kB present:7358088kB managed:7358088kB mlocked=
:0kB dirty:8kB writeback:0kB mapped:70848kB shmem:384100kB slab_reclaim=
able:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstabl=
e:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:64 all_un=
reclaimable? no
2013-05-09T22:49:43.734+02:00 n22 kernel: lowmem_reserve[]: 0 0 0 0
2013-05-09T22:49:43.734+02:00 n22 kernel: DMA: 1*4kB (R) 1*8kB (R) 1*16=
kB (R) 0*32kB 0*64kB 0*128kB 1*256kB (R) 1*512kB (R) 1*1024kB (R) 1*204=
8kB (R) 0*4096kB =3D 3868kB
2013-05-09T22:49:43.734+02:00 n22 kernel: Normal: 7464*4kB (UEM) 332*8k=
B (UEM) 56*16kB (UE) 6*32kB (E) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB=
 0*2048kB 2*4096kB (R) =3D 41792kB
2013-05-09T22:49:43.734+02:00 n22 kernel: HighMem: 32646*4kB (UEM) 2791=
1*8kB (UEM) 25180*16kB (UEM) 16711*32kB (UEM) 9814*64kB (UEM) 4119*128k=
B (UEM) 2162*256kB (UEM) 1165*512kB (UEM) 718*1024kB (M) 49*2048kB (M) =
12*4096kB (MR) =3D 4481520kB
2013-05-09T22:49:43.734+02:00 n22 kernel: 123453 total pagecache pages
2013-05-09T22:49:43.734+02:00 n22 kernel: 0 pages in swap cache
2013-05-09T22:49:43.734+02:00 n22 kernel: Swap cache stats: add 0, dele=
te 0, find 0/0
2013-05-09T22:49:43.734+02:00 n22 kernel: Free swap  =3D 9767516kB
2013-05-09T22:49:43.734+02:00 n22 kernel: Total swap =3D 9767516kB
2013-05-09T22:49:43.734+02:00 n22 kernel: 2221567 pages RAM
2013-05-09T22:49:43.734+02:00 n22 kernel: 1993218 pages HighMem
2013-05-09T22:49:43.734+02:00 n22 kernel: 178200 pages reserved
2013-05-09T22:49:43.734+02:00 n22 kernel: 390746 pages shared
2013-05-09T22:49:43.734+02:00 n22 kernel: 857380 pages non-shared
2013-05-09T22:49:43.734+02:00 n22 kernel: PM: freeze of devices complet=
e after 348.276 msecs
2013-05-09T22:49:43.734+02:00 n22 kernel: PM: late freeze of devices co=
mplete after 0.288 msecs
2013-05-09T22:49:43.734+02:00 n22 kernel: PM: noirq freeze of devices c=
omplete after 0.944 msecs
2013-05-09T22:49:43.735+02:00 n22 kernel: ACPI: Preparing to enter syst=
em sleep state S4
2013-05-09T22:49:43.735+02:00 n22 kernel: PM: Saving platform NVS memor=
y
2013-05-09T22:49:43.735+02:00 n22 kernel: Disabling non-boot CPUs ...
2013-05-09T22:49:43.735+02:00 n22 kernel: smpboot: CPU 1 is now offline
2013-05-09T22:49:43.735+02:00 n22 kernel: smpboot: CPU 2 is now offline
2013-05-09T22:49:43.735+02:00 n22 kernel: smpboot: CPU 3 is now offline
2013-05-09T22:49:43.735+02:00 n22 kernel: PM: Creating hibernation imag=
e:
2013-05-09T22:49:43.735+02:00 n22 kernel: PM: Need to copy 212964 pages
2013-05-09T22:49:43.735+02:00 n22 kernel: PM: Normal pages needed: 3799=
7 + 1024, available pages: 189599
2013-05-09T22:49:43.735+02:00 n22 kernel: PM: Hibernation image created=
 (212964 pages copied)
2013-05-09T22:49:43.736+02:00 n22 kernel: Enabling non-boot CPUs ...
2013-05-09T22:49:43.736+02:00 n22 kernel: smpboot: Booting Node 0 Proce=
ssor 1 APIC 0x1
2013-05-09T22:49:43.736+02:00 n22 kernel: Initializing CPU#1
2013-05-09T22:49:43.736+02:00 n22 kernel: Disabled fast string operatio=
ns
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Exception: AE_BAD_PARAME=
TER, Returned by Handler for [EmbeddedControl] (20130117/evregion-286)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_SB_.PCI0.LPC_.EC__.LPMD] (Node f202a438), AE_BAD_PARAME=
TER (20130117/psparse-537)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_PR_.CPU0._PPC] (Node f2060438), AE_BAD_PARAMETER (20130=
117/psparse-537)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_PR_.CPU1._PPC] (Node f2060930), AE_BAD_PARAMETER (20130=
117/psparse-537)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Exception: AE_BAD_PARAME=
TER, Evaluating _PPC (20130117/processor_perflib-140)
2013-05-09T22:49:43.736+02:00 n22 kernel: CPU1 is up
2013-05-09T22:49:43.736+02:00 n22 kernel: smpboot: Booting Node 0 Proce=
ssor 2 APIC 0x2
2013-05-09T22:49:43.736+02:00 n22 kernel: Initializing CPU#2
2013-05-09T22:49:43.736+02:00 n22 kernel: Disabled fast string operatio=
ns
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Exception: AE_BAD_PARAME=
TER, Returned by Handler for [EmbeddedControl] (20130117/evregion-286)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_SB_.PCI0.LPC_.EC__.LPMD] (Node f202a438), AE_BAD_PARAME=
TER (20130117/psparse-537)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_PR_.CPU0._PPC] (Node f2060438), AE_BAD_PARAMETER (20130=
117/psparse-537)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_PR_.CPU2._PPC] (Node f2060b70), AE_BAD_PARAMETER (20130=
117/psparse-537)
2013-05-09T22:49:43.736+02:00 n22 kernel: ACPI Exception: AE_BAD_PARAME=
TER, Evaluating _PPC (20130117/processor_perflib-140)
2013-05-09T22:49:43.736+02:00 n22 kernel: CPU2 is up
2013-05-09T22:49:43.736+02:00 n22 kernel: smpboot: Booting Node 0 Proce=
ssor 3 APIC 0x3
2013-05-09T22:49:43.737+02:00 n22 kernel: Initializing CPU#3
2013-05-09T22:49:43.737+02:00 n22 kernel: Disabled fast string operatio=
ns
2013-05-09T22:49:43.737+02:00 n22 kernel: ACPI Exception: AE_BAD_PARAME=
TER, Returned by Handler for [EmbeddedControl] (20130117/evregion-286)
2013-05-09T22:49:43.737+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_SB_.PCI0.LPC_.EC__.LPMD] (Node f202a438), AE_BAD_PARAME=
TER (20130117/psparse-537)
2013-05-09T22:49:43.737+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_PR_.CPU0._PPC] (Node f2060438), AE_BAD_PARAMETER (20130=
117/psparse-537)
2013-05-09T22:49:43.737+02:00 n22 kernel: ACPI Error: Method parse/exec=
ution failed [\_PR_.CPU3._PPC] (Node f2060b10), AE_BAD_PARAMETER (20130=
117/psparse-537)
2013-05-09T22:49:43.737+02:00 n22 kernel: ACPI Exception: AE_BAD_PARAME=
TER, Evaluating _PPC (20130117/processor_perflib-140)
2013-05-09T22:49:43.737+02:00 n22 kernel: CPU3 is up
2013-05-09T22:49:43.737+02:00 n22 kernel: ACPI: Waking up from system s=
leep state S4
2013-05-09T22:49:43.737+02:00 n22 kernel: thinkpad_acpi: EC reports tha=
t Thermal Table has changed
2013-05-09T22:49:43.738+02:00 n22 kernel: PM: noirq thaw of devices com=
plete after 0.138 msecs
2013-05-09T22:49:43.738+02:00 n22 kernel: PM: early thaw of devices com=
plete after 0.054 msecs
2013-05-09T22:49:43.738+02:00 n22 kernel: [drm] Wrong MCH_SSKPD value: =
0x16040307
2013-05-09T22:49:43.738+02:00 n22 kernel: [drm] This can cause pipe und=
erruns and display issues.
2013-05-09T22:49:43.738+02:00 n22 kernel: [drm] Please upgrade your BIO=
S to fix this.
2013-05-09T22:49:43.738+02:00 n22 kernel: e1000e 0000:00:19.0: setting =
latency timer to 64
2013-05-09T22:49:43.738+02:00 n22 kernel: e1000e 0000:00:19.0: irq 41 f=
or MSI/MSI-X
2013-05-09T22:49:43.738+02:00 n22 kernel: snd_hda_intel 0000:00:1b.0: i=
rq 43 for MSI/MSI-X
2013-05-09T22:49:43.738+02:00 n22 kernel: ahci 0000:00:1f.2: setting la=
tency timer to 64
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1: SATA link up 3.0 Gbps (=
SStatus 123 SControl 300)
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: ACPI cmd ef/02:00:00=
:00:00:a0 (SET FEATURES) succeeded
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: ACPI cmd f5/00:00:00=
:00:00:a0 (SECURITY FREEZE LOCK) filtered out
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: ACPI cmd ef/10:03:00=
:00:00:a0 (SET FEATURES) filtered out
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: ACPI cmd ef/02:00:00=
:00:00:a0 (SET FEATURES) succeeded
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: ACPI cmd f5/00:00:00=
:00:00:a0 (SECURITY FREEZE LOCK) filtered out
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: ACPI cmd ef/10:03:00=
:00:00:a0 (SET FEATURES) filtered out
2013-05-09T22:49:43.738+02:00 n22 kernel: ata1.00: configured for UDMA/=
100
2013-05-09T22:49:43.738+02:00 n22 kernel: kthreadd: page allocation fai=
lure: order:1, mode:0x300010
2013-05-09T22:49:43.738+02:00 n22 kernel: Pid: 2, comm: kthreadd Not ta=
inted 3.9.1 #8
2013-05-09T22:49:43.738+02:00 n22 kernel: Call Trace:
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c10d9c5f>] warn_alloc_faile=
d+0xbf/0x100
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c10dc70b>] __alloc_pages_no=
demask+0x5cb/0x7d0
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c1032ba3>] copy_process+0x1=
03/0x10c0
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c1033c3e>] do_fork+0x9e/0x2=
b0
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c1063690>] ? default_wake_f=
unction+0x10/0x20
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c1033e7d>] kernel_thread+0x=
2d/0x40
2013-05-09T22:49:43.739+02:00 n22 kernel: [<c1054cb8>] kthreadd+0xd8/0x=
110
2013-05-09T22:49:43.740+02:00 n22 kernel: [<c1487477>] ret_from_kernel_=
thread+0x1b/0x28
2013-05-09T22:49:43.740+02:00 n22 kernel: [<c1054be0>] ? kthread_create=
_on_cpu+0x60/0x60
2013-05-09T22:49:43.740+02:00 n22 kernel: Mem-Info:
2013-05-09T22:49:43.740+02:00 n22 kernel: DMA per-cpu:
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    0: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    1: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    2: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    3: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: Normal per-cpu:
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:  13
2013-05-09T22:49:43.740+02:00 n22 kernel: HighMem per-cpu:
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.740+02:00 n22 kernel: active_anon:72359 inactive_an=
on:72379 isolated_anon:0
2013-05-09T22:49:43.740+02:00 n22 kernel: active_file:22308 inactive_fi=
le:5133 isolated_file:0
2013-05-09T22:49:43.741+02:00 n22 kernel: unevictable:0 dirty:2 writeba=
ck:0 unstable:0
2013-05-09T22:49:43.741+02:00 n22 kernel: free:1132892 slab_reclaimable=
:4114 slab_unreclaimable:5347
2013-05-09T22:49:43.741+02:00 n22 kernel: mapped:17714 shmem:96000 page=
tables:1619 bounce:0
2013-05-09T22:49:43.741+02:00 n22 kernel: free_cma:0
2013-05-09T22:49:43.741+02:00 n22 kernel: DMA free:3868kB min:760kB low=
:948kB high:1140kB active_anon:0kB inactive_anon:0kB active_file:0kB in=
active_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB p=
resent:15984kB managed:15360kB mlocked:0kB dirty:0kB writeback:0kB mapp=
ed:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:16kB kernel_st=
ack:0kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_t=
mp:0kB pages_scanned:0 all_unreclaimable? yes
2013-05-09T22:49:43.741+02:00 n22 kernel: lowmem_reserve[]: 0 779 7964 =
7964
2013-05-09T22:49:43.741+02:00 n22 kernel: Normal free:46288kB min:39628=
kB low:49532kB high:59440kB active_anon:0kB inactive_anon:0kB active_fi=
le:172kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB present:894968kB managed:797924kB mlocked:0kB dirty:0kB write=
back:0kB mapped:8kB shmem:0kB slab_reclaimable:16456kB slab_unreclaimab=
le:21372kB kernel_stack:2632kB pagetables:6476kB unstable:0kB bounce:0k=
B free_cma:0kB writeback_tmp:0kB pages_scanned:29 all_unreclaimable? no
2013-05-09T22:49:43.741+02:00 n22 kernel: lowmem_reserve[]: 0 0 57485 5=
7485
2013-05-09T22:49:43.741+02:00 n22 kernel: HighMem free:4481412kB min:51=
2kB low:91872kB high:183232kB active_anon:289436kB inactive_anon:289516=
kB active_file:89060kB inactive_file:20532kB unevictable:0kB isolated(a=
non):0kB isolated(file):0kB present:7358088kB managed:7358088kB mlocked=
:0kB dirty:8kB writeback:0kB mapped:70848kB shmem:384000kB slab_reclaim=
able:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstabl=
e:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unr=
eclaimable? no
2013-05-09T22:49:43.741+02:00 n22 kernel: lowmem_reserve[]: 0 0 0 0
2013-05-09T22:49:43.742+02:00 n22 kernel: DMA: 1*4kB (R) 1*8kB (R) 1*16=
kB (R) 0*32kB 0*64kB 0*128kB 1*256kB (R) 1*512kB (R) 1*1024kB (R) 1*204=
8kB (R) 0*4096kB =3D 3868kB
2013-05-09T22:49:43.742+02:00 n22 kernel: Normal: 7726*4kB (UEM) 533*8k=
B (UEM) 111*16kB (UEM) 34*32kB (UE) 3*64kB (U) 0*128kB 0*256kB 0*512kB =
0*1024kB 0*2048kB 2*4096kB (R) =3D 46416kB
2013-05-09T22:49:43.742+02:00 n22 kernel: HighMem: 32546*4kB (UEM) 2791=
1*8kB (UEM) 25181*16kB (UEM) 16711*32kB (UEM) 9814*64kB (UEM) 4120*128k=
B (UEM) 2163*256kB (UEM) 1165*512kB (UEM) 718*1024kB (M) 49*2048kB (M) =
12*4096kB (MR) =3D 4481520kB
2013-05-09T22:49:43.742+02:00 n22 kernel: 123373 total pagecache pages
2013-05-09T22:49:43.742+02:00 n22 kernel: 0 pages in swap cache
2013-05-09T22:49:43.742+02:00 n22 kernel: Swap cache stats: add 0, dele=
te 0, find 0/0
2013-05-09T22:49:43.742+02:00 n22 kernel: Free swap  =3D 9767516kB
2013-05-09T22:49:43.742+02:00 n22 kernel: Total swap =3D 9767516kB
2013-05-09T22:49:43.742+02:00 n22 kernel: 2221567 pages RAM
2013-05-09T22:49:43.742+02:00 n22 kernel: 1993218 pages HighMem
2013-05-09T22:49:43.742+02:00 n22 kernel: 178200 pages reserved
2013-05-09T22:49:43.742+02:00 n22 kernel: 388922 pages shared
2013-05-09T22:49:43.742+02:00 n22 kernel: 856482 pages non-shared
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2: SATA link up 1.5 Gbps (=
SStatus 113 SControl 300)
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2.00: ACPI cmd e3/00:1f:00=
:00:00:a0 (IDLE) succeeded
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2.00: ACPI cmd e3/00:02:00=
:00:00:a0 (IDLE) succeeded
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2.00: ACPI cmd ef/10:03:00=
:00:00:a0 (SET FEATURES) filtered out
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2.00: ACPI cmd e3/00:1f:00=
:00:00:a0 (IDLE) succeeded
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2.00: ACPI cmd e3/00:02:00=
:00:00:a0 (IDLE) succeeded
2013-05-09T22:49:43.742+02:00 n22 kernel: ata2.00: ACPI cmd ef/10:03:00=
:00:00:a0 (SET FEATURES) filtered out
2013-05-09T22:49:43.743+02:00 n22 kernel: ata2.00: configured for UDMA/=
33
2013-05-09T22:49:43.743+02:00 n22 kernel: ata4: SATA link down (SStatus=
 0 SControl 300)
2013-05-09T22:49:43.743+02:00 n22 kernel: kthreadd: page allocation fai=
lure: order:1, mode:0x300010
2013-05-09T22:49:43.743+02:00 n22 kernel: Pid: 2, comm: kthreadd Not ta=
inted 3.9.1 #8
2013-05-09T22:49:43.743+02:00 n22 kernel: Call Trace:
2013-05-09T22:49:43.743+02:00 n22 kernel: [<c10d9c5f>] warn_alloc_faile=
d+0xbf/0x100
2013-05-09T22:49:43.743+02:00 n22 kernel: [<c10dc70b>] __alloc_pages_no=
demask+0x5cb/0x7d0
2013-05-09T22:49:43.743+02:00 n22 kernel: [<c1032ba3>] copy_process+0x1=
03/0x10c0
2013-05-09T22:49:43.743+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.743+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c1033c3e>] do_fork+0x9e/0x2=
b0
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c1063690>] ? default_wake_f=
unction+0x10/0x20
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c1033e7d>] kernel_thread+0x=
2d/0x40
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c1054cb8>] kthreadd+0xd8/0x=
110
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c1487477>] ret_from_kernel_=
thread+0x1b/0x28
2013-05-09T22:49:43.744+02:00 n22 kernel: [<c1054be0>] ? kthread_create=
_on_cpu+0x60/0x60
2013-05-09T22:49:43.744+02:00 n22 kernel: Mem-Info:
2013-05-09T22:49:43.744+02:00 n22 kernel: DMA per-cpu:
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    0: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    1: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    2: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    3: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.744+02:00 n22 kernel: Normal per-cpu:
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:  31
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:  13
2013-05-09T22:49:43.744+02:00 n22 kernel: HighMem per-cpu:
2013-05-09T22:49:43.744+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.745+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.745+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.745+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.745+02:00 n22 kernel: active_anon:72359 inactive_an=
on:72391 isolated_anon:0
2013-05-09T22:49:43.745+02:00 n22 kernel: active_file:22232 inactive_fi=
le:5138 isolated_file:0
2013-05-09T22:49:43.745+02:00 n22 kernel: unevictable:0 dirty:2 writeba=
ck:0 unstable:0
2013-05-09T22:49:43.745+02:00 n22 kernel: free:1132920 slab_reclaimable=
:4098 slab_unreclaimable:5340
2013-05-09T22:49:43.745+02:00 n22 kernel: mapped:17714 shmem:96016 page=
tables:1619 bounce:0
2013-05-09T22:49:43.745+02:00 n22 kernel: free_cma:0
2013-05-09T22:49:43.745+02:00 n22 kernel: DMA free:3868kB min:760kB low=
:948kB high:1140kB active_anon:0kB inactive_anon:0kB active_file:0kB in=
active_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB p=
resent:15984kB managed:15360kB mlocked:0kB dirty:0kB writeback:0kB mapp=
ed:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:16kB kernel_st=
ack:0kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_t=
mp:0kB pages_scanned:0 all_unreclaimable? yes
2013-05-09T22:49:43.746+02:00 n22 kernel: lowmem_reserve[]: 0 779 7964 =
7964
2013-05-09T22:49:43.746+02:00 n22 kernel: Normal free:46292kB min:39628=
kB low:49532kB high:59440kB active_anon:0kB inactive_anon:0kB active_fi=
le:32kB inactive_file:84kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB present:894968kB managed:797924kB mlocked:0kB dirty:0kB write=
back:0kB mapped:8kB shmem:0kB slab_reclaimable:16392kB slab_unreclaimab=
le:21344kB kernel_stack:2632kB pagetables:6476kB unstable:0kB bounce:0k=
B free_cma:0kB writeback_tmp:0kB pages_scanned:58 all_unreclaimable? no
2013-05-09T22:49:43.746+02:00 n22 kernel: lowmem_reserve[]: 0 0 57485 5=
7485
2013-05-09T22:49:43.746+02:00 n22 kernel: HighMem free:4481520kB min:51=
2kB low:91872kB high:183232kB active_anon:289436kB inactive_anon:289564=
kB active_file:88896kB inactive_file:20468kB unevictable:0kB isolated(a=
non):0kB isolated(file):0kB present:7358088kB managed:7358088kB mlocked=
:0kB dirty:8kB writeback:0kB mapped:70848kB shmem:384064kB slab_reclaim=
able:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstabl=
e:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unr=
eclaimable? no
2013-05-09T22:49:43.746+02:00 n22 kernel: lowmem_reserve[]: 0 0 0 0
2013-05-09T22:49:43.746+02:00 n22 kernel: DMA: 1*4kB (R) 1*8kB (R) 1*16=
kB (R) 0*32kB 0*64kB 0*128kB 1*256kB (R) 1*512kB (R) 1*1024kB (R) 1*204=
8kB (R) 0*4096kB =3D 3868kB
2013-05-09T22:49:43.746+02:00 n22 kernel: Normal: 7695*4kB (UEM) 533*8k=
B (UEM) 111*16kB (UEM) 34*32kB (UE) 3*64kB (U) 0*128kB 0*256kB 0*512kB =
0*1024kB 0*2048kB 2*4096kB (R) =3D 46292kB
2013-05-09T22:49:43.746+02:00 n22 kernel: HighMem: 32546*4kB (UEM) 2791=
1*8kB (UEM) 25181*16kB (UEM) 16711*32kB (UEM) 9814*64kB (UEM) 4120*128k=
B (UEM) 2163*256kB (UEM) 1165*512kB (UEM) 718*1024kB (M) 49*2048kB (M) =
12*4096kB (MR) =3D 4481520kB
2013-05-09T22:49:43.746+02:00 n22 kernel: 123386 total pagecache pages
2013-05-09T22:49:43.746+02:00 n22 kernel: 0 pages in swap cache
2013-05-09T22:49:43.747+02:00 n22 kernel: Swap cache stats: add 0, dele=
te 0, find 0/0
2013-05-09T22:49:43.747+02:00 n22 kernel: Free swap  =3D 9767516kB
2013-05-09T22:49:43.747+02:00 n22 kernel: Total swap =3D 9767516kB
2013-05-09T22:49:43.747+02:00 n22 kernel: 2221567 pages RAM
2013-05-09T22:49:43.747+02:00 n22 kernel: 1993218 pages HighMem
2013-05-09T22:49:43.747+02:00 n22 kernel: 178200 pages reserved
2013-05-09T22:49:43.747+02:00 n22 kernel: 388922 pages shared
2013-05-09T22:49:43.747+02:00 n22 kernel: 856482 pages non-shared
2013-05-09T22:49:43.747+02:00 n22 kernel: ata5: SATA link down (SStatus=
 0 SControl 300)
2013-05-09T22:49:43.747+02:00 n22 kernel: PM: thaw of devices complete =
after 940.796 msecs
2013-05-09T22:49:43.747+02:00 n22 kernel: PM: writing image.
2013-05-09T22:49:43.747+02:00 n22 kernel: [drm] Enabling RC6 states: RC=
6 on, RC6p on, RC6pp on
2013-05-09T22:49:43.747+02:00 n22 kernel: e1000e: enp0s25 NIC Link is U=
p 100 Mbps Full Duplex, Flow Control: None
2013-05-09T22:49:43.747+02:00 n22 kernel: kthreadd: page allocation fai=
lure: order:1, mode:0x300010
2013-05-09T22:49:43.747+02:00 n22 kernel: Pid: 2, comm: kthreadd Not ta=
inted 3.9.1 #8
2013-05-09T22:49:43.747+02:00 n22 kernel: Call Trace:
2013-05-09T22:49:43.747+02:00 n22 kernel: [<c10d9c5f>] warn_alloc_faile=
d+0xbf/0x100
2013-05-09T22:49:43.747+02:00 n22 kernel: [<c10dc70b>] __alloc_pages_no=
demask+0x5cb/0x7d0
2013-05-09T22:49:43.747+02:00 n22 kernel: [<c1032ba3>] copy_process+0x1=
03/0x10c0
2013-05-09T22:49:43.747+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c1033c3e>] do_fork+0x9e/0x2=
b0
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c1063690>] ? default_wake_f=
unction+0x10/0x20
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c10548b0>] ? flush_kthread_=
work+0xd0/0xd0
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c1033e7d>] kernel_thread+0x=
2d/0x40
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c1054cb8>] kthreadd+0xd8/0x=
110
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c1487477>] ret_from_kernel_=
thread+0x1b/0x28
2013-05-09T22:49:43.748+02:00 n22 kernel: [<c1054be0>] ? kthread_create=
_on_cpu+0x60/0x60
2013-05-09T22:49:43.748+02:00 n22 kernel: Mem-Info:
2013-05-09T22:49:43.748+02:00 n22 kernel: DMA per-cpu:
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    0: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    1: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    2: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    3: hi:    0, btch:   1=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: Normal per-cpu:
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:  30
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:  30
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:  13
2013-05-09T22:49:43.749+02:00 n22 kernel: HighMem per-cpu:
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    0: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    1: hi:  186, btch:  31=
 usd:   3
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    2: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: CPU    3: hi:  186, btch:  31=
 usd:   0
2013-05-09T22:49:43.749+02:00 n22 kernel: active_anon:72359 inactive_an=
on:72391 isolated_anon:0
2013-05-09T22:49:43.749+02:00 n22 kernel: active_file:22232 inactive_fi=
le:5138 isolated_file:0
2013-05-09T22:49:43.749+02:00 n22 kernel: unevictable:0 dirty:2 writeba=
ck:0 unstable:0
2013-05-09T22:49:43.749+02:00 n22 kernel: free:1132672 slab_reclaimable=
:4098 slab_unreclaimable:5340
2013-05-09T22:49:43.749+02:00 n22 kernel: mapped:17714 shmem:96016 page=
tables:1619 bounce:0
2013-05-09T22:49:43.749+02:00 n22 kernel: free_cma:0
2013-05-09T22:49:43.750+02:00 n22 kernel: DMA free:3868kB min:760kB low=
:948kB high:1140kB active_anon:0kB inactive_anon:0kB active_file:0kB in=
active_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB p=
resent:15984kB managed:15360kB mlocked:0kB dirty:0kB writeback:0kB mapp=
ed:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:16kB kernel_st=
ack:0kB pagetables:0kB unstable:0kB bounce:0kB free_cma:0kB writeback_t=
mp:0kB pages_scanned:0 all_unreclaimable? yes
2013-05-09T22:49:43.750+02:00 n22 kernel: lowmem_reserve[]: 0 779 7964 =
7964
2013-05-09T22:49:43.750+02:00 n22 kernel: Normal free:46168kB min:39628=
kB low:49532kB high:59440kB active_anon:0kB inactive_anon:0kB active_fi=
le:32kB inactive_file:84kB unevictable:0kB isolated(anon):0kB isolated(=
file):0kB present:894968kB managed:797924kB mlocked:0kB dirty:0kB write=
back:0kB mapped:8kB shmem:0kB slab_reclaimable:16392kB slab_unreclaimab=
le:21344kB kernel_stack:2632kB pagetables:6476kB unstable:0kB bounce:0k=
B free_cma:0kB writeback_tmp:0kB pages_scanned:87 all_unreclaimable? no
2013-05-09T22:49:43.750+02:00 n22 kernel: lowmem_reserve[]: 0 0 57485 5=
7485
2013-05-09T22:49:43.750+02:00 n22 kernel: HighMem free:4480652kB min:51=
2kB low:91872kB high:183232kB active_anon:289436kB inactive_anon:289564=
kB active_file:88896kB inactive_file:20468kB unevictable:0kB isolated(a=
non):0kB isolated(file):0kB present:7358088kB managed:7358088kB mlocked=
:0kB dirty:8kB writeback:0kB mapped:70848kB shmem:384064kB slab_reclaim=
able:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstabl=
e:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unr=
eclaimable? no
2013-05-09T22:49:43.750+02:00 n22 kernel: lowmem_reserve[]: 0 0 0 0
2013-05-09T22:49:43.750+02:00 n22 kernel: DMA: 1*4kB (R) 1*8kB (R) 1*16=
kB (R) 0*32kB 0*64kB 0*128kB 1*256kB (R) 1*512kB (R) 1*1024kB (R) 1*204=
8kB (R) 0*4096kB =3D 3868kB
2013-05-09T22:49:43.750+02:00 n22 kernel: Normal: 7664*4kB (UEM) 533*8k=
B (UEM) 111*16kB (UEM) 34*32kB (UE) 3*64kB (U) 0*128kB 0*256kB 0*512kB =
0*1024kB 0*2048kB 2*4096kB (R) =3D 46168kB
2013-05-09T22:49:43.750+02:00 n22 kernel: HighMem: 32329*4kB (UEM) 2791=
1*8kB (UEM) 25181*16kB (UEM) 16711*32kB (UEM) 9814*64kB (UEM) 4120*128k=
B (UEM) 2163*256kB (UEM) 1165*512kB (UEM) 718*1024kB (M) 49*2048kB (M) =
12*4096kB (MR) =3D 4480652kB
2013-05-09T22:49:43.750+02:00 n22 kernel: 123386 total pagecache pages
2013-05-09T22:49:43.751+02:00 n22 kernel: 0 pages in swap cache
2013-05-09T22:49:43.751+02:00 n22 kernel: Swap cache stats: add 0, dele=
te 0, find 0/0
2013-05-09T22:49:43.751+02:00 n22 kernel: Free swap  =3D 9767508kB
2013-05-09T22:49:43.751+02:00 n22 kernel: Total swap =3D 9767516kB
2013-05-09T22:49:43.751+02:00 n22 kernel: 2221567 pages RAM
2013-05-09T22:49:43.751+02:00 n22 kernel: 1993218 pages HighMem
2013-05-09T22:49:43.751+02:00 n22 kernel: 178200 pages reserved
2013-05-09T22:49:43.751+02:00 n22 kernel: 388922 pages shared
2013-05-09T22:49:43.751+02:00 n22 kernel: 856698 pages non-shared
2013-05-09T22:49:43.751+02:00 n22 kernel: PM: Cannot start compression =
threads
2013-05-09T22:49:43.751+02:00 n22 kernel: Restarting tasks ... done.
2013-05-09T22:49:43.751+02:00 n22 kernel: PM: Basic memory bitmaps free=
d
2013-05-09T22:49:43.751+02:00 n22 kernel: video LNXVIDEO:00: Restoring =
backlight state
2013-05-09T22:49:43.751+02:00 n22 kernel: thinkpad_acpi: EC reports tha=
t Thermal Table has changed
2013-05-09T22:49:45.000+02:00 n22 logger: ACPI event : ibm/hotkey HKEY =
00000080 00006030
2013-05-09T22:49:45.000+02:00 n22 logger: ACPI event : ibm/hotkey HKEY =
00000080 00006030
2013-05-09T22:49:47.886+02:00 n22 kernel: ata1.00: configured for UDMA/=
100
2013-05-09T22:49:47.886+02:00 n22 kernel: ata1: EH complete
2013-05-09T22:49:47.886+02:00 n22 kernel: sd 0:0:0:0: [sda] Write cache=
: disabled, read cache: enabled, doesn't support DPO or FUA

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
