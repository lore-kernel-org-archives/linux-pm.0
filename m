From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol brcm_avs_cpufreq_attr static
Date: Thu, 10 Nov 2016 15:19:05 +0000
Message-ID: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34500 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934010AbcKJPTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 10:19:22 -0500
Received: by mail-pf0-f196.google.com with SMTP id y68so4558535pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 07:19:22 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
 symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index b761d54..4fda623 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -979,7 +979,7 @@ cpufreq_freq_attr_ro(brcm_avs_pmap);
 cpufreq_freq_attr_ro(brcm_avs_voltage);
 cpufreq_freq_attr_ro(brcm_avs_frequency);
 
-struct freq_attr *brcm_avs_cpufreq_attr[] = {
+static struct freq_attr *brcm_avs_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&brcm_avs_pstate,
 	&brcm_avs_mode,

