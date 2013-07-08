From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 3/3] cpufreq: cpufreq-cpu0: clk rate-change notifiers
Date: Mon, 8 Jul 2013 09:40:54 +0530
Message-ID: <CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
References: <1373247868-21444-1-git-send-email-mturquette@linaro.org>
	<1373247868-21444-4-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:52983 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3GHEKz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2013 00:10:55 -0400
In-Reply-To: <1373247868-21444-4-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Mon, Jul 8, 2013 at 7:14 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Removes direct handling of OPP tables and voltage regulators by calling
> of_clk_cpufreq_notifier_handler, introduced by commit "clk: cpufreq
> helper for voltage scaling".
>
> In the future this can help consolidate code found across similar
> CPUfreq drivers.
>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 125 ++++++++---------------------------------
>  1 file changed, 22 insertions(+), 103 deletions(-)

Good patch, really gets lots of stuff out from cpufreq drivers.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
