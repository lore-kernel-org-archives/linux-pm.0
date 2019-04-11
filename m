Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437EC10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DFE2146F
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 18:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNmdNA0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDKSRn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:17:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33654 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfDKSRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 14:17:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so5457477lfm.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pf7QbFgAhcYW1LW0/5PkllmLvAODcFP2rewRBiSGZHI=;
        b=zNmdNA0riuf18zmSkT7G9Qx0jX7jsxoGGM/+DgLaKSfnMVOvTHOMMKH9y+NmA7eA07
         0eIpvywenadsD4RjFSkCTF6GoQDu8Edwtm+CKhJ6y+PoO1+hNGcJpJ0EM4+2LUqGjwmW
         n4fU6KjMJxN75eq61398vodHLyEYfJLj/YjT9/S0gYFvr0WchaExF9Y/JYZFF/rOk2/g
         oVrI55JCqd2mZVfmwo7oDevmL1c6jh8ZhPQjZPl3g1tiwjPGhB98Ux0XboRQ9zHZ4WWh
         kkWz3Zs8LaAREk40JttskePAP145ypSMzIpBAIjlJvgZVAJVzL+uQOSeSpY1lR68Jg41
         Yiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pf7QbFgAhcYW1LW0/5PkllmLvAODcFP2rewRBiSGZHI=;
        b=snO2xzFR86VvoBtuXE/OW/hDkLBL/127Ejd4wWFtQcfJlH0xSRmP3nBYQhcu/HvCaP
         vkPsxNyT010YYLYC0yCJVMVODIz64jHiZSEtsDIWCuCwL6Fc31SdjDWTZ13GoBYNC3H+
         NZ0gaWICa0vUTH+Qebn7x1/35s+5CAniQbIGUzHv+EFfJvYHD6Ey28p37Ko85rFnBdKk
         QKrXgj0SlvU+J0PttsR04GPB8P52vaXC27vtcU3rJjQYlsZMZraZzkNroq5pi63o0xAY
         n3Z4EJ+tk0a5DJktSIBPKmNFFj3Eojih92FV2/Ue8HUlyjPs4nwL9KTgaDdXsnnQ2AGB
         QW/w==
X-Gm-Message-State: APjAAAXSbF5YK16PbsV22AePmYfFAVZeuUqSspd7v6VFLu54N/PwEggv
        OJ34HxKHrm0n1G2i+bIvunZfIQ==
X-Google-Smtp-Source: APXvYqwEGuLmkApqIn6LxQZ4v+k520TCQHVuG0cD0K4tdPNQtoJDRox1x9GFJsn1Etr6xdO4nvYxZg==
X-Received: by 2002:ac2:4ad1:: with SMTP id m17mr10432536lfp.129.1555006660332;
        Thu, 11 Apr 2019 11:17:40 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d13sm1555715lfa.40.2019.04.11.11.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:17:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v14 4/4] PM / Domains: Add genpd governor for CPUs
Date:   Thu, 11 Apr 2019 20:17:33 +0200
Message-Id: <20190411181733.21437-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411181733.Ln6Wz1wusIWtuMKrdcKVklmnFN-_MPMr3Id5VuZgUIY@z>

After some preceding changes, PM domains managed by genpd may contain
CPU devices, so idle state residency values should be taken into
account during the state selection process. [The residency value is
the minimum amount of time to be spent by a CPU (or a group of CPUs)
in an idle state in order to save more energy than could be saved
by picking up a shallower idle state.]

For this purpose, add a new genpd governor, pm_domain_cpu_gov, to be
used for selecting idle states of PM domains with CPU devices attached
either directly or through subdomains.

The new governor computes the minimum expected idle duration for all
online CPUs attached to a PM domain and its subdomains.  Next, it
finds the deepest idle state whose target residency is within the
expected idle duration and selects it as the target idle state of
the domain.

It should be noted that the minimum expected idle duration computation
is based on the closest timer event information stored in the per-CPU
variables cpuidle_devices for all of the CPUs in the domain.  That
needs to be revisited in future, as obviously there are other reasons
why a CPU may be woken up from idle.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes in v4:
	- Fix build error when CONFIG_CPU_IDLE is unset.

---
 drivers/base/power/domain_governor.c | 67 +++++++++++++++++++++++++++-
 include/linux/pm_domain.h            |  4 ++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 4d07e38a8247..7912bc957244 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -10,6 +10,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
 
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
@@ -210,8 +213,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 
-	if (!genpd->max_off_time_changed)
+	if (!genpd->max_off_time_changed) {
+		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
+	}
 
 	/*
 	 * We have to invalidate the cached results for the masters, so
@@ -236,6 +241,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		genpd->state_idx--;
 	}
 
+	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
@@ -244,6 +250,65 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 	return false;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static bool cpu_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct cpuidle_device *dev;
+	ktime_t domain_wakeup, next_hrtimer;
+	s64 idle_duration_ns;
+	int cpu, i;
+
+	/* Validate dev PM QoS constraints. */
+	if (!default_power_down_ok(pd))
+		return false;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
+		return true;
+
+	/*
+	 * Find the next wakeup for any of the online CPUs within the PM domain
+	 * and its subdomains. Note, we only need the genpd->cpus, as it already
+	 * contains a mask of all CPUs from subdomains.
+	 */
+	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		if (dev) {
+			next_hrtimer = READ_ONCE(dev->next_hrtimer);
+			if (ktime_before(next_hrtimer, domain_wakeup))
+				domain_wakeup = next_hrtimer;
+		}
+	}
+
+	/* The minimum idle duration is from now - until the next wakeup. */
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+	if (idle_duration_ns <= 0)
+		return false;
+
+	/*
+	 * Find the deepest idle state that has its residency value satisfied
+	 * and by also taking into account the power off latency for the state.
+	 * Start at the state picked by the dev PM QoS constraint validation.
+	 */
+	i = genpd->state_idx;
+	do {
+		if (idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) {
+			genpd->state_idx = i;
+			return true;
+		}
+	} while (--i >= 0);
+
+	return false;
+}
+
+struct dev_power_governor pm_domain_cpu_gov = {
+	.suspend_ok = default_suspend_ok,
+	.power_down_ok = cpu_power_down_ok,
+};
+#endif
+
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a6e251fe9deb..bc82e74560ee 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -118,6 +118,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -202,6 +203,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+#ifdef CONFIG_CPU_IDLE
+extern struct dev_power_governor pm_domain_cpu_gov;
+#endif
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
-- 
2.17.1

