Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492A369D64
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812648; cv=none; b=rQWYCcPf92JKBIu1T27ulLIr5JrDMjTM8jsqVBjB7RKAMwmdXZ+juPIX6bJ0yXn6lxGSoylIJZvKMW98zC6UP81lbY25758en+QQZjqt6tRbbw5ZO5RLbER2rUgbNs4SQzKx+liYvrAQ4TGw4pydMALrBl0/JSDMk9X5nCuvVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812648; c=relaxed/simple;
	bh=wZLW2XdypAhHvwo+GHAiZC6sjIcx7C3BCwY22tUge+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sahFPVt5rhuFrryH4tJ3FGUhOTt42EW7rSmDj52xdAeXwfysNpnedRwpsHPNMV62NuEDiPoCr7SRe3fTz7pt/GyCpCNOkYYFEupfUuquhSfV4bw0/1j8Pe4/FCTVWKIoUXQa/8wp36CKc6+VBtKUbptyCOQAaXHSOFFp9qDR9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWTnGaxX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PpXw50GR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWTnGaxX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PpXw50GR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC09Da3292333
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mX36Oh0ldjKH64bRULghbP9zkZHVCst58P7qBcvJdOc=; b=YWTnGaxXDF7dV0Xz
	fJ5z0RlKpai35YN/BfCDko0TuA8fMf5HQtijMWL+Lh8mhNWnzkF6aJB+y7aw2pCU
	HguhYficpp5M4Ef3UGOfu4z9o0PlpTOAL3RfJuTGMvwOhJf8QWCmSgLF/6aiDiGt
	wjaCvUhAhsN77vShkA77lIDQTuLB0HjPmlHZ2cfdlJ5f6n8q+SkXibBg0er3bTNI
	0hxNbdsENvG/1sIek8XxLio3dVfJHTaq4WxdppLcFiSpbUhaVvOyrZzX9UQ2H4SZ
	Kxl9ow01N54pH3b5BUSaHB05JR0jYf5KtOz/uRTVp50F1XJnKpGjsbfJ7Lz9bl0W
	TzMekw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3hk0k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:44:07 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-17188d538c7so2665658c88.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791812646; x=1792417446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mX36Oh0ldjKH64bRULghbP9zkZHVCst58P7qBcvJdOc=;
        b=PpXw50GR0cCl5c0jH31B4E7PmVAuYSie5rb7uWIkOkGkRlQWfDp6Sf7RSC2KkPV+jq
         govQHkKbU1HU7DuL8dyh7rpQz6nMfCstlw9tvwUVjBmrENCTyxoH2rlxx/bPXWvQi1yZ
         PZ5iAmwWrZmic/bKEN+EA1vU12dxzmX9Xq+z+QHIbuDvdm0grz9UAhsKOGSDKb1gJ1TS
         pNrmXZHPciOp8eoHHpwaj81knLwu/ZC9j8s1SbW2A9F7XW9HEVNhOf/AMYs0LSGA5/UE
         35uVsT+ZJpulL4SlxUBh/InniCdqeJO2b/Q4nAQuRfHxagcmIPQ49oSEVw96Ee3+kpEv
         vKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812646; x=1792417446;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mX36Oh0ldjKH64bRULghbP9zkZHVCst58P7qBcvJdOc=;
        b=yTEw2KoQYSWZiTEm7Frr/Oon/bvjc98PZL4BFkwNBuJvWvqfNAhFz2DJZvvuU7a3kp
         1w5LwVGg/5z/EPn1Vlfll+T1dLi11tVvairV/QgQietxvLHupYfqnLxYRP6yX/n3pD4l
         5YzmbihzTpONmy0zgwwNrOVr6mqGyS6h9U2UrXp76AhjibnO7v35YENQuILPEVfC3x4L
         JxT7YE3FPCIvzEPLx/FKEWwMY6o84mfkhsAZ2bJ0y0VIQC2zsU/mMK4Wv3oI9JGYgS8v
         8yRcojF99rafwph/yXJItjOJL/e3g/T5fpkWWHN57o8zcFecOH+JL03h/EPR5Hv/mKkS
         CxXg==
X-Forwarded-Encrypted: i=1; AKwUvBzNUVzP1cwyt0QW+5C3zcBHjlxSR1yZJBd/HQ7iv+KmKAaQzZ/hlOPgfUkHRu+cQm2RsyAM/PuFOg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJMGBuMOsurV8nkJ+eckMFGx6Vo9aTZQ/T3eM5Fh8PlTKpD+xkP
	mFKF66qmmUtb5NAmAtfHZ1Wc6m/+1mQcBjRsHO9+4gCQI2gjlY1xXbICb2jjea6/wbSFTtNT7bh
	WKUnexxMHLlXHq28bX+20ow+8IaJr2B7KCacOZRqmMPL6KMnC0X1+q1RWdHXQZcbp17fOzg==
