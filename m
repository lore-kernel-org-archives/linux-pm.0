Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119553;
	b=tx39KNH8IkXo5iwgjBPbpT4PFMTtNN8PKAjpk606UtsZ0l/cEG/Uk/ixr0zJX2IIjIG8
	 z64UCw0vvee3iHn4BnPDwXh87JYWoeheVUqu1hQqDJHgVwUWMKfi2gjJKBe+kBjBSFTBM
	 UyXtJ9d++txlXW557W9xhI+m9VFDdtf1LhXO5AzYtyPX3ygu1FY//nhqzS/+pzfsI/Uz0
	 CZn5AKtSXrEOP4dTm3pW07rrsagcOJArFk4hCgzbzdnX2GkHseqdo+b6NSc7fw+v9iAR+
	 EQDXhtg74bO5ynkvw6124nFek20kQYcaxuVOP5equnhFJ2tGL1TdQISiqlkIKsqcoQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=OIiwtlDAWEF0S0a7OK3xLIOeQMogTRMj2l95NJB/7Kw=;
	b=u7hufC2z1v2bHlEzYwhQMhLFqD0s45qj0d9w1RJzGUMokKcrUGOIGtYtYI0zLvBwVogv
	 o9dQHD2ULiLNPhCZmP86e9SAA81NyTMjAvniUOimkiV3W0pTbDO0XnaWBcopW9EITGq3V
	 dyxGevVarOVMaUrMgQf2izlCEyu7pUd/Z0IIpjuiG/uI7B8xIBv6v/sNtSA5WYTULQ56U
	 0nW+5a2LTBZzcircbaLZkhxKgqvrojNIao7Suv9edNmkjWVjM1VefFG0OvuZzcb+J1IFG
	 f52VoNc5ng7nGbyOzyzNvIPlUkTplD+ghenjwi/mQYmS6KWFYHu6eOkzNWcuYcFllMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=og44u7RE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3764606A32A;
	Thu, 19 Nov 2026 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=og44u7RE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5D01F000D3;
	Thu, 19 Nov 2026 20:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119553;
	bh=OIiwtlDAWEF0S0a7OK3xLIOeQMogTRMj2l95NJB/7Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=og44u7REZfyqmUMyOCIPOZmHiaJMHkPIFtA9SK5BcktjL7bmjjpFuX2ujqcoeMpFs
	 i68lrX+Pp/6+48P8joCw8kJQmEe3BnhSJkOKDPQq+sdQCZbLVxMhZQN6VOVSkVTxsi
	 N3Dnnr+/M1Vlni36cHY6mlF+9CwydIwWZ11jOMFAEedKsgHQ1H2sfB/SS6W/0uq14T
	 9xXg1infIxwUMdupupQFFd/4L6IDSFBRAjI3wKdB5yXyszWE807UoCQGlrmx0UknkA
	 3y3uLLeuhLJxwa3CoU6AQl4QwukmzXs9rrjqgeEQqVgZJbUu9QQYp1tjkbPqp1Aj8R
	 FGUiOYuqtJI0g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v1 2/4] PM: runtime: Drop space characters preceding labels
Date: Thu, 19 Nov 2026 21:17:08 +0100
Message-ID: <3453847.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1978814.tdWV9SEqCh@rafael.j.wysocki>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Drop space characters preceding labels from the core runtime PM code.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 02e7b4953c38..5a0b4600c244 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -566,7 +566,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	dev->power.idle_notification = false;
 	wake_up_all(&dev->power.wait_queue);
 
- out:
+out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
 	if (retval)
 		return retval;
@@ -604,7 +604,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	trace_rpm_suspend(dev, rpmflags);
 
- repeat:
+repeat:
 	retval = rpm_check_suspend_allowed(dev);
 	if (retval < 0)
 		goto out;	/* Conditions are wrong. */
@@ -713,7 +713,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	dev_pm_enable_wake_irq_complete(dev);
 
- no_callback:
+no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
 
@@ -752,12 +752,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 		spin_lock_irq(&dev->power.lock);
 	}
 
- out:
+out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
 
 	return retval;
 
- fail:
+fail:
 	dev_pm_disable_wake_irq_check(dev, true);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
@@ -807,7 +807,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	trace_rpm_resume(dev, rpmflags);
 
- repeat:
+repeat:
 	if (dev->power.runtime_error) {
 		retval = -EINVAL;
 	} else if (dev->power.disable_depth > 0) {
@@ -947,7 +947,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 		goto repeat;
 	}
- skip_parent:
+skip_parent:
 
 	if (dev->power.no_callbacks)
 		goto no_callback;	/* Assume success. */
@@ -963,7 +963,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		pm_runtime_cancel_pending(dev);
 		dev_pm_enable_wake_irq_check(dev, false);
 	} else {
- no_callback:
+no_callback:
 		__update_runtime_status(dev, RPM_ACTIVE);
 		pm_runtime_mark_last_busy(dev);
 		if (parent)
@@ -974,7 +974,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	if (retval >= 0)
 		rpm_idle(dev, RPM_ASYNC);
 
- out:
+out:
 	if (parent && !dev->power.irq_safe) {
 		spin_unlock_irq(&dev->power.lock);
 
@@ -1026,7 +1026,7 @@ static void pm_runtime_work(struct work_struct *work)
 		break;
 	}
 
- out:
+out:
 	spin_unlock_irq(&dev->power.lock);
 }
 
@@ -1095,7 +1095,7 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	dev->power.timer_autosuspends = 0;
 	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
 
- out:
+out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
@@ -1419,12 +1419,12 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		}
 	}
 
- out_set:
+out_set:
 	__update_runtime_status(dev, status);
 	if (!error)
 		dev->power.runtime_error = 0;
 
- out:
+out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	if (notify_parent)
@@ -1578,7 +1578,7 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 		dev->power.last_status = dev->power.runtime_status;
 	}
 
- out:
+out:
 	spin_unlock_irq(&dev->power.lock);
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_disable);
@@ -1710,7 +1710,7 @@ void pm_runtime_forbid(struct device *dev)
 	atomic_inc(&dev->power.usage_count);
 	rpm_resume(dev, 0);
 
- out:
+out:
 	spin_unlock_irq(&dev->power.lock);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_forbid);
@@ -1742,7 +1742,7 @@ void pm_runtime_allow(struct device *dev)
 	else if (ret > 0)
 		trace_rpm_usage(dev, RPM_AUTO | RPM_ASYNC);
 
- out:
+out:
 	spin_unlock_irq(&dev->power.lock);
 }
 EXPORT_SYMBOL_GPL(pm_runtime_allow);
-- 
2.51.0




