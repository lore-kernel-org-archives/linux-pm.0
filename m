Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103719;
	b=bCro6zR4CI6pYzhxGxRgibGhdaJ+1Arx9KbjpaCtjueQInlpcWTwMwgHd6XkiadVqymf
	 1XV8J7zUFBkRe43luX+4q7etIoCD8YZZNASKFGWlamUs/RfNsgRP4rAc1XtO8Kp+GE7oU
	 bGrkbo0T3MVBZUXB2C7swDrXsT/r9++QDbcH0uZlABiv4fhvUAYruE1WHExQG5+HSzuLQ
	 ZuKD8iLVZYKBASjeCe9xFFv2iJsvtZR9iAV4ERkHekNmCkRPkkq59dPxibREs2PsOhy1N
	 +ZfhMKeYY/PHuDtib9z6g8Yj99LGceRdKGotXwrtQxkvBG840fXQTcDC+inJEVK4BOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CjWvn6AFi1A52TxbvgaZZpyJgGj9ZtMA7w6Z+oUCikU=;
	b=BUtdR21smqZxhwhGZBzLhdpiFc5oap8J8BtLjIb3QyffSVw6szNN6zvqUGz2Y14zRkMi
	 iY99SqYPDwa9Zr4QSHVHAs1FPHQYmiJdWRHGyfEgo8+nHmLws3KcWOV35vxXOG0dDJOQT
	 +NGgH3VSuKrrxqF+c5g5kvf7lZ/wRNJ47xyOAT0FLfb8p2rKpDXy77Myd75XxPToxdP/n
	 tj0xz9sft2W4QizZ1mqrLasDryVtjEiPISegbRnaspP+tfVNANgwxdsjaKQ4qUx63Z6xk
	 POvCau1BEI+pUuOm+Phu5UVYbxedrvhCnudvzO6Mq72aXlcrbVodhZycXicAigz/GRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hEM7Vq9U;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E1606A320
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 12:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 833E1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hEM7Vq9U
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so22903015e9.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103718; x=1793708518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjWvn6AFi1A52TxbvgaZZpyJgGj9ZtMA7w6Z+oUCikU=;
        b=hEM7Vq9UI83EhmjxiULTmQewGqr2XpeyKaHE4T3ujUWQ1sKYuM2vEMA1NcZKUceD65
         qiNW3w/jA1selWoK0OXpToAzmjDj90pXA45+BSm6Bm0sS0MjJeEQ1k4oEjIM3UqL4AC3
         vIJKGGxOPPGafaUfgbtzOCqSZuV8qmZQy0/luCwn0z8St1VZTTxpj74PMUpcfomeGq4G
         x2hdcXV+YVPKmy2Euy7hLYdrilbjEJOxS+Jdn2l2yqlj3zw3QO7Rb+vKMBMC13JTQMfE
         mKXdSjF4U9CzaMj1sIofPpONo/KUXYYbOgENENs5hNs4KAlJqB25q/uGL7b0FBymaW6q
         CKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103718; x=1793708518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjWvn6AFi1A52TxbvgaZZpyJgGj9ZtMA7w6Z+oUCikU=;
        b=u1AnNGKCgKHSau4adoKzs+r9Woc3WZvmwjWhaEu/HQb77o9+HFvmCNMxqZ0uBWInjm
         TxCuX0ZOf52hZ4XvWyfRjWlfsDLaWfYiNJx+i4wV7VVAQoJip79siQacL1WZTYKefHMK
         JlMD3O7y6CMx5r646Qh9VvekIgczUvElAe4azkikaOmIgnOIiNq5a6NUkMtHvfwZsh5y
         ActjEY5r9fua70bt2IxwX+H9FUeU1WzrRegbHreJWFscMnsbNOLo2pctXU6v5it0iEAH
         C+OeYsPpKxfcHzA7H0e/Si/a9gE1Xz0hlMPDBdOPKZDmuTDY+2+n7bh9nylUGSnPANwK
         +uog==
X-Forwarded-Encrypted: i=1; AKwUvBxEBxElI/UabqQ2d+xIYsEqZPNsEb7PGh0/EApwTDkUtV/Bot/QtmWTPChA7yA8vSwQTSDGiJYoFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJVpUluZtJm9qh3d00cpb8iSZHBhSMcxuhZTDHwCvazRqHEFJq8
	/ODRCEv72/4VpgJqj6/bwQpdyxWjaN0DeGXu7zatiZEh/IpcKpqCygoN
