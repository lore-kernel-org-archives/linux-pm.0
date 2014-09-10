From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Support platforms with separate clock lines
 for each CPU
Date: Wed, 10 Sep 2014 12:12:11 +0530
Message-ID: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
References: <fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>
	<20140910082937.0780fd28@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:38116 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaIJGmM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 02:42:12 -0400
Received: by mail-oa0-f53.google.com with SMTP id eb12so12348515oac.26
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 23:42:11 -0700 (PDT)
In-Reply-To: <20140910082937.0780fd28@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>

On 10 September 2014 11:59, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> A compile time conditional does not work, as it isn't compatible with
> multiplatform: what if in the same kernel you want to support two
> platforms that use cpufreq-dt, one having a single clock for all CPUs,
> and one having one clock per CPU.

Yeah, that's a known problem. Should have mentioned this in logs.

> I'm still confused as to what is the problem with the DT binding
> surrounding this driver. Isn't it simply a matter of adding a clocks =
> <...> property to all CPUs, and that's it?
>
> Viresh told me there was an issue related to comparing the clocks in
> the driver to find out which CPUs share which clocks. But that is not a
> DT binding issue, it's an implementation detail. Since the driver is
> purely for DT platforms (as its name suggest), comparing phandles could
> work as a temporary solution. And since it's just an implementation
> detail that doesn't affect the DT binding, we could change the
> implementation later to use a proper clock API like clk_is_same(clk1,
> clk2) that would tell us if the clocks are the same.
>
> But I have probably missed some of the complexity of this.

(Couldn't give you these links yesterday as I was done for the day and
was replying from my phone (In our private chat))

https://lkml.org/lkml/2014/6/26/577
https://lkml.org/lkml/2014/7/1/565
https://lkml.org/lkml/2014/7/3/813
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275520.html

So these are few mails I could pick, specially from Mike, where he pointed
out why getting a clk-API for this is a bad idea.

--
viresh
