From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq framework questions.
Date: Mon, 21 Apr 2014 10:44:14 +0530
Message-ID: <CAKohpo=yc_xRx2+Rp+1Y3U+wPSEzETYa6RKuQmM5dz7hp1hh3w@mail.gmail.com>
References: <4737A960563B524DA805CA602BE04B30724FDD3FF9@SC-VEXCH2.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:56002 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaDUFOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 01:14:15 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so3861630obc.17
        for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2014 22:14:14 -0700 (PDT)
In-Reply-To: <4737A960563B524DA805CA602BE04B30724FDD3FF9@SC-VEXCH2.marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yipeng Yao <ypyao@marvell.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On 18 April 2014 07:51, Yipeng Yao <ypyao@marvell.com> wrote:
> I=E2=80=99m a s/w engineer of Marvell and currently we meet some issu=
es when doing
> cpu frequency changing on our boards.
>
> When we doing stress test of CPUHOTPLUG + cpufreq governor changing, =
it will
> report some errors.
>
> In cpufreq.c, it calls __cpufreq_governor(policy, CPUFREQ_GOV_STOP) w=
hen we
> are doing cpufreq governor chaging. It also calls __cpufreq_governor(=
policy,
> CPUFREQ_GOV_STOP) when we are doing cpu hotplug. And it seems that th=
ere is
> no lock to protect this mutex situation. So we can see =E2=80=9CFaile=
d to stop
> governor=E2=80=9D shown as log.

This happened because Governor is already stopped and can't be stopped =
again.
And so -EBUSY is returned.

The sequence of events must be:
- Change cpufreq governor -> cpufreq_set_policy() ->
__cpufreq_governor(policy, CPUFREQ_GOV_STOP)

- CPU Hotplug in or out -> __cpufreq_governor(policy, CPUFREQ_GOV_STOP)=
=2E

And this failed with a return value of -EBUSY ..

@Rafael/Srivatsa: Should we retry indefinitely in case -EBUSY is return=
ed
there?

@Srivatsa: What will the hotplug core do with these errors?
@Rafael: subsys_interface layer doesn't check return value of add_dev()
at all, but it expects them to return errors. Should we get that fixed?

> After that, since there is sysfs maintaining work after, the sysfs no=
de
> creation/destroying action may have some more errors.

What exactly?

> So my question is, is this issue due to some wrong configuration in o=
ur
> code?

No.

> Does open source have some patches to fix this problem, is this issue=
 being
> supposed to happen?

Not yet. Which kernel are you using?

> We are so confused about this issue these days and we are eager for y=
our
> help.
>
> Thank you very much and waiting for your reply. J

--
viresh