X-Gm-Gg: AYBFou18wa5g7OsKWZFka7GFZaLbxjVK6vWD3TK+LMa7SwzLe684gCK8c/bJlFCjB/l
	Pxrq1GfJw/2OcTLAQcxusdFcGuxmD0gZ9bRXyofDasQhblbsa7RCWFF4dHQ3oQxBhg57CJDiBJZ
	SPf0BUSudgBxZrZ6BmZGUOEFQ6EFruLLf547wjurjwY7b75hs63AAHHGakttK4oKyYsXLamX5L+
	oLEIT0wjhSw41eU4uSASichBjS3afaWJeAe5/LUyeYf+BKZG/t0QNPwmZE2R7eLw+BAcv6tvb83
	jL96v1G3npSCPUtK4Z+XBYuLeQW1R/FOC4uoohvRYifyPxAQ73lXNEAWTiaGC4a09vM5UpYJ/1D
	gDVpLPINrRosnxtpwoKHPFgPC5gGjQbi2JO/ag5LepoQUkHhY/AytOILH8S/ipQ8LNiQ2+NqDhO
	hlvouiGEA6NuKKFw+EITzGpyN2cO/7hL7puy+7PtasUt0xRTNUAwSYAxXYab1+DECcxESn77vhh
	e0od2pyWhXWUm9nR61i06LKMuFKM/IQJnAIe/H1bXsE00cIRo6z06TzvGWhs4J91BLK2bHchmLR
	mucRzSM=
X-Received: by 2002:a05:600c:4583:b0:4a2:1197:1de0 with SMTP id 5b1f17b1804b1-4a35ac963edmr205653775e9.19.1793103717674;
        Tue, 27 Oct 2026 05:21:57 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bae01sm325465755e9.7.2026.10.27.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:21:57 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: don't clamp gfx and gmxc before sync_state
Date: Tue, 27 Oct 2026 14:21:46 +0200
Message-ID: <20261027122146.24778-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261021080517.2161-1-okerixx@gmail.com>
References: <20261021080517.2161-1-okerixx@gmail.com>
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

On Wed, Oct 21, 2026 at 10:05:17AM +0200, Oleg Keri wrote:
> Until rpmhpd's sync_state every vote is clamped to the highest corner,
> so that hardware the bootloader left running keeps the rail level it
> needs until its driver takes over.  Nothing the bootloader leaves behind
> runs on the GPU rails, but the clamp hits them anyway: the GPU clock
> controller's probe runtime-resumes and suspends its GFX and GMXC
> domains, and from then on both rails are pinned at their highest corner
> until sync_state.

SM8750 (Adreno 830) is hit by the same clamp, with a different symptom
and without CLX, which is only enabled on X2-85 and A840 so far. The
first GPU init succeeds, but when the GMU first boots under the clamped
gfx vote, every ACD level runs at half the requested clock until the
next reboot. msm.disable_acd=1 avoids it.

OnePlus Pad 3, v7.3-rc5 plus board patches, msm as a module loaded by
udev about 4 s after boot, GMU firmware 5.1.25. The clock was measured
as drm-cycles-gpu over drm-engine-gpu in the fdinfo of a vkmark process
keeping the GPU busy, at fixed devfreq levels. The four kernels below
differ only in rpmhpd.c, and I alternated between them from boot to
boot. In every boot in the table the first GMU boot came 62-81 ms
before rpmhpd's sync_state:

  devfreq (MHz)            342   660   1050   1100
  without the patch        342   330    525    550   (10 boots)
  with the patch           342   660   1050   1100   (11 boots)
  local test, only gfx
  left out of the clamp    342   660   1050   1100   (5 boots)
  local test, only gmxc
  left out of the clamp    342   330    525    550   (5 boots)

Every value was the same within 1 MHz across the boots. On one boot of
each kernel I also went through all 14 OPPs. With gfx clamped, 525 MHz
and below ran at the requested clock, 607 MHz at 539-558 MHz, and
734 MHz and up at half. With gfx left out of the clamp, all 14 were
within 1 MHz of the requested clock.

In one more boot of the gmxc-only kernel, sync_state came 83 ms before
the first GMU boot, and that boot ran at the full clock. So, as on
Glymur, only gfx matters here, and only if the GMU first boots while
the clamp is still in place.

With vkmark's blur scene at a pinned 1100 MHz on the same boots, this
is 414-421 fps without the patch and 831-866 fps with it.

Tested-by: Vladyslav Tymoshchuk <tvlad744@gmail.com> # SM8750
