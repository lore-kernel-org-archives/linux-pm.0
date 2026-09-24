Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F13F39ED;
	Thu, 24 Sep 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245361; cv=none; b=YiNYAf87CIhIVoaeQKmPpD6rbhrBigsfFjGAKCMFfHALZH9k5yVLBDeZS7sW/4XIRfbt/XnAOd9Af0/FwvA1kEj9aWZAMXciKsYnorJTds32Y+NNXhRPA0vVTemXtdkVO9sAN3qh4RlndihHnZQvgLwJzK+U+AzxpsZJK5DQCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245361; c=relaxed/simple;
	bh=lDruGgZYhg9fDThbcSRA/nI0fInXa+tw2rpCg6ELs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DudHJ4fYJlCdTUHMuiNryalmss17kCwrhAVky/MN6VWdhdjm07ewJSQoQlEcxF/FFxT02w+x3pXQsN4NddPr0zDgM78kZmORxMgB9OMuXG+C5gaDgwzppah2X5pw+rDLlN4Z5fdo28t4J7RMkD7KHMcT8WO3MY2TdWTckiRp5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=iKRjkWo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKBbM6F7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="iKRjkWo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKBbM6F7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC7037A0097;
	Thu, 24 Sep 2026 06:22:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245358; x=
	1790331758; bh=xwpW92JGbEzXtzwYPFYrQF6TWGLrLwKH/MCyMXFaCU8=; b=i
	KRjkWo0fW5wJBDAJ26EFKPqaupuLhWwlyEAh6yGlvgXhTNrLs3QfPFp9GzADgP7d
	tMeSIkXK1cUuAQ5j6WKWDXiMy3EJmAqoNKh7UfIZnbf1Dx/ywPfS0I1vebiQ7Ykf
	TlBJ8i63t97D3vtHGu4MyE2YybcN3PkkrSnRFZcO/2AeZ0SO5jvxyr/ugVJwfh2N
	/S8V+3pzzcGPPORIDdhv9oOPiMZeJ4Z14LNG3wRRVuavRWCQYumVRweMyG6CcdPt
	dgZnD9rrZfXjUEVy+3GVQ1qtDAVFPb0NlxW+BS9uL9ZB/NiR79fnDGVytzRomWjw
	ApIeDGCiLGRJHF9lIZD9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245358; x=1790331758; bh=x
	wpW92JGbEzXtzwYPFYrQF6TWGLrLwKH/MCyMXFaCU8=; b=rKBbM6F77hg3Jixhu
	7s6xll6/mF+CoYskvl+D7MHPAY16IEZ/oIxEPvn9cihzfbNhucmMprG3S/aIDXU3
	4T8dL1gNiCWpdzqOAEkZMXx9OhPyzlNrAbHTs0qX2yAyfqTYXnU06IiGD+IqPkOc
	N5AqkU1s7tW48rfPfFJQUhY29Kz+f8Qshr943lX19xzo44JiiPX15xnxuKI/aGS7
	OqWfq0D54ajx9o+fbY98z2IYZq6A4itBV5rIYafvhSfB79tXdyFHUn5yGnfFwNCi
	tqSc60VYH35gbk5hbpAon2cGUFaRebZ6rKRiO1+xFVmdgoyoYsC4BVqTkuBQa7Ap
	a4NQg==
X-ME-Sender: <xms:7vm0ajqypYjs1_SHtrwYMYMg6C3qW8-wbm7xvsxkMoQjB3Fe_kdjXA>
    <xme:7vm0atzeLBQPhr3LnnXkOBmkxcbsBO9dOYtpRJTdK30esdiYcnle463RspiukqnmC
    FhHfq28uhQGYUA1tzPUrlc_7p_uMf-jQ4fRLMB947w_aMETGV0KjlPa>
X-ME-Received: <xmr:7vm0auDp-hwRDeHOFFHu5D1bKtEDh-P2frTWb4lSfmmWmGTEifNfM2egXmxggzbxiYPikdR2SQ>
X-ME-Proxy-Cause: dmFkZTFPKKwhcsF2tVcf6J1tdoJzHIGivu3GiCcgJWp0Pt/Z9Gazphq9uGNO64qgWXMd+/
    r0Y/QC+GxAQC2Q0ieU8CUeap8kK2TKuEf79EXK3nmOyezz75bao1uY7ZOtIqBBuPshRXdM
    IOJk66Q73oMH4TFALUk5Kcv9/tV+8zmUjNu4znwNLW6QCtNjM5T8lbyMLgXah+SwAfjMDC
    rCr4sv174gNvDyZRPPY9GCenUHIgd5s2D05F8pDWC2YXojrrAeUc6Y5eDqXskNa/85NpzE
    OHpcem/V6xXRehfddSOwZh22araaf502XMhjJIeZwed46ATd8n5B6uoJ2HCgVahU0f6Ubx
    whOd0LNLSHUROlH4FTlLbnthylfxgk4+mepJQxd//EfYV7H0rGj84bHGsG3HqTfH26PlDV
    p9WVw8dzguo/vs0BUEY4seVr3h+rhzz4IDrGMOhC6/1H0RGIduPbKa/H7DChraU+mcz/+a
    RRUGFPwgcmu3/KgXtsSvkPwHyqj/+GFAFbb7QUq/ZfPnw7HRClQCc9nXnwD+Z2lGc1x0EI
    z8/Rbeyusuzyo8J6+7Ng9j+3UxsFx1ncudZdx3y/jheQ4PVwT9kR2XqGmKBcYJ8sUJn1Uw
    8aQZXpbU77T4y6kJaeAGWhhyGYHEd7oCCD3edeTFmhtdpnRy7t4C9uCDXhWw
X-ME-Proxy: <xmx:7vm0arITajPw14F_qSRjMzotAm8wIDrgGeCLgd65ZxLhvd22a_GiiA>
    <xmx:7vm0ahH9DRBYT5HGfcWQZ038BTIk9lmQ5G58aQi0oZm8iM86dRhTJw>
    <xmx:7vm0auH5gyDgI7SQYKOC3Q92qcj6ihtVCvs6Baiz9p2TV8gTxkQghw>
    <xmx:7vm0ahuxj8f5z8DcRftU3KU_pJqCB60hwldsjG0wEh3WSQsDML_jnw>
    <xmx:7vm0aqyXPJ0VgDOq7V3faO8HVaVyvhj1TLPlP2JwwVKDMP0xeXZgPf9j>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:22:29 -0400 (EDT)
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
Subject: [PATCH v14 04/15] accel/rocket: let the core suspend after a reset
Date: Thu, 24 Sep 2026 22:21:24 +1200
Message-ID: <20260924102135.92217-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_reset() drops the in-flight job's runtime PM reference with
pm_runtime_put_noidle(), which requests nothing, so the core does not
suspend until something else asks and its power domain does not cycle. On
RK3576 the domain's power-on resets the NPU bus interface; without it the
IOMMU stops answering and the job after a timeout fails.

Use pm_runtime_put_autosuspend(), as the completion path does. On a ROCK 4D
the job after a timeout goes from 0 to 128 of 128 channels correct.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bcafa89ba..996890025 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -443,12 +443,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	/*
 	 * No handler is running now, but we might still have stuck jobs. Let's
-	 * make sure the PM counters stay balanced by manually calling
-	 * pm_runtime_put_noidle().
+	 * make sure the PM counters stay balanced by putting the reference the
+	 * job took, and request idle while doing it so the core can suspend.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
 		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+			pm_runtime_put_autosuspend(core->dev);
 
 		iommu_detach_group(NULL, core->iommu_group);
 
-- 
2.43.0

