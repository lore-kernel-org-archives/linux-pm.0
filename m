Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121212;
	b=DM9F0KEp0rsqJgxDuTM0QPwAFbT9Cpw3n4nNEqrBJTuSrD998SO9TOSUXsnQ2OiOfj+y
	 EoOSuPm43DaXeXvWYXjKjIWkfhNcQIEDrbmoeGkpumT0jUKXWfP0DSiJ6FTZuN11wrKp7
	 N8ACu1zrM1LgLK9at/l4+DANCkLSTHLDIVzcbXRlNInT5QdwljjjFcANuy9YzrhToh/v2
	 +N6J8I72uSxfhE5KewU2Pu9bny/v18h17nzEs/aQzASAbxrMTtb66tGuorEML/AGnELrT
	 CzVbWuYcpA0EVeCNpBBSlMS5Q7s1IEXH1c35Y5GEP9v1Y/3qvX+qBG5Jj4P136SuJnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121212;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=xh4FDfpKCu1l07Q85vVWgq/0/rjVj2rTpjI3ZLXV+Vc=;
	b=JPTXi4ogbeoxIAlY8cLkAIRgpX8l/CX9+R3Vuxns7ZGKEB6hxSf7r6gTMrKl6WaeS3wl
	 MH8firygAXygvFL4mWLDFMb5SezWB7hK0lmxvC4efiuPp7xXSEk7RZKt/9v0x/fXrysNe
	 AwAtAx35xxIpCbexBfwkw0UyIokvIr0LSJPVJWD9Sw6DWIgkuGMsk5Zsegk5d8KIlcm/H
	 v+h+WWSiz1wvWIssQY/9+pkrpkWAMFeeMuw8ycAQsu0mq2sHtQCYVMMvLRAUzOf1pnUVf
	 oz6R5cj+YmUSOOoWAcrXTJELPCfF3OrU8BnklhEW3J2OF4yxWJk4iy780+UyeDCpW6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=T1db98wB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0MpJD2Y2;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2602606A320
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2602606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=T1db98wB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0MpJD2Y2
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 756F77A00D8
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:00:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 08 Nov 2026 02:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121205; x=
	1794207605; bh=xh4FDfpKCu1l07Q85vVWgq/0/rjVj2rTpjI3ZLXV+Vc=; b=T
	1db98wB92XSaeJ3Vy0yeD+OQDZS9MTgAyJ9P7A4nwqFWKBuCWREV237hjEhBJV/V
	oONrmNtvNpCsYNlt43HL8tGFRCxSvq74eB2JBzyZ1J8YCwqWnWH5mx+hZl6XMe/3
	9EhCHyOOeAIu4uBrRUF0a+c68Wktzv4fPawKEOR4dIhdMlnQ+w3CAqnljoxEAURW
	b3hpvpJ94TPvQsbfU2KaOncfTno54Xq3lhKvFYiq4lv6u7AxvhNR+TXc3tUTYhF7
	oJVQW6BxTQqIbNoUTXhDEv18XU9ECc8YwNCUJaDhbaZ61QC6JkPa8uucZ9SO44yV
	O5hgat+JYFwLRgIVTWxhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121205; x=1794207605; bh=x
	h4FDfpKCu1l07Q85vVWgq/0/rjVj2rTpjI3ZLXV+Vc=; b=0MpJD2Y2A2M02KiNW
	3e1Swp1HsZIJki7ELLy3oeDBNiWbQ0AMSN1lLoaL+fkJVVzXDaihQd6PUqTrP6sY
	nAHXT/3UGeqjWpzAMj6jN1YvVJl5kbNZocUFarhxywMlcSpalu1Y/E2P3IqslX7z
	A24VC5kZoLhdrxAHypTRoJh+xWtv1LzaJibx0v5ErD7KbOP3inKLBdS9T9xbTacV
	MbLwKmL/k9y2C4JI/UBHAIxsDgAltk2rpFH2UXRmyaxPNfbnFL5mSSY8tGWk+sEA
	U6SROZG6/DuUrwHTwFfq97mqi+qWheohLBPiVmhTUZJ85aQlORmNcZNQFO2rjpx/
	SOEKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121205; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:b5t5Oy02t5IsI9qULxipqKMN0icYd0e44sEvt5vElGSgKB1
	ad+ci7K5Gx5tSLnwQoC0WKfiNV2ZW4TF8lDEocAsd/VWQK3AwRz9z4KLqIde2XKu
	iZAJI1aWEM6dILVgMCAs6KzHhSpYs/KCKbwoUSQJVboMe4739t2UgKMU+ceXb0WP
	J2kQaiWbDB1KmjWR4/zQzuTKQQnKffm+7LYlmLEhfBy87F6CwxGI43uCdt+SuM8A
	cApCDOrRFrjruzUQHr8oG6MuliCS/l54B7EedtXHXmFjIdEunNjdp9NkUQYzyZOh
	rbbbtbifbxRo9hVMV8SFoJQhjuzAo35G511P56w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:P7qr9+Vk84mwgZ83Dm/8vDCMawrueFpw6qrFatp8LYw=:nSL1kRFz222Qw28hbW/GZoL62yXNlvTaEzwpjY7YddQ=;
