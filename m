From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 09 Nov 2015 12:10:25 +0000
Message-ID: <bug-103351-137361-EmQbaYVqkf@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54123 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbbKIMKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2015 07:10:32 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id DAD2A206BD
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2015 12:10:30 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id D399320747
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2015 12:10:28 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

okjwukwh@sharklasers.com changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
                 CC|                            |okjwukwh@sharklasers.c=
om

--- Comment #97 from okjwukwh@sharklasers.com ---
Using a Broadwell i7-5600U on OpenSuse Leap 42.1 may also provoke the l=
ock
elision error.

At the moment I cannot tell how libc is built; from the contents of the=
 rpms I
would guess that --enable-lock-elision is used.

Crashes so far only happen, when using a NVIDIA proprietary driver (tri=
ed
version 352* and 349* - same result). So it may be a problem with the d=
river.
But as of the [1] it should be ok when using a version < 352* which it'=
s not in
my case.

The microcode version is reported to be 0x21 so the workaround with the=
 MSI
0x13 update won't work. HLE is enabled as of /proc/cpuinfo, while TSX i=
s not
present.

Also note: It seemed to work with OpenSuse 13.2 - maybe hinting at the
libc/lock-elision support.


processor =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 3=20
vendor_id =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: GenuineIntel=20
cpu family =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 6=20
model =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 61=20
model name =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: Intel(R) Core(TM) i7-5600U C=
PU @ 2.60GHz=20
stepping =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 4=20
microcode =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 0x21=20
cpu MHz =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 2053.492=20
cache size =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 4096 KB=20
physical id =C2=A0=C2=A0=C2=A0=C2=A0: 0=20
siblings =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 4=20
core id =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 1=20
cpu cores =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 2=20
apicid =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 3=20
initial apicid =C2=A0: 3=20
fpu =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0: yes=20
fpu_exception =C2=A0=C2=A0: yes=20
cpuid level =C2=A0=C2=A0=C2=A0=C2=A0: 20=20
wp =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0: yes=20
flags =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: fpu=
 vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse
36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb r=
dtscp lm
constan
t_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmp=
erf
eagerfpu pni
 pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pd=
cm pcid
sse4_1 s
se4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand =
lahf_lm
abm 3dno
wprefetch ida arat epb pln pts dtherm intel_pt tpr_shadow vnmi flexprio=
rity ept
vpid fs
gsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx s=
map
xsaveopt=20
bugs =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
:=20
bogomips =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 5187.70=20
clflush size =C2=A0=C2=A0=C2=A0: 64=20
cache_alignment : 64=20
address sizes =C2=A0=C2=A0: 39 bits physical, 48 bits virtual=20
power management:


[1] https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DNVIDIA-SKL-=
Latest-Woes

--=20
You are receiving this mail because:
You are the assignee for the bug.