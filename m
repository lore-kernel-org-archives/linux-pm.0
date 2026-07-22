Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9043360EE1
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706030; cv=none; b=WyRy5bbLKoR47WlwTIsSNsTp+i2DW7C5edXSjLbhwn3JoMxAUZrQ1WZbB9JQFqD9bzH+yZX9xeZqS25v3MuI+nGnuLNGgVDRap26kY31svQKhYJj+3DCvho1Mpzpjj4E+LEmS2lcLM+N8vv8zxqxHvl8/6kRziLYViUw82XbmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706030; c=relaxed/simple;
	bh=swFDNlNTbzSmuQjfxksa3smW5BDv4wRCtW3Ecnxg8V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhFGtMg4ooGHW4TXsvW/YwgkLl4tz/exP/Q47Uil9ZP38vP634go2LKkqoHs4dT7JvanNnJklJe4IZH1GJGjON7ksTsJUq16wUb9jdCuzCDjgxgc6pVG3o6uGajfq19hmXIAiR0mwnn3vj1OAvqpGM0Hs5NqyJWwHMAyKJoQvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a6Aiptuv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuTHNAtX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6Aiptuv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuTHNAtX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53irX3473730
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T/sjeRpn9BssHS0FCtGdQxM5
	xUeDnRf/+QPldCey/10=; b=a6AiptuvNdJiTbm64FRiiwTW4/xZa1RuSpl6OVUl
	4QPetK5kihgfJFPFKj7iMnQV4q3npN1dTs81MkXarbti4nzalNQJQ+vnJx3+d5ja
	Pqbt5OQOpJup6Z/x8DgC9EPu21QubXNJKDRBnwoCcUOmh434Ow/ZlIhYH8EP5OYM
	UkHorDzdJUt0fjixZJI5/TfAViZG+fUuCCMMpF+uPrRpsoEa55J4MPAw+4d9l0Ac
	H67NO3iFRdrZvIKQk7ng8oqe2ShZ3PxrsOpSjC5eOuxyyvaxUuQG+qiOhYL4mpzg
	KEiZJDbfGXRkkJsFq0iaxNnk9u+Srd4hjO00MJ/PmUtOuQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftvyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:40:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37fca5f21b1so5641500a91.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784706026; x=1785310826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/sjeRpn9BssHS0FCtGdQxM5xUeDnRf/+QPldCey/10=;
        b=DuTHNAtXxsQHMIaBqGoPTh6G5C5gD04og1gQABF/gF39fx42m1mbvlBFpOqXC1Zlzo
         GQaWmrh4lZEEqPEKExe8es6nAHidWhlcVqIzesaWnapw4YbjIdgtxf8t7f5IQ/CE0wEl
         SfrEglklUUo9YT8/aZFrD3orvyIw36YX/rFSJC7KoVQPcVu34KZoq0+yBeoJY84Z/Aus
         wcc4DPoQ+ZqIxWNAw1pBjCLoDm20WCDbQS1U8/gx0sNQFWiXzYh7HkEW+F6xnWpyYOwm
         zzZgr4XytUEcvA0tvJfzJq2BgyyLBuFLPwqkWMxNddL6f3fgcG9P2H4nZOx81HzV4pRy
         cA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706026; x=1785310826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/sjeRpn9BssHS0FCtGdQxM5xUeDnRf/+QPldCey/10=;
        b=sAlgz48pCozzh6NN2NYjnif3nub/CnSomXlY132AszqhgL2x8DbqaNHtAlsox6Gba0
         XWBghYGMhY0r58dTs48y+AxYIDJOwIXogOnbxuZ09VzG1+V0djnVeUXaxfW6OVzPI/ah
         4r0RBxTgMkermjV81mcKWPPB1rvqsq+Kkx9a5RW5rGtsJkUtuqONuFHDDjBNVal5kV5P
         0sqC/bXYSvrzWh9Cx0QbhfsRyPhyMZtXQIKKue2Wkaw/VI8ebUymZZXZcf/MkJQfjBha
         l/Em6ODKiCH5bbmue98BhzMjfcqj2Pb/Zru9pTzHle9MrUM5G0JmAUS+XwG3YSNGEgnn
         wO0g==
X-Forwarded-Encrypted: i=1; AHgh+Rq8/HiXpidUCwYLgTd8wwGsk6LiOqDc09RJxfZchGsL/Isq7yLyH+FaYZVn1uUthbLHr2JWxEstkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1Fdm5YJEsTw/nJ+w/Qk9Y09EPHZKpaK6OuaV6sKywEySVRHU
	BLCL8yKORTIsjVYgw1lyGNC+oslq+MI1EOilrsBvOEFwhZQDP4LrttbI9zOg/ti6E0CWEtzrnuP
	CWBOnQilLH7kiJrtlilyF0rKt5xid5fra2l0eLZBEfm6wKsm9crTRK86NSUBkkg==