X-ME-Sender: <xms:9B3wajdnATmb6Z7bXePpjlSWGNq5sZmrrDhZDCeTfxH4z9P9MIvcBg>
    <xme:9B3walWn5mtG3s5MVfmvTHyYeR4Wx_SyeWTrr8d4dN9p_y5zbJNKUwsADJ9OjOMev
    y7J-ooe7rYbYw9IVTyQPcmTQ570NhgFLmpTFxTudIjE1Vi3LUvhXdbS>
X-ME-Received: <xmr:9B3waly5POFM9KC7NffbuCX1nthczcpMpdMEuJJk0V-EpcWjZqS9mx2wtVpaiaS2r8xNoLhh>
X-ME-Proxy-Cause: dmFkZTFKhclCCJN9i5LFQp5fvn9DylL5PDR95+qcmUDEkBDvAaUlhVhO6JW1PTcA0oiilr
    afxU+kS37MwfkRVrV2sLhNS1OkBSH9hrpfUYkvEeAEfTx8oUhC1lvQdEqsrvfO12L2kPDm
    Y90xvEv61R5vWsABT3XVmqKcWsSTBPoQRHs33ySAWpN7mh8mIX7nfmpu6Q5St0DdZLVl6o
    GJpMHUC7TjUVqLMHfqfKk9SHn10f5lL6CdG6YeehrsosttZtbM1aNiFk46XYC+svmJcMBn
    4w1I3sJZaXrv8SSndHCWUOH7cbPZHBY65Sr1oZjnZZRxSV2wTTFO+3xU/Lmvhk4YCMlhWl
    oG781Qdu0p4IjDuFIf3UJedZ3PC3oW9naVF/ZMpB5/6eyHLwa5Mtp9hVE47Dx1PnK1Da6V
    NTplgmRe5ue9yuPYlEJfY6v4CLo4WLE4Ypelbcp0+vPIY8HN7Hdytg4gphobHpyoWCRlO6
    hCM8kDy0g/jXljJD4gSAQNkfs504NgfEbWRpSIFN2UFizJPH/9WT55n5uSdQ5sXWMILie1
    cwWAGTScrYMaIuEXAqrBp4HhDUTCbBrpG4HfT6rsdWIcEffb1VHjwbfgzXJrN5XQ9HkIdZ
    pS85Oa4CpTtK+ekqtlWaS9sT2t3NzehhwDfRD5nw5Pt7Dr3QVz34c4ASBdxA
X-ME-Proxy: <xmx:9B3wakD5FnJpVUxtgGApJ6rSqmqS1Ytg3V4Fn0_02ecxLffM3h0Qww>
    <xmx:9B3waj6XN9WlMd0-MAQCOgvatNglR1U-M7ZlVIvxlZK-A9ylN1rXCw>
    <xmx:9B3wajkOl8DJhcM_lesFSLAeA7FBVI_NjgRLy2Z1bhxWsdD5lTsOsw>
    <xmx:9B3waufGbuMv803Mei5wiovbrwCBIE1Smh6aAIa5HHxfnaVvqJMzaQ>
    <xmx:9R3warRSK6foKj0AthoIEZDPGoL9S1TMPKVBcYYCCLxpMuZqB-gvjZ_Z>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 01:59:55 -0500 (EST)
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
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 02/16] accel/rocket: take the completion register writes under job_lock
Date: Sun,  8 Nov 2026 19:59:03 +1300
Message-ID: <20261108065917.135194-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ handler writes OPERATION_ENABLE and INTERRUPT_CLEAR before it
takes job_lock, while rocket_job_hw_submit() sets OPERATION_ENABLE to 1
under that lock.

If the two run at the same time, the 0 written by the IRQ handler can
overwrite the 1 written for a new task and stop a task that has just
started.

Move both writes into the existing scoped_guard(), so they are under the
same lock as the submit.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index c3edb94355a3..03e5f094f60b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -369,10 +369,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
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
@@ -384,6 +389,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void
-- 
2.43.0

