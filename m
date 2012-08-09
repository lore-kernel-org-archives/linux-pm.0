From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: [REGRESSION] hard lockup on resume from suspend on ThinkPad T23
Date: Thu, 9 Aug 2012 18:43:28 +0200
Message-ID: <201208091843.28342.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello!

I thought I report it here =E2=80=93 although unless it rings a bell I =
won=C2=B4t=20
probably be doing much about it like a git-bisect since that machine is=
=20
slow and it could take ages=E2=80=A6

With Debian kernel 3.3.0-trunk-686-pae the machine suspends and resume =
for=20
lots of times for 30-40 days uptime and more if I let it.

With Debian kernel 3.4-trunk-686-pae as well as 3.5-trunk-686-pae tried=
=20
out today often not always the kernel locks up hard after resume. That =
is,=20
the image is read back but then when switching to graphics or shortly=20
afterwards the mouse pointer is frozen and the machine does not respond=
 to=20
ping anymore.

Graphics is ancient:

deepdance:~> lspci -nn | grep VGA
01:00.0 VGA compatible controller [0300]: S3 Inc. SuperSavage IX/C SDR=20
[5333:8c2e] (rev 05)

CPU is Mobile Intel(R) Pentium(R) III CPU - M  1133MHz, the machine has=
=20
768 MiB of RAM.

=46ilesystems are (aged) BTRFS (which contributes to the extreme slowne=
ss of=20
the machine it seems =E2=80=93 apt-get (dist-)upgrade without eatmydata=
 takes=20
long).

Kernel parameters are:

linux /vmlinuz-3.3.0-trunk-686-pae root=3D/dev/mapper/deepdance-debian =
ro=20
vga=3D791 threadirqs init=3D/bin/systemd resume=3D/dev/mapper/deepdance=
-swap


I didn=C2=B4t report this with 3.4 cause I hoped that difficult to debu=
g bug=20
would just go away with 3.5, but it seems it didn=C2=B4t. If it could j=
ust dump=20
out something useful before it crashes=E2=80=A6 I am using threadirqs s=
ince quite=20
some time on various machines, but I could try disabling it if it seems=
 to=20
be suspicious.

I am back on 3.3 right now. It doesn=C2=B4t matter that much on this ma=
chine.


Unless any brilliant ideas I might just keep it at this report. Maybe i=
t=20
rings a bell for someone who has a suggestion to try out.

I have 3.4 on ThinkPad T42 with some radeon chip and 3.4 and since some=
=20
while 3.5 on ThinkPad T520 with Intel Sandybridge graphics =E2=80=93 no=
 issues=20
there. So it only seems to affect this machine. T520 uses threadirqs, I=
=20
think the T42 as well.

Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
