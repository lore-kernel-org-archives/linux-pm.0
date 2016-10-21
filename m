From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 0/8] PM / OPP: Multiple regulator support
Date: Fri, 21 Oct 2016 15:39:33 +0200
Message-ID: <CAJZ5v0jNJBDKq+ccHKRA6JGAOXV0qT0-k1mwAcBkCv-7JtzACw@mail.gmail.com>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32967 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933131AbcJUNjg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 09:39:36 -0400
In-Reply-To: <cover.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Mark Brown <broonie@kernel.org>

On Thu, Oct 20, 2016 at 10:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> Some platforms (like TI) have complex DVFS configuration for CPU
> devices, where multiple regulators are required to be configured to
> change DVFS state of the device. This was explained well by Nishanth
> earlier [1].
>
> Some thoughts went into it few months back but then it all got lost. I
> am trying to get that back on track with this thread.
>
> One of the major complaints around multiple regulators case was that the
> DT isn't responsible in any way to represent the ordering in which
> multiple supplies need to be programmed, before or after frequency
> change. It was considered in this patch and such information is left to
> the platform specific OPP driver now, which can register its own
> opp_set_rate() callback with the OPP core and the OPP core will then
> call it during DVFS.
>
> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> and code to pass values for multiple regulators and verified that they
> are all properly read by the kernel (using debugfs interface).
>
> Though more testing on real (TI) platforms would be useful.
>
> This is rebased over: linux-next branch in the PM tree.
>
> V1->V2:
> - Ack from Rob for 1st patch
> - Moved the supplies structure to pm_opp.h (Dave)
> - Fixed an compilation warning.

I need somebody from the OPP camp to review patches [2-8/8] for me.

Thanks,
Rafael
