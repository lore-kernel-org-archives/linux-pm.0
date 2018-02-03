From: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v4 1/5] cpu_pm: add syscore_suspend error handling
Date: Fri,  2 Feb 2018 17:24:46 -0800
Message-ID: <20180203012450.18378-2-dbasehore@chromium.org>
References: <20180203012450.18378-1-dbasehore@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180203012450.18378-1-dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Soby.Mathew-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
will put the CPU in the correct state to resume from the failure.

Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 kernel/cpu_pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 67b02e138a47..03bcc0751a51 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -186,6 +186,9 @@ static int cpu_pm_suspend(void)
 		return ret;
 
 	ret = cpu_cluster_pm_enter();
+	if (ret)
+		cpu_pm_exit();
+
 	return ret;
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
