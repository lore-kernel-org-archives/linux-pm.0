From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/4] cpufreq: Add per policy governor-init/exit infrastructure
Date: Fri, 22 Feb 2013 08:01:00 +0530
Message-ID: <CAKohpokTL7DDy2aonWfFmQpQzUtLoxx2zkxSUdj3QapvzxU0=A@mail.gmail.com>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
	<ece24bb874ad1834fc43b83f053b2560db8c25d3.1360568193.git.viresh.kumar@linaro.org>
	<3793606.bilcxohA80@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48693 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585Ab3BVCbC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 21:31:02 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so179133oag.19
        for <linux-pm@vger.kernel.org>; Thu, 21 Feb 2013 18:31:01 -0800 (PST)
In-Reply-To: <3793606.bilcxohA80@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com

On 22 February 2013 05:05, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Why don't you use different values here?
>
> If you need only one value, one #define should be sufficient.

This is the fixup i have for this, I will push all patches again to
cpufreq-for-3.10 branch:

----------------------------------------------

commit 4d7296fb64f2353aafad5104f0a046466d0f4ea9
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Feb 22 07:56:31 2013 +0530

    fixup! cpufreq: Add per policy governor-init/exit infrastructure
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 3b822ce..b7393b5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -183,7 +183,7 @@ static inline unsigned long cpufreq_scale(unsigned
long old, u_int div, u_int mu
 #define CPUFREQ_GOV_STOP       2
 #define CPUFREQ_GOV_LIMITS     3
 #define CPUFREQ_GOV_POLICY_INIT        4
-#define CPUFREQ_GOV_POLICY_EXIT        4
+#define CPUFREQ_GOV_POLICY_EXIT        5

 struct cpufreq_governor {
        char    name[CPUFREQ_NAME_LEN];
