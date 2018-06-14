From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 08/12] cpufreq: Add stub for cpufreq_update_policy()
Date: Thu, 14 Jun 2018 12:47:08 -0700
Message-ID: <20180614194712.102134-9-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
cpufreq_update_policy() is not among them. The throttler driver
(https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
possible throttling mechanism, but it can still be useful without
cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
driver to be built without ugly #ifdef'ery when cpufreq is disabled.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to series

 include/linux/cpufreq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..dba8c4951e2e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 	return 0;
 }
 static inline void disable_cpufreq(void) { }
+static inline void cpufreq_update_policy(unsigned int cpu) { }
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
-- 
2.18.0.rc1.242.g61856ae69a-goog
