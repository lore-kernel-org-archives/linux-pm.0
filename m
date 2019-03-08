From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] PM / wakeup: Clear timer.function in wakeup_source_remove()
Date: Fri,  8 Mar 2019 15:23:12 +0530
Message-ID: <40efd56ec468837baabd062f1c0b2fb748a9fc5c.1552038717.git.viresh.kumar@linaro.org>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com, yuwei3@hisilicon.com, gengyanping@hisilicon.com, peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

wakeup_source_activate() performs a check to see if the wakeup source is
registered or not. It works fine for a newly added wakeup source which
may not have been registered but fails to catch the case where a wakeup
source is unregistered as the timer.function is still valid.

Fix it by setting the timer.function to NULL from
wakeup_source_remove().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/wakeup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 18333962e3da..3699faca24af 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -206,6 +206,13 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	synchronize_srcu(&wakeup_srcu);
 
 	del_timer_sync(&ws->timer);
+
+	/*
+	 * Clear timer.function so that wakeup_source_not_registered() can
+	 * detect an unregistered wakeup source.
+	 */
+	ws->timer.function = NULL;
+
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
-- 
2.21.0.rc0.269.g1a574e7a288b
