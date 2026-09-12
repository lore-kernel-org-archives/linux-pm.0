Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F732E128;
	Sat, 12 Sep 2026 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195926; cv=none; b=jIEDDaRl0YugbcQS2LFFoOVZO+MmhGDya1u2hCB96W9Ry3FD+Ph/dm41FjJNr5tzd1LU3l8iliuAsobH6QUc1bd/a2utrWyzttieBs52EJpCygbMFi0Mdj2MlWDLmUTWLg2lWTf3kPLSN2UAHIRuHbCZals2sIQrCHRQx1jytg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195926; c=relaxed/simple;
	bh=88FHouxIOTWiZNLtZ4sd/VrxWbIV+81Cr7r/eb3f00E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNhtTyYwKk9sdjtho0Mmj/zLGyZg3y9oA+XlgXYyrNQptu4dBr4SkMix/+IWrhJL/qdF7YaTab4bWkoR5UkgK2E75rwvtJZsE7FGv3T4EzOFHaD8M8QAEflxKg/yZyDb39Prs+5AQjp+O95ny0TN/RiUVPAQ68AE/iS7yicggWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=FXo259Pq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FpanS+M5; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FXo259Pq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FpanS+M5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A74EB7A00B7;
	Sat, 12 Sep 2026 02:52:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 12 Sep 2026 02:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789195923; x=
	1789282323; bh=n+cF16GIsW3+Z+8TyLHOWAsOJUvCToUrYBZTcA3LkCA=; b=F
	Xo259Pq3DOA4x3VIPhi8BbnQr+VExgyOUnYSqPO8gjk4Am9uxRL+9HcAH5U/62Bo
	qnjfNoDKXOrrH+8QGfFZ2+JOGCV8LGQ3BHSO/FMOMogGNkUOZ+jbDPPlIyzWBVu/
	SUJ8b/HNb9EroZqjxo6qzruzRr1+XduEs0/aZfrSH8P5lIC9gPGXa+bH42+DBjvx
	m4wGvHfVIRR3Kqq+dCJI2NUV7Ih9QaQNZsLa6AG6jk7uL78U+FDX2uMs6Cv7D3nT
	4szE7NSFwUFeslRwccq9DKqZ3wUWrAZYjKd0OvHHEZ9ecOMw6Y6wlyWa15wau3iQ
	wk9G63fzmo3bX4FVevNjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789195923; x=1789282323; bh=n
	+cF16GIsW3+Z+8TyLHOWAsOJUvCToUrYBZTcA3LkCA=; b=FpanS+M5tk0sSrrAb
	aVDJMkYZWmyHpucd5m77w1kOM5375ZidMiwi/Q5vwWgmysBMarFlARmd44QsTgKs
	mVDgEDP9lUgZ1H2yAy7IyB2EyYXWFw0cqX10OOohMmOU0LzoADpjNBzIKaqRjxyR
	vikHOLrKEdBe7TeCHLKRqf15Ma4faQLzmCqOfVXniOWysIjIZKuuFRNj3AUpiOHn
	31vmvzKUjgxM2TkumkEnW8EyCT9n3Z6SZieHzqx6K2lDE693i2XCIq3rlRuMXfT4
	YCcU+Hp9PMIKu4B0Q+jqOFTNkUkAthUGU2x06RQCHEQAtwiaDYy9Z0ZMNPcizicE
	XAX+Q==
X-ME-Sender: <xms:k_akasu73-3fqVuNm4CcE5FnQX-jeVOpZpE6RawN4PiYe-opogBNGQ>
    <xme:k_akarYFOc5uKhDuEHGDQBPut7KZVdwAVUOQW9HJBbDxx6xSFJOwXa-aTZF8q5ixJ
    7Kh19XHqoMbNXVIFRD95NEpVsenKsiju-XxrLJCs8moI2AblE04TtH0>
