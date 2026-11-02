Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649154;
	b=nxYJ71Bwywbia5Xo91XDfoFue1TIf4REgv7c1GRJ4eXHjkFihHEjBbJ+GdkbyLICHxKD
	 upWXMcJN6jcH/x07cv32Gkb2wy1tBkpRl9Lniq1rKNANGp4T3esPbKDYncbHImHFn+pcD
	 AKyy61N2xo4x2DSECH0srQBokeGV/nsALQDqvsJUK0cRtLsK/CIztpoGY312yIxHcTxov
	 k3e9Q7Hegb1SpbEi/43/jKrkBwD8EqrDQ7qeu7GozG/4qi/Kh28JRt+/pWh3t3PF3Ls+2
	 HqGDZ8cfaKQsBtQrjes0BmK2c8WIcNDhfrSI22JE6gCvyDcT0+s6CSF2wB8MQSDD17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649154;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=ydwbuayhqIRazAAgO+gWwpqXSrp++r71dhZK7a8682w=;
	b=sjNQTHVxWcbvmDeXLQ7dv4Fqn5gVoKXKblpd4UkXdz6WppGtPDpGt8KIH6mB9HloIU+4
	 4G2i28BgPiPnkPMQMYeVbJzMThz4i1Tf0E884IGS2eVbejSCiytgORBKsi52reIekxIu2
	 25kWrUudkEHhKagAvJWrPJtq4pXuRd2icvg4xlsrfsd0oaaYMGoVUBn5yQWdZq0WcTKT+
	 CvxdcY/aTAXZEyim08vxOF5ZkCcAtFA7eH/gFUb7Gyukh4qRx17aUdoGhHXDDYS1ygjmO
	 VpcDHABoje5sbSu5RExFSClPaP8dDvQS0hfsEouthJ+5qHLxR3sSzFP1sApKL7ZoQjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcC6FFjg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17521606A324
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcC6FFjg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B69C1F00A16;
	Mon,  2 Nov 2026 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649153;
	bh=ydwbuayhqIRazAAgO+gWwpqXSrp++r71dhZK7a8682w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcC6FFjgFQhYRnCQzP0C5b0go5gY20xNDlHzK3cQIW2tu0IPhQvOcAtmkCxNn/YRP
	 q8nlG7jK5t7mMWlpbtSeVh/DBwUh1zsGzchdVJE1GU/pLCfXGGl+PwOx5i2gsIaQSU
	 /qWQ1ydKyeVzfsJAeqyWRjvZMrvG4BcL6YrM4YTbkGW9UFwY+nnO2EdZ8s40UdlMiL
	 3w38h0yTHs7e4RXn/U68jgHJgS0aruDwgYo/ZkH3wD+KvCN1w0AVb1UDMrvPxSEGRi
	 1fudQpudYFXO6LH4Be3+rSW9pm9+tGccH1eLVT066JdJ5T0kMdQfLDtUyGT7GKhG8t
	 calGP8v7YnBaw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 4/4] cpufreq: Use the cpus_read_lock guard in cpufreq_suspend()
Date: Mon, 02 Nov 2026 20:51:55 +0100
Message-ID: <3459069.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5162355.31r3eYUQgx@rafael.j.wysocki>
References: <5162355.31r3eYUQgx@rafael.j.wysocki>
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

Now that cpufreq_suspended is only accessed by cpufreq_suspend()
and cpufreq_resume() and it can be set upfront in the former, rearrange
cpufreq_suspend() to use the cpus_read_lock guard and avoid using goto.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index efa663b1456f..edcab28aa1ee 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1979,12 +1979,15 @@ void cpufreq_suspend(void)
 	if (!cpufreq_driver)
 		return;
 
-	cpus_read_lock();
+	cpufreq_suspended = true;
+
 	if (!has_target() && !cpufreq_driver->suspend)
-		goto suspend;
+		return;
 
 	pr_debug("%s: Suspending Governors\n", __func__);
 
+	guard(cpus_read_lock)();
+
 	for_each_active_policy(policy) {
 		if (has_target())
 			cpufreq_suspend_policy(policy);
@@ -1993,10 +1996,6 @@ void cpufreq_suspend(void)
 			pr_err("%s: Failed to suspend driver: %s\n", __func__,
 				cpufreq_driver->name);
 	}
-
-suspend:
-	cpufreq_suspended = true;
-	cpus_read_unlock();
 }
 
 static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
-- 
2.51.0




