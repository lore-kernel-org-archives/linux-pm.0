From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/10] cpufreq: Cleanup header files included in core
Date: Sat, 3 Aug 2013 22:45:04 +0530
Message-ID: <CAKohponCtLRi1UJCN0z2hRVH=o326mtS2nUEvoi8Rf5H==vATw@mail.gmail.com>
References: <cover.1375530162.git.viresh.kumar@linaro.org>
	<fe67f3269a07123b025468214e692af573b07364.1375530162.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:40562 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3HCRPF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2013 13:15:05 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so3618258oag.29
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2013 10:15:04 -0700 (PDT)
In-Reply-To: <fe67f3269a07123b025468214e692af573b07364.1375530162.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

On 3 August 2013 17:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch intends to cleanup following issues in the header files included in
> cpufreq core layers:
> - Include headers in ascending order, so that we don't add same multiple times
>   by mistake.
> - <asm/> must be included after <linux/>, so that they override whatever they
>   need.
> - Remove unnecessary header files
> - Don't include files already included by cpufreq.h or cpufreq_governor.h
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Fixup due to compilation warning reported by Fengguang's kbuild system:
[Latest stuff pushed in my cpufreq-next branch]

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 70399ea..ccaf025 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -19,6 +19,7 @@

 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
