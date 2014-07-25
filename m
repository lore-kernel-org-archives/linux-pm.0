From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after
 concurrent writing to cpufreq/scaling_governor (Resend)
Date: Fri, 25 Jul 2014 10:42:49 +0200
Message-ID: <1406277769.2399.4.camel@x200t>
References: <1405522398.2348.42.camel@x200t> <1406185912.2406.3.camel@x200t>
	 <CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:51419 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759603AbaGYIm7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 04:42:59 -0400
In-Reply-To: <CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

The bug is still there. Here's my bash history, so that you can be sure=
 I checked it correctly:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git linux-git
cd linux-git/
git show 56d07db=20
git branch --contains 19c7630
git branch --contains 56d07db
git revert -n 56d07db
make oldconfig
make clean
make -j9 deb-pkg
cd ..
sudo dpkg -i linux-libc-dev_3.16.0-rc6+-2_amd64.deb
sudo dpkg -i linux-image-3.16.0-rc6+_3.16.0-rc6+-2_amd64.deb
sudo dpkg -i linux-headers-3.16.0-rc6+_3.16.0-rc6+-2_amd64.deb
sudo dpkg -i linux-firmware-image-3.16.0-rc6+_3.16.0-rc6+-2_amd64.deb
sudo update-grub2
sudo reboot

Again, I didn't get a backtrace for the error, but only this:

=2E..
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@
=2E..


Robert


Am Donnerstag, den 24.07.2014, 15:12 +0530 schrieb Viresh Kumar:
> On 24 July 2014 12:41, Robert Sch=C3=B6ne <robert.schoene@tu-dresden.=
de> wrote:
> > (Resend, because there hasn't been a reply within the last week)
>=20
> How did I miss it? Yes its in my inbox. Sorry buddy..
>=20
> > crash_governor.sh:
> > #!/bin/sh
> > # this is called concurrently via runme.sh
> > for I in `seq 1000`
> > do
> >         echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufr=
eq/scaling_governor
> >         echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpuf=
req/scaling_governor
> > done
> >
> > runme.sh:
> > #!/bin/sh
> > # run 8 concurrent instances
> > for I in `seq 8`
> > do
> >         ./crash_governor.sh &
> > done
> >
> > Just run runme.sh and crash your system :)
>=20
> Oh, yes. Quite easily I could see that happening :)
>=20
> I have pushed a fix earlier for similar issues:
> 19c7630 cpufreq: serialize calls to __cpufreq_governor()
>=20
> but was later reverted by Srivatsa:
> 56d07db cpufreq: Remove temporary fix for race between CPU hotplug an=
d
> sysfs-writes
>=20
> because we didn't thought about this usecase.
>=20
> I propose we get that back. I have tested a revert of 56d07db on
> my setup and didn't see any crash..
>=20
> Please see if that works for you as well..
>=20
> --
> viresh

--=20

Dipl.-Inf. Robert Schoene
Computer Scientist - R&D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +49 (351) 463-42483
=46ax : +49 (351) 463-37773
E-Mail: Robert.Schoene@tu-dresden.de