X-Gm-Gg: AR+sD12SBuDTfdlUDruhiAmtjImsagLxEqdh9EhkLuGidw5xqENaecmiZZ8eJrqJ4k8
	VygnGZG5hZUUFjd35mAUWMZFC2u7Bl4Tn+CZkL9IxAWI+kBy4Tw3/D7qSRtoAxuwRZhIrZ07sDu
	UIVtFTLiE4W13VMw8Y98JZ6X/G5W0nDHvXdI01PArR9zgpRC0dgypRTmuyyB6c3dK88HCYDgOeH
	zBqfaLPQBKzXJ1QLmV1IvTPIdKU5M6Ub8W+XkTdza/0G9tgaDt7VLIAIIO5vD6vseiNyW6fajcF
	KdeFyTbVHzJlOByI/ttxnnFgJI6NhA4Vvob1jSC0yqaSVa7h0r7XsY/u+ykeUMLkyOTODE/+E76
	pb3fvSnzKa7e/I1/F/Ki+HMvKWNqqKuTySA==
X-Received: by 2002:a17:90b:5844:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-38ea37961d2mr2544856a91.16.1784706026127;
        Wed, 22 Jul 2026 00:40:26 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-38ea37961d2mr2544812a91.16.1784706025638;
        Wed, 22 Jul 2026 00:40:25 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a7738sm3935997c88.9.2026.07.22.00.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:40:25 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:10:13 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v23 03/13] power: reset: reboot-mode: Add support for
 predefined reboot modes
Message-ID: <0c55125d-5304-415d-86c0-a589c612babf@quicinc.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-3-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-3-e7453c548c21@oss.qualcomm.com>
X-Proofpoint-GUID: AAuD6QnPjPClJCt2_PX-BC5QNvnEtVLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX86+f/XIoghfJ
 H8HUNagCIeFN35bTZ/ikG/UOXpgNTr0LifXUWzmnsVkGNn4wcVMS8vvHgdWe0wsJakcxWuCQhJd
 rjPVFa3WbwRSHaVICGyTRT2Cf6BKfTcH8wmOTM9BeO+QuCbbVzhpHzUWvzPs9NBFdTITw2ClaZ2
 XiOo8SbtmzYzRvD1XCxaipLzPxigBHKpoXqV4TkJjy0av/Y/IsJAkEtAj9BNWmxxiB8X5RftUYi
 +hvfv4FG/hLKvRdJtgWqm4csocNaiRmNFG2dsfvBdK3K7UZ0ycqTp5eVgJkJClmKzclpSUEYDoL
 y63bb0+RM2q7r0kvGcwxOnqqQYjNIXmLZ+L0zlAIQUsPwsRIdf5D0xQ587C73gG4zWENxuyo5Yr
 iW4wiFgRp4PblxjurlRv9d/zdDXwe528K9j25ZUZzC7K9kr2ISuJhz4xLHO8/qPYtBgJdP7ihFy
 27ts/gHpurFIEiuoccA==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a6073ea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZcGSZn2CXGzCaGrIrKoA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: AAuD6QnPjPClJCt2_PX-BC5QNvnEtVLO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX5/gMtMm8NrFS
 y1IDGEZXdvxaPQhEaJ+tBS8Ia7yfsvFLAWe8f7Nxmd4TPyZoXZSp9SELsGgE+tswGd+xUxYV2rs
 oDgM4qvZ1LJzoDXXoVWl3syTByoB/LQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070

On Tue, Jul 14, 2026 at 10:46:31PM +0530, Shivendra Pratap wrote:
> reboot-mode based drivers can define a reboot-mode by adding it under
> the reboot-mode node in device tree. This limits such drivers, to define
> any predefined reboot-modes statically within the driver and creates a
> dependency on device-tree.
> 
> Extend the reboot-mode framework to handle predefined modes alongside
> those defined in device tree. Drivers can now define their own
> reboot-modes and register them via the framework. A centralized init
> call has been added to the reboot-mode framework and adopted by
> existing drivers. This ensures driver state is initialized together
> with predefined modes.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> @@ -195,35 +264,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  			continue;
>  		}
>  
> -		info = kzalloc(sizeof(*info), GFP_KERNEL);
> -		if (!info) {
> -			ret = -ENOMEM;
> -			goto error;
> -		}
> -
> -		if (!memchr_inv(magic, 0, count * sizeof(u32))) {
> -			pr_debug("reboot mode %s with zero magic values\n", prop->name);
> -			info->count = -1;
> -		} else {
> -			memcpy(info->magic, magic, count * sizeof(u32));
> -			info->count = count;
> -		}
> -
> -		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> -		if (!info->mode) {
> -			ret =  -ENOMEM;
> -			goto error;
> -		} else if (info->mode[0] == '\0') {
> -			kfree_const(info->mode);
> -			ret = -EINVAL;
> -			pr_err("invalid mode name(%s): too short!\n", prop->name);
> +		info = reboot_mode_create_info(prop->name + len, magic, count);
> +		if (IS_ERR(info)) {
> +			ret = PTR_ERR(info);
>  			goto error;
>  		}
>  
>  		list_add_tail(&info->list, &reboot->head);
> -		info = NULL;
>  	}
>  
> +predefined_modes:
> +	list_splice_tail_init(&reboot->predefined_modes, &reboot->head);
>  	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>  	register_reboot_notifier(&reboot->reboot_notifier);
>  

This splice here makes me ask why we need separate API for registering
pre-defined reboot modes? why not extend `struct reboot_mode_driver` to
pass on the pre-defined modes and let `reboot_mode_register()` take care
of both OF & pre-defined modes. 

The semantics of `reboot_mode_reset_predefined_modes()` is very
confusing. It is not clear if any client driver needs to really call
before unregistering? The unregister it self is cleaning up these
pre-defined modes since they are spliced.

Thanks,
Pavan
