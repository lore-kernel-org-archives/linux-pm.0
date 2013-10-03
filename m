From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 3 Oct 2013 15:28:48 +0530
Message-ID: <CAKohpok7yHv_fbkPM4N0vToA0=Fvi9U4eZD1_u9--3fp=weQCw@mail.gmail.com>
References: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:52272 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab3JCJ6t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 05:58:49 -0400
Received: by mail-qa0-f50.google.com with SMTP id j7so1468442qaq.9
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 02:58:48 -0700 (PDT)
In-Reply-To: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 1 October 2013 15:00, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>
> Currently clk_get_sys is used with cpu-cluster.<n> as the device id
> which is incorrect. It should be connection/consumer ID instead.
>
> It is possible to specify input clock in the cpu device node along
> with the optional clock-name. clk_get_sys can't handle that.
>
> This patch replaces clk_get_sys with clk_get to extend support for
> clocks specified in the device tree cpu node.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
