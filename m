From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V5 00/10] PM / OPP: Multiple regulator support
Date: Tue, 29 Nov 2016 13:48:49 +0100
Message-ID: <CAJZ5v0iZPy+WiUDNu2BfuS3KPtZy4DHcYyz7tT56sGiCwMDGjg@mail.gmail.com>
References: <cover.1480401041.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34361 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbcK2Msv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 07:48:51 -0500
In-Reply-To: <cover.1480401041.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Nov 29, 2016 at 7:36 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> Some platforms (like TI) have complex DVFS configuration for CPU
> devices, where multiple regulators are required to be configured to
> change DVFS state of the device. This was explained well by Nishanth
> earlier [1].
>
> One of the major complaints around multiple regulators case was that the
> DT isn't responsible in any way to represent the order in which multiple
> supplies need to be programmed, before or after a frequency change. It
> was considered in this patch and such information is left for the
> platform specific OPP driver now, which can register its own
> opp_set_rate() callback with the OPP core and the OPP core will then
> call it during DVFS.
>
> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> and code to pass values for multiple regulators and verified that they
> are all properly read by the kernel (using debugfs interface).
>
> Dave Gerlach has already tested [2] it on the real TI platforms and it
> works well for him.
>
> This is rebased over: linux-next branch in the PM tree.
>
> V4->V5:
> - Stephen boyd had some minor review comments and gave his Reviewed-by
>   tag for the rest. Only 2 patches don't have his RBY tag.
> - Individual patches contain the version history from V4 to V5.

Cool.

I'd still like to see that everyone agrees with patch [6/10] in particular.

Thanks,
Rafael
