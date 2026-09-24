Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A9238C36
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240907; cv=none; b=WJs9UpopLD28ucL4NxMCH2SL/YAvhJhRVnu3eR277HhPlWoy0ngvh2LRg4GBi9G8n05E6764kzIDL8rpdDivliIm1/dt9C5aF3hICDTQiFWG8nWPRD0OPc1J21YlSYdvFBVadlfPDLH0hGtkM2xVDQX9p3HKfUk62HxXbw6CT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240907; c=relaxed/simple;
	bh=kbzH7qjqaOwJs9tvXnjG2IbxAbzm4f0kLZPAR+JgW84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLPMoHby8OXGIeG063OcU2RwNBV6NQDjpB/RsqzB9xtHpKPEwIzOIJCnIYhMcn2HzUWK6tS5ZZN6SiLCPsxD94N3woB0PfdmkWjk1s2OvLkfS/mNbVNZD1udCpsPrm5n9bShwUn2QX85tJqq2E3fMxtWqZY6umhy1nRr5mUVNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=M8CqYIdN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDD4MiZO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="M8CqYIdN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDD4MiZO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 307A21D00023;
	Thu, 24 Sep 2026 05:08:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 05:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1790240904; x=1790327304; bh=kbzH7qjqaOwJs9tvXnjG2IbxAbzm4f0k
	LZPAR+JgW84=; b=M8CqYIdNbi4uc5RsPlzC7Vl7h+0MSRFgAHyUmuxOeGPSI5NJ
	swA5QrXE3r0osIMJeWZiuef34Yo9ISApB7CNom62bqmucp3Cg9+ryh1tCM7Y9dAj
	sMJLzBY/XNKTXzHS2uYF2TmaGuaqHzeI+htTP8Emgt0MtKgOZxsvqz5WLRhoJnrS
	A7sJ0sPm4AmTtnbPME2fF4iVwqDdKlyIFwhkWzIK1VbczIG1sey+6U5bKCofugj1
	V+N0IbcwNJv9Syc1jOJKuH594Y/AI+90/k1kVAFqBrV1T/sp3iea1MnMH/Ex0HwP
	lI5Jd9tg7sSWr6+RD7DDp//nKQk1f2X/FWCsnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790240904; x=
	1790327304; bh=kbzH7qjqaOwJs9tvXnjG2IbxAbzm4f0kLZPAR+JgW84=; b=p
	DD4MiZOx75xMlL5FczWa6fpffjsxqY5U6XY2cEr+2twrHY4GcaaJc0k2fK5OMgVQ
	XTXyma2nuVGr8t0Oc7MoS7FHJnKUhjoN/W9HWFgA/jdYseua+ipOvGAQXWpfft3l
	Ql+x51MAA7Aa9gDX9YQ11pjYfP8xiTajQWkx2W6PU6qLvNm+SntMjQj0h/1Zs2m1
	Uv4aNBTTpD4f1G5+JrYYnl5bR6BcOSCjeK9M/LV02TpyBvYdw1XklPbNeZXBftCz
	BwZvL4lqbP7CC4fWjFCs86MX1a/ibBm2TkdNA0J5R8j5UpYaQxl9AGHNTV7GHYTo
	J5zjpI0889obYjIktyQhA==
X-ME-Sender: <xms:h-i0ahhtLT9rlJE9X-tKCBKMZ1QzCQclh8dgDaVdGtA65VcshSKCYA>
    <xme:h-i0ainqRpD1tNqunlcJYFgRgPGyKx8wBg9k8H7EPufT4bzLO4smjS9MRSopHj8be
    jvWGzLq7m0__rZevYohEafXG72_Gp42BUet-4EryLBClCcgtUfXK5PH>
X-ME-Received: <xmr:h-i0aljCBATr659LeXSyehsjd8IAqOH8fbB1qOLMy8q0RWplSk_eOu6dIOb3VIC2KTRI1nyMJQ>
X-ME-Proxy-Cause: dmFkZTGhribILWLZsbRrU4Y/cS3q14omnMoumwx+6zPO3/kzgsZAbgopM11gAgYklAnMHT
    r8PmY3+S744nZ7vYIB3APy2UCljo+f8HLGJh3k+RQFLrJZnWvYguKKLNJ29x6WvdMSwQMo
    3RCBqaEPTdWezhFfe4I4z96PUbeCaHxtU7vUfxB40hI8WOXZOt/UxbS7gh2kryMdVlIFBt
    X+maJR+jkma8Wk1q4jUGrDqxwocYQeTz1pvJvwdOBncc/1CbAZF/5ydS9GJUS/Dxt2oypD
    yuIZZ0fmLnRsJUh4Wz+YDQcCynTXAZG3EFfDTzldAWd97QM+7dcGZ0Yumxz4b8qPajhDZT
    U+CyAK/OZokQZUiWrcCvhp42lYDB6Frudhl7EOTFFfbHzGpfwQAYtcTin79czFo+jB9u6n
    7hVHQNrcTMsLFsoIEggN26BdXc7kzRTAkcRnowc3Xp00/cQ2eJ+h6dtDl5rs3WS7jbTQ7q
    Sn6v/upBCYnQhmmoPZcOwtyAT1atfi7eZzPTj4YYqZ9lgG6e+1TNMeiQmyRsrYSjh0aiTw
    +33cE1HuzyfY6oEGjQKOZN5Fi7rWzCrI13giX7jgJF/VPSpvxHSrbyUmEKecHS3s6RSor1
    6XZTjHbRIwORK9E0VDXT1g6hmiXxNPYti55KfJt0C0XxQ/TzE6PHnVXuYRSA
X-ME-Proxy: <xmx:h-i0atHQNqbtPlYRkfD93X2Rdd6eblFEh22EPtH0z-5243AxBEMOEw>
    <xmx:h-i0avuGvB9ta111P0wHdckEhJ5aY329L9o6iJ0lM6EgZ66bnz6gdg>
    <xmx:h-i0amdy8da_NS5S7y0Q0KiseSTt5OMwj6aK9q2z3UquoLyoyTApHw>
    <xmx:h-i0atmoSs5XuHrDzHumVBsMaGGDiaJx6ETb7chR3V-ivq5gN1zJVA>
    <xmx:iOi0angqRXkkOlbxiU3EQpR0bMM2ouL_Vq7Dfnx_lLRX7Q-O06sOxnuk>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 05:08:20 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: ulf.hansson@oss.qualcomm.com
Cc: heiko@sntech.de,
	p.zabel@pengutronix.de,
	tomeu@tomeuvizoso.net,
	chaoyi.chen@rock-chips.com,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Thu, 24 Sep 2026 21:08:16 +1200
Message-ID: <20260924090816.38457-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com> <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Ulf,

Yes please. Could you take them from v14 rather than this version?
Philipp pointed out that the binding allows one reset, so 10/14 should
use of_reset_control_get_optional_exclusive() rather than the array
form. v14 has that, your two commit message trims, and Heiko's split of
13/14.

In 9/14, v14 keeps one sentence beyond the two paragraphs you kept:
RK3576_PD_NPU also gets need_regulator, which makes
rockchip_pm_add_one_domain() power that domain off at probe on every
rk3576 board. The subject does not describe that. Say if you want it
gone too.

Regards,
Jiaxing
