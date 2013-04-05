From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq/regulator: Handle regulators that defer probe
 with device tree bindings
Date: Fri, 5 Apr 2013 10:43:07 +0530
Message-ID: <CAKohpokiLQNp3JffxuKA5JxeL8+F3-2MK_cMv2FzcddOejQA=Q@mail.gmail.com>
References: <1365135708-23886-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:40069 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284Ab3DEFNI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Apr 2013 01:13:08 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so3315383obc.24
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2013 22:13:07 -0700 (PDT)
In-Reply-To: <1365135708-23886-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>

On 5 April 2013 09:51, Nishanth Menon <nm@ti.com> wrote:
> Currently get_regulator returns -EPROBE_DEFER in the case of regulator supply
> which have no device tree node or even if regulator which are depicted in device
> tree node is defering it's registration for valid reasons.
>
> This makes it impossible to use an regulator that registers itself after
> cpufreq-cpu0 probe is complete. The reason for the same is regulator framework
> fails to return appropriate error value when device tree binding is not actually
> present as a node.
>
> Once we fix that, we can then fix cpufreq-cpu0 to make intelligent decisions
> based on return value.
>
> Nishanth Menon (2):
>   regulator: core: return err value for regulator_get if there is no DT
>     binding
>   cpufreq: cpufreq-cpu0: defer probe when regulator is not ready
>
>  drivers/cpufreq/cpufreq-cpu0.c |   20 ++++++++++++++------
>  drivers/regulator/core.c       |    4 ++--
>  2 files changed, 16 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
