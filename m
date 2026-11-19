Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119551;
	b=sS6brdag2E0VStMDNBvOvuohvFjQywc/KS8hQ81zfyPVgw/sSRkY40st6pzfcbYGKf0u
	 sMNMxjBaAqjelQMluk7KEaFws4Dcfy5HtdcLISNXyNujh/EjxgjSHZL8dupDjob9R5WKU
	 sM5cybvzOkwIM6uEzAVeolFWhonba7gjxRC6oMOOb9+r/JIBaM+ktzUsw0DUkFi2jfswN
	 3Z9ouD8+pqO34cwI91LbJXdOEKuSXkBzNmdbnS46ecjh7+1487ZCcAMSZDsdZTncL47eM
	 s2YY3MzRHZN/SGjswsSOnSg8aJfKWKbvfaSNYmNOM9LEGCiqAMHBfq0LTGuXx3HlNbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=EBOqTXBMMEkIhNLn7L1Or4QCrpBG9kp2cepEzFzhLDw=;
	b=rkW/Ksoq5IHQb6of3oh3un+9SueGxErIdCyFhrp4o0d3cJ7BFUQV130dhuyHxTKeQwTr
	 7mLC8dYBuHvLdpIpebwCCgu3SXGmw7enxpatgeFCAufYB9K7mgNkd+xAD+bKYQxr14vtk
	 Scw+ltczg26jXuLVbRnV5hSV8C211b7OCM73eRMpLRtWJ5C4x/GK1y8bHjxdMLDrPmLwm
	 yykxgFyVjF1AtRREeJEu96H8hY6O2kTA/0vtLbEkFH7yuvHE4GmAiHW2OycnIKAXQg8F/
	 QoI4qfthyIrSHZR7LnU2kg9FC7bN9LOx85cgQQM3WFhu/5UJsLtK1UarNGKTcRAdlGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmrhHDe7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E29606A338;
	Thu, 19 Nov 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmrhHDe7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818241F000C0;
	Thu, 19 Nov 2026 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119550;
	bh=EBOqTXBMMEkIhNLn7L1Or4QCrpBG9kp2cepEzFzhLDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XmrhHDe7fNaJw7sKOOmeU+3+WpBCn2DLEs+rNAtqbQGmKXg+xcVvA2VWcZd3EZbYn
	 NaGrrRoEoMiTj2H2poLKducfNicR2FRgpkA1WerMLlmKetKbNJxgzlcN4+TCv/tP2B
	 jXckwaKh49Md/4hC+FivvKf8mJf0f7RLkeA5ZQwVdbZUe9f03evq3QJ5/FSxfRJbvP
	 CoErUuH+scvHw2pCR+tcV4Xe2a+d2qOIT4Hk34Hq+Jhm26R81tZjTGmuv1shsNZ4g4
	 DqIeAfudoCanNdlg+xJS4vCgsJWXn2CIRJ6Zlizr9xwBpZY91EgXunJNFyYlNQEc9m
	 xxlVOiC5x4dPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v1 3/4] PM: runtime: Let devices suspend after an attempted resume
Date: Thu, 19 Nov 2026 21:17:51 +0100
Message-ID: <10954171.nUPlyArG6x@rafael.j.wysocki>
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

On a successful runtime resume of a device, rpm_idle() is called by
rpm_resume(), but only if the runtime PM status of the device was not
RPM_ACTIVE when rpm_resume() was called, which is inconsistent.  For
instance, if the given device uses autosuspend, an autosuspend timer
will most likely be started for it after it has been actually resumed
by rpm_resume(), which will not happen if it is already active when it
is passed to that function.  This may lead to observable differences in
behavior going forward.

Address it by rearranging rpm_resume() to call rpm_idle() also if the
device has been active to start with.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5a0b4600c244..1a3b32e299d8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -794,7 +794,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
  * suspending (deferred_resume) or wait for it to finish.  If the RPM_ASYNC
  * flag is set then queue a resume request; otherwise run the
  * ->runtime_resume() callback directly.  Queue an idle notification for the
- * device if the resume succeeded.
+ * device if the resume succeeded or the device's runtime PM status was
+ * RPM_ACTIVE to start with.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
@@ -840,7 +841,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		 */
 		pm_runtime_mark_last_busy(dev);
 		retval = 1;
-		goto out;
+		goto success;
 	}
 
 	if (dev->power.runtime_status == RPM_RESUMING ||
@@ -971,8 +972,11 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	}
 	wake_up_all(&dev->power.wait_queue);
 
-	if (retval >= 0)
-		rpm_idle(dev, RPM_ASYNC);
+	if (retval < 0)
+		goto out;
+
+success:
+	rpm_idle(dev, RPM_ASYNC);
 
 out:
 	if (parent && !dev->power.irq_safe) {
-- 
2.51.0




