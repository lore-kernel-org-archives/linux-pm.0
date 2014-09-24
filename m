From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Thu, 25 Sep 2014 01:46:51 +0200
Message-ID: <1478598.DgG2vI5Y04@vostro.rjw.lan>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56125 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750793AbaIXX1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 19:27:02 -0400
In-Reply-To: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robert.schoene@tu-dresden.de, prarit@redhat.com, skannan@codeaurora.org

On Tuesday, September 09, 2014 09:46:39 AM Viresh Kumar wrote:
> This commit was earlier commited in kernel as:
> 19c7630 cpufreq: serialize calls to __cpufreq_governor()
>=20
> and was later reverted by Srivatsa:
> 56d07db cpufreq: Remove temporary fix for race between CPU hotplug an=
d sysfs-writes
>=20
> When this commit was first introduced it was written for races during=
 hotplug
> and because we got some other solution to take care of the races with=
 hotplug we
> reverted it.
>=20
> But (as I also said in the revert patch: https://lkml.org/lkml/2013/9=
/10/61)
> there are more cases where this is required.
>=20
> Recently Robert shown an instance where changing governors with multi=
ple threads
> leads to following warnings:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 2458 at drivers/cpufreq/cpufreq_governor.c:261 c=
pufreq_governor_dbs+0x6d2/0x740()
> CPU: 1 PID: 2458 Comm: tee Tainted: G           OE 3.16.0-rc6+ #1
> Hardware name: FUJITSU ESPRIMO P700/D3061-A1, BIOS V4.6.4.0 R1.12.0 f=
or D3061-A1x 07/04/2011
>  0000000000000009 ffff8800ae403b78 ffffffff8173b0bf 0000000000000000
>  ffff8800ae403bb0 ffffffff8106c82d 0000000000000000 ffff88022fa27000
>  0000000000000005 0000000000000002 ffffffff81cd5d00 ffff8800ae403bc0
> Call Trace:
>  [<ffffffff8173b0bf>] dump_stack+0x45/0x56
>  [<ffffffff8106c82d>] warn_slowpath_common+0x7d/0xa0
>  [<ffffffff8106c90a>] warn_slowpath_null+0x1a/0x20
>  [<ffffffff815e4a12>] cpufreq_governor_dbs+0x6d2/0x740
>  [<ffffffff810941fc>] ? notifier_call_chain+0x4c/0x70
>  [<ffffffff815e2757>] od_cpufreq_governor_dbs+0x17/0x20
>  [<ffffffff815dea50>] __cpufreq_governor+0xb0/0x2a0
>  [<ffffffff815ded8c>] cpufreq_set_policy+0x14c/0x2f0
>  [<ffffffff815df796>] store_scaling_governor+0x96/0xf0
>  [<ffffffff815df100>] ? cpufreq_update_policy+0x1d0/0x1d0
>  [<ffffffff815de3c9>] store+0x79/0xc0
>  [<ffffffff81245bed>] sysfs_kf_write+0x3d/0x50
>  [<ffffffff81245120>] kernfs_fop_write+0xe0/0x160
>  [<ffffffff811d00d7>] vfs_write+0xb7/0x1f0
>  [<ffffffff811d0c76>] SyS_write+0x46/0xb0
>  [<ffffffff817439ff>] tracesys+0xe1/0xe6
> ---[ end trace a2dad7e42b22c796 ]---
> BUG: unable to handle kernel NULL pointer dereference at           (n=
ull)
> IP: [<ffffffff815e4395>] cpufreq_governor_dbs+0x55/0x740
> PGD 36a05067 PUD b47df067 PMD 0
> Oops: 0000 [#1] SMP
>=20
> Robert also provided a small script to reproduce it:
> crash_governor.sh:
> for I in `seq 1000`
> do
>         echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq=
/scaling_governor
>         echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufre=
q/scaling_governor
> done
>=20
> runme.sh:
> for I in `seq 8`
> do
>         ./crash_governor.sh &
> done
>=20
> Just run runme.sh to crash your system :)
>=20
> Introduce an additional variable which would guarantee serialization =
of
> __cpufreq_governor() routine.
>=20
> Reported-and-tested-by: Robert Sch=C3=B6ne <robert.schoene@tu-dresden=
=2Ede>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
>=20
> These fixes the issues reported by Robert. There is slight change aft=
er Robert
> tested my initial patch, 'bool' is replaced by 'int' for 'governor_st=
ate'.
>=20
> Regardingn stable trees, I am not too sure. The first patch of this s=
eries was
> earlier applied on 3.12 and then was reverted quickly in the same rel=
ease.
>=20
> So, the best we can do is 3.12+.

What's the current status of this series?

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