X-ME-Received: <xmr:k_akaiLmttDOBhYqwHpE6Mw6_DNoo0qFuCYdCjmKph4Mbkl8KhG0pim6G9RRxzwJAk6-Xyp9oA>
X-ME-Proxy-Cause: dmFkZTEPb8qUI/Bch63DUv9Os4CRaZnJidcR38w4lyHY6iaGmzqubjANrD0SeN/gjpgWtD
    9JpSgLNav7upxo5UY8BD+gTgneuYvtjdT7xUeoI37l3u3ANYgfWTUMIQPTBe+0FGjKZ893
    EmiED4E9ABLDGP636x+3BNPL+06gHQG63VHM2tKDilhH/OyX7+TagruxeFKd93pQCYj32B
    BeiQF2P6k05N47Few9BlXMbV3J128+kb4hnRL4hf+Yoc0wDQXXqOQeonbIg1B1tOCqO85x
    XB7Y9LiCcE2oZkETEXdiacCDRMuKmK7OMtWiJEvsJa8P7QUcJM2B6xHrJPAU/2XBsLk7hb
    LW4LfTP7Zdkq68MwmwIaACDlM3y/lZUL4DyZDST0DO8C87Su9xOuC/r8LQ3Vc/3/7AgZ4N
    VCp2yv52tLJGGeWpYdy2RpAgRnsLkQOqhcB5cXy7kWhc74WBf4rjUpq38oYydmvpLMBN+y
    b5rCet9H1T8s3lIo9Paeh90N+C6CbMXxDlyp045H6EHzElqY1eMF1IJ8OKmk3mq8kMNr/A
    e4atOiYHYAbFJR65q2DiLgk5tSwSsxvbT3w68wEQvviJa7cIXCcdKtBAA3X4jMmpgnmDG7
    CIZiHw235OvMylowJfGGVTs6GIj4gvZu4zrDL4X3f3A0JNo7mR+bbxjnRMQg
X-ME-Proxy: <xmx:k_akasiubLeNZBy5lvgaIMp7v7LJNF31XV3qugPPJb2f5zWjytlgkg>
    <xmx:k_akar8cQUhmlRVR4xBO7XuAjTs0zj9x3VLGNNizHUsRGpHwzaAk8Q>
    <xmx:k_akaqiCYfGWkJk6VObX8MfUoZtdg8lxuX5f55OEqjMy1vK9O1cUlQ>
    <xmx:k_akaryaOsZ8eiCAkv_kb-d6TQzz0-xIAIyLIrULPdyC-fe6dUOJdQ>
    <xmx:k_akarJ1qj9re63o56QqDQTBAw-SSZHIFlrucjpvgdtqae5mDv_oIh-x>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:51:55 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v12 05/14] accel/rocket: factor the completion tail out of the IRQ handler
Date: Sat, 12 Sep 2026 18:50:44 +1200
Message-ID: <20260912065053.1519165-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_job_handle_irq() stops the block and then either starts the job's
next task or retires the job. The second half is a step of its own and
reads better with a name, now that taking the register writes under
job_lock has moved it a level deeper inside the scoped guard.

Move it to rocket_job_next_locked(). The early return that used to leave
the handler now leaves the helper, which is the same thing here: the scoped
guard drops job_lock either way and nothing follows it.

Doing it as its own patch keeps the locking fix at the head of the series
minimal, so a bisect that stops before this one gets that fix and nothing
else. There is one caller, and no functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index b588049aa..8cffe93f6 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+/* Start the job's next task, or retire it. Caller holds job_lock. */
+static void rocket_job_next_locked(struct rocket_core *core)
+{
+	lockdep_assert_held(&core->job_lock);
+
+	if (!core->in_flight_job)
+		return;
+
+	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
+		rocket_job_hw_submit(core, core->in_flight_job);
+		return;
+	}
+
+	iommu_detach_group(NULL, iommu_group_get(core->dev));
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
-- 
2.43.0

