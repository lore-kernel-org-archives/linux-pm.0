Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D540F722;
	Wed, 12 Aug 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527691; cv=none; b=nqysxV37KPOEYSnzQtv+bv9x+0BZDmfyBezMnXG04lf2xdKgZxwyon/OBy5DZW4ugpY1qq8rMjeQO3vkk1R+gi+QPYmL4D/vSkWJ5GYIn0LUZesqplTWp7EudD9NEMoSWaY0U0KenEjD3WkZ96GaQ/1i3STcKAIx16faq/cCm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527691; c=relaxed/simple;
	bh=sPxh2z4Aoc1bi80XfRfZ93Hlae72rcQgRl+KQIh2pNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGn8lLCx3HPhxl/MZTLNhU30twNjAV4b9i+lOtDUb5BK99ogr+9SL2Ck06gNOsUi4GwGy1dq/WVBbz0NAawydhn667GpRZb6Z7dXJ4n33SOmFI3YoNlnOxsDU3O7Fdp+EgH5S0azZNn46p0W/RwXgcxSbxycaLNN0s8YNb5GSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=IsWCq+ym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SlWbMh4+; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="IsWCq+ym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SlWbMh4+"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 2B1C71300782;
	Wed, 12 Aug 2026 05:41:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 12 Aug 2026 05:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527689; x=
	1786531289; bh=VCaIqgm5h38tS1NOZz3rf/ZGDAWT4oH6Ksw3UTozkgQ=; b=I
	sWCq+ymMFy+pK2BEuBRWOTYDK6S3cYII4CId3Q6heNmaoONEosZxQNoBgTKXEAUN
	HgnMaABF/H6GSu4KyLg21ozBAELe9hG+SC7MgsKuClZvmAvoQDOaD58wuGBicHWH
	6Vet+EtGWrzTA+6mz8USO2aLcXwPVJwiY9U6amM4KThzVz7l5OnUtQYF2lV+Pi0t
	Teq+O19eT9AmCH4wmgMiY8lvRtKsn8wwNJ8gqt2y8o/HLgf8Eu4zgpacPFkIRv8L
	1ckI7aDo8jmZks7c2UaWmj8/27saOr1fWc9G8c8YCwasLgvfaAiwTQw4lICN0m/L
	IvhuV9xd/3LYU2zo6VlPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527689; x=1786531289; bh=V
	CaIqgm5h38tS1NOZz3rf/ZGDAWT4oH6Ksw3UTozkgQ=; b=SlWbMh4+Fyxpvj2ao
	JQI3HOduCouojbB2io9qXxkZP1U0XBbMFudgR7kEsArZenmM7X7SjpJwXHfIUeS6
	97CDjxNDJQvu/q9BCIhbjpCc/vhgbqYCmpgefMlWaEltuijyEVym4oJvOdGvTUhA
	Xby8hq6Trg4LSQrHKTcs1rqaEY4kP7eaJHP+PneD2EdasiqkwUZu7YJT5nRbz22m
	ppIp3WoqomKeMDr+Qx+HAZU17krrHrBOmPgRD4EFVjiIVjfLFZzMps2D+gTE/UAF
	rzopcQY1L8tbkT7moFupkm6RQSpnmONuDG+1pV4ANFojUNfCM4O8wZRJcMXHS9xL
	MKA9Q==
X-ME-Sender: <xms:yD98arN-A40FtT9hPRTjVVo6HMRjqluWQ1C7z1etTiT6CLwb5zvJYw>
    <xme:yD98aiHz9424hBbHT7sx_jcLnETOrZAf_hoBNrzagHYoZTFIkTij8IDZhJsvJd0Qe
    yu7CwBe9ozk60InyhDMfsPBM47Ms3u9Ya7_7JhZ3ZmJGKfKc6w3Gw>
X-ME-Received: <xmr:yD98amF3uB8O5bDXqB7WKk8dxk6WbB75Cx5zcQbQVQ3KrrEFP2iWV29lWiBh59Q2_LUmI90djg>
X-ME-Proxy-Cause: dmFkZTGwgEiQ82b/vslvxu748yQUK6wPursKF8fMIVbz67wiFGHgA47PKoO/uGXMsZMxLx
    gFPIgLOcY7P5CngkkiK3BYsM+NSvuArVGUEmY/S//Od5HX6j19/B4vsjpf5HveubJ3pf//
    pWCcY4ceqdx0GtHj0WCQ0o6J65xdr5brIk0MpFgwd1OnJb0OJtZbfDBehL90KckpJx/ici
    /427xioY7E6zKhb2nnVrNb5/eVe38u0ELJVPMEpl79CB4mXXIS+TOXwQ2vG5Pe68Rd3XXD
    xmR8fAtcy04eoj5dkZNb571/YdUoGmvjFo0tW/6wl1YthjyIcmyfW3v1C+VPOybfcM4wWP
    Tl6eyUPtJkyhWVCvNl+hTzD/pCa6fif3pxWK/mRqkkFmLLxolhf+Kxdbw1ixKiPq0y/Pir
    yG0ATqMFq8iwhhw22PoynBYi4Jz5QuGzS2u6GqG5IpsMjY2Ul/3UjRWM6dpm0kptjN8ufE
    LmFxZDquW6bcDvBcrPjRz1GW8FIufkPaypoPzYZ/VQoWKG4V5C9ymnLZ1dOt2fBwXsftYR
    yYdt97+Rnh9j2F71OtmG6GS/ghqWMqYoLF6MhwZ/1k1leSVKTPYXpTsL9aToidw28llefd
    2Bg3SGg/0i2IsActKoc/A2TXwpIG5jy/4OsoxGMuhsZaewW6qYlghvNvpEKg
X-ME-Proxy: <xmx:yD98apCVlPuUQUABFGtjRBhyxDSylSWWxalVC-NMxPZ1_qlHD356yA>
    <xmx:yD98ajm_YVoJfakxd1XHOEvdkUV4DYFiLpUfyzCeHRf1wEkKmJUrBQ>
    <xmx:yD98av6WZl3D8s06dvvtmO6uWAeNsf40Hwojrd_EtuK3w7VToA2SbQ>
    <xmx:yD98aivb6mr_ybzKnhfIhCazXCzYN5UpCFMesKqtPKM8ExA26oSvVw>
    <xmx:yD98ajQL8mmYb5J8u2f0E3PYe5EUTPVXY-FKP3Z65pIdeJvdBDhMPr_e>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:41:22 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 01/10] accel/rocket: take the completion register writes under job_lock
Date: Wed, 12 Aug 2026 21:40:56 +1200
Message-ID: <20260812094106.1391698-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE from
inside it. The two can therefore race: a completion being handled on one core
can write its zero after a submit on the same core has written its one, and
stop a task that has only just started.

Nothing in tree hits this often, because the interrupt is the only completion
path and it does not overlap its own submit, but the ordering is wrong on its
own terms.

Move both writes inside the existing scoped_guard() rather than adding a second
critical section, so stopping the block and deciding what to start next are one
atomic step.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bb77b6bf0..4c01b703e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -345,10 +345,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
 
-	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * Stopping the block belongs under the lock. hw_submit() writes
+		 * OPERATION_ENABLE too, and outside the lock this zero can land
+		 * after that one and stop a task that has only just started.
+		 */
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
 				rocket_job_hw_submit(core, core->in_flight_job);
@@ -360,6 +365,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void
-- 
2.43.0