X-Gm-Gg: AYBFou3l3dVcOVYtBKMb9cVqpkfijdbPqSDVvxV5F/2BPqiyi/ncBaz8l+sGIxuPimY
	deiUyb18G7tuWzGd5ItgYBFMzBROa4zflIlxjXuXBBHC4OTMhHBB8mh5o/WlE9tVphDhM7zEsYY
	X27QiXgipj7e2PYiBfcazrDJ7qwG95iR+/pZ5kXUB5AXx9LWKcse64LY8/dReZgZYFZ1+Oj9wfU
	e37Cw0RnYwOa/LPmRBf/RmpepVWCDqRgUVeAA9/Flfj5F36mu633wDcPyqHxLPnC+Ocw280mXnR
	whuOhUBsFU31gaQcqCHtzkKpr8wqoVGe0NAvcXFXCiMzeYhn/DVoTm8ApzvOuNCUwB2nsZ41y0P
	slDCXgxSEg4RM4+m7EgrJJGg9acQ=
X-Received: by 2002:a05:7022:7e0d:b0:14e:cc3a:9f32 with SMTP id a92af1059eb24-16a5c5f2df9mr15542038c88.7.1791812646088;
        Mon, 12 Oct 2026 06:44:06 -0700 (PDT)
X-Received: by 2002:a05:620a:17a3:b0:93e:84e5:3c66 with SMTP id af79cd13be357-93ebd21ffd0mr1649950785a.40.1791812176979;
        Mon, 12 Oct 2026 06:36:16 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c8244edsm121124535e9.2.2026.10.12.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:36:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        =?UTF-8?q?Fran=C3=A7ois=20Roux?= <franzelfranzel@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
Date: Mon, 12 Oct 2026 15:36:13 +0200
Message-ID: <179181217126.5143.7104145391205542787.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004165124.4277-1-franzelfranzel@gmail.com>
References: <20261004165124.4277-1-franzelfranzel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX5jxz5nPHI7bi
 Ugdx7+Q0MLfdn4OXP1lFjy5vWO01II7mlU077DBNGX7S+FA11Wu1qm3ySo1JFEeHy+IjgwkHOfR
 WInLFDbmszAQGqHVnlAJSYRUsniPgMfOicert2jkJb7v9Rp+ic/VH7Eisr502W8FWgDuRaPH3fX
 sKnSRGjrJJe6QFD2IxI/DVPYUdXuBjGGnGkguk5amEOTG/BAO/9Tfhc1XufzRKNgoTiwszl6yuM
 BR+lBPncsctcXqBojRz8yi3jsCS616cexL9ys8m2cKC1uCWAOtynjGwH8aGSOXx+TWlgbw7Penf
 cal22g2IZTQSZTGVRnYoWh24B/n/MNllRvK6RFkNj9+BWhwUs+sk41GHMgkgncPimdQqJIEgf1X
 JFxk9xqRfW/L5hf4Rp3NlD4Awt9Nqq2DHvslMFtgvcx9Q8yI0ogk3NaFUDq6FHvs/Wgna475Hau
 Esm58uiqFbXL3y5aCLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX4JcEGK5j5R4L
 yV5oBtR8Z2RMQLGIu8CxeMfmTQTt4qVU7NvIAO89CfC0TsTJMLu9DMdrvHZu+wVUnv/FqSM8b4L
 Lw98MulAmQL1uA8G4kXxsIbnemI4gbE=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acce427 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=R6-RoArAaa4DRIP8ZZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: RFBxvGlJ4iOGZzI8w-gjgrJz3Z5W0CHl
X-Proofpoint-GUID: RFBxvGlJ4iOGZzI8w-gjgrJz3Z5W0CHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054


On Sun, 04 Oct 2026 18:51:24 +0200, François Roux wrote:
> The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> current level, so that a WLAN module left powered on by the firmware is
> not switched off. The FIXME explains why: toggling it would take the
> PCIe link down, and the controller driver could not recover from that.
> 
> That reasoning held while the PCIe link was trained before the
> sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> powers the endpoint through pwrctrl before it starts link training, and
> defers until the pwrctrl driver is bound. That driver cannot bind
> before this sequencer has probed. Power-on therefore always comes
> before link training, and keeping the firmware state is now harmful.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: power off WLAN at probe
      https://git.kernel.org/brgl/c/dbd674ccf30f66f5eccf637964a93910df8dbf84

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
