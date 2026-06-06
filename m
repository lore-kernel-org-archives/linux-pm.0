Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506F22D781
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780759055; cv=none; b=TeTssibImbVkGE+YJsO3Mfs7QOX+ecC0O0D4+izVox7PE8uVe+ydOWOfAYZrMZArZfy2fXe7dnezlX+pn2eQAdJc4zv+p4576HBmbd6136goZ+pFWFYTvkLxhuWAadsGUcyO6IBADbcNUPTUo1dyyMqVY4vvfKN+LP1F+0m0BcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780759055; c=relaxed/simple;
	bh=rCrpHORZ+IdcnYQ/BZqNJiwdQvQYdRlVbv4p2HNrb5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SevV7BJ7my8A+R+f9ROBDbnufpxCT6wNZxaJf8MxtSxCrbg8/zN7K8coVKW+5zhE4ABtChuGEzjmX+g+fLhR7UOSIk4dbxWgkhnU5ZQNPlJ/WvnBqyzwOb03ub7z9RCr4IRUdvfzJaXAT/OczlFKJzdrifHFXIYh+Xv5X+pputU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzqznNGy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GXHgib8Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzqznNGy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GXHgib8Y"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EsWiW1780759
	for <linux-pm@vger.kernel.org>; Sat, 6 Jun 2026 15:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=74qZG2gktXRXFhZ157JDE+5U
	dt4H0C4uI/LT2/Uh9u8=; b=MzqznNGycmE+WATNjxY9fLt68hQ4HAQQz1EpJIgi
	0dw5pBlqOVlkGaKa5+QJyU27iOXmbjDfWAvtAwaQ6QpwgDkty/POkbaovx5+qX0c
	cxV+/ADFGdYgrHUX/jHdE2f6PRDA9+R5iuk9kJN3b+ftxklew8dnbY1fnV8MBKrk
	qZoQ9qT3w14z7I2cSNuVL34Q+5jNaZxJ4OgUpJgBhNAvWbt025pxA9k9I044Qqiv
	7n4fit0m2L3gHzq2hTn2cSO674HqPFHFC3KLWFh1CupWqxx8RAyI5t/5GsyCdNYb
	JRyrZEkZAZ/fXXGxMHZeAfovv701hNExp1ZsfSHdGJLvEQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98ct119-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 15:17:33 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c554284973so3573909137.2
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780759053; x=1781363853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=74qZG2gktXRXFhZ157JDE+5Udt4H0C4uI/LT2/Uh9u8=;
        b=GXHgib8Y1KAd8RmNdr6dKfljt1hj1mM8PEAkRhE8jaJxyhS81QQj1hlObfRsUmVlXx
         pag7vfW6bs0/iXEs9Kkx2pR7H4kc7OlRHBqyl8vq0kfElWU+udSr79pRQ2s274nDbwOv
         alS/6SuZmiQSLYrhgFOZigyc9WAaUYS0dt0KFnkhNHw9YAAVcngY/g17i7FWfiBfxGJW
         zXWkHYiOF4qcqQxErJWOpL2k5T4JC6q7Q4d4WYL+oltrXmYnePg+8SIVE3dTJW8ouLRj
         2146yqTPd01rlcTamjeq8wZKAaajRtcHTvcwS2T55q580bT/Q7bpLGPjXZ3X1dTj8/GC
         z96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780759053; x=1781363853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74qZG2gktXRXFhZ157JDE+5Udt4H0C4uI/LT2/Uh9u8=;
        b=WbMTcwn9vpu5u5rd0lSG5prIxUQShoJi9UlAeYFYPCXk2tNTp3s58Z2+skvbmYuJmB
         rMjKjcYeyDZ7wPCQ+yJWSuYPHiSI214HcCdrWA+EfEb1xdvmUJR9KtgorBg1MOWfzCeY
         qK56oqsbDHVOg1/BsNJjoFWLMpVU0vTv4Nj0j/cT0saGda1VPSONOPjLbdmKLkBs1u2Q
         hSutqAEjrLe1oTzSVXmCQ3Wbw1wSwC31G0sjo4eaTesbyy82f4CZQ7x2YkbfbxurJwKT
         vxxtQZA8nunnxbDDbQEIn4DwBtZ9uciWNj1AgcuT4UnWMwUD+FSbQAC2f24+aL78ulGt
         d91g==
X-Forwarded-Encrypted: i=1; AFNElJ8Mmn9UZufTQxEmXIs14Y++919wDtrlPKuCgSYfhC5VR98pegtoyXGKZma3RtoEoF0qDgCI7VRJnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7H584X1TorzRPK3EwHcNY0/RJxROdVUm2fCILX6x2wMwzDPaf
	IjIqfwHxa6VpYkNHLqCknwjsaulHjxWbSuh2zxPPnWyVwL3KYehLgL//Bstxc1LTPS39OUYok52
	3HXSPVCOEsOXmeH6DNb+2ZtNFJsuJe7AXeIgU4PuWmzV++LLlpAvzsI1tcuVssw==
X-Gm-Gg: Acq92OHmJy6V6G95PO11WEYj35R+YqvFFxNkSOPZr58NHWelm/qqiER22bRqJ2eC6BD
	3qilA8DDToRo7kr8HeXm+Dp2u6u2JhfrTy2KPPM5Q/dubNAIc6hs7vT3NpVd1VZ2A2jbcWas2ym
	3sCbLQxH+UAkiuL5BwyOdAUwiEGzqi9Ho95ZxizhbAFC5yAOMTpW7P8fdU6PeazK90fu3Qz5cNI
	e6fEBSLtMFZKgV0Iwih3cxf9NxbhQmQyYcpTOfEaP2M4q3Ix9T09EzMalVlqtMoGpC1jcF7qXfH
	Ivy9BQvdsA3ce9NqolMFpGTc5J+B32VaGjQMKTbJ7QwBDo9uTf9dbeoWjz/AHwWb7zo381boGi/
	h/gko9E9ThC6MIqwPD0nD0tlis+6ckS8+LHYoPjgT52rA9zo7Xn2N7Blzo6Rj536lsjAahkjKO1
	cbEkSJFpG+77k31xe3/HK3pPxfjBmFOe4atS/qT7HyEQuaBQ==
X-Received: by 2002:a05:6102:441b:b0:631:37cb:1e64 with SMTP id ada2fe7eead31-6fefc00fc45mr4349203137.4.1780759052665;
        Sat, 06 Jun 2026 08:17:32 -0700 (PDT)
X-Received: by 2002:a05:6102:441b:b0:631:37cb:1e64 with SMTP id ada2fe7eead31-6fefc00fc45mr4349199137.4.1780759052255;
        Sat, 06 Jun 2026 08:17:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b98fdc2sm2537787e87.63.2026.06.06.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:17:29 -0700 (PDT)
Date: Sat, 6 Jun 2026 18:17:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: qcom: gdsc: add LEGACY_FOOTSWITCH support
 for MSM8x60
Message-ID: <yv5t2llliqz5fv35cgw55o7usamrpujlnh3msmpz324l4p5yfz@s5pr4dos7sh7>
References: <20260606-submit-clk-gdsc-msm8x60-legacy-v2-0-187a32d2f015@herrie.org>
 <20260606-submit-clk-gdsc-msm8x60-legacy-v2-1-187a32d2f015@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-submit-clk-gdsc-msm8x60-legacy-v2-1-187a32d2f015@herrie.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE1NiBTYWx0ZWRfX5C31mYn7UkCd
 OW+DD1cJoFAkcbdXJe9q7NV4UgEwkoWZrBndnajU/RAmK8gJ/GOG7HN8RbzrwEcJncu4XIMJQBj
 E3JaiySaISjqjf1T81Ht9r7tklEHRdkVctSBtsj0rOKmRk780CoP857UKuzTH8Yo/8rOVO/F2a+
 NNmDSnmLRyA6TNvaB1NP5Mln5ZCiN0i9gs+1Fpg2Lo6ujY4b9isQsWL5wOkWo2Xu9ukX4yj5wZC
 xlhsXBjgTmex/kahbiWMRjdL8reyN/5oklRCZSIGRXZsKYCSJcZ0KPQTpEY9T3LayJTQG1GKrmJ
 uvOnT6+lfEezQfHuyJZcFlDVYbakCvvFBq9nxnr0BJsK3LJIpULQ+gyGed0lVb80H2Bsj6USfdf
 e0MmwlWU1xbAuH7REzxfFm7vcC2PLa/N0L305AJaz0CDaXJgFD3bLQG+XoyNUBwEPaP9U0CAmEL
 RWzjr08chQPw92/pXOA==
X-Proofpoint-ORIG-GUID: M7LOUv3EBKBjW4MkSUnuc_eBDlyDzmey
X-Proofpoint-GUID: M7LOUv3EBKBjW4MkSUnuc_eBDlyDzmey
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a243a0d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=FpyeHBnFSVQUcGjnY7sA:9
 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060156

On Sat, Jun 06, 2026 at 02:34:26PM +0200, Herman van Hazendonk wrote:
> The MSM8x60 family (MSM8260, MSM8660, APQ8060) ships an older
> footswitch (FS / "GFS") block that pre-dates the GDSC programming
> model the existing driver was designed around. Adding GDSC entries
> for that family's MMCC power domains needs the driver to understand
> the legacy register layout:
> 
>   - the CLAMP, ENABLE and RETENTION bits live in the main GDSCR
>     register rather than in a separate clamp_io_ctrl;
>   - there is no power-status bit, so software cannot poll for the
>     transition completing and has to gate progress on a fixed
>     udelay() after toggling ENABLE;
>   - ENABLE is positive-logic (set to power up, clear to collapse)
>     rather than the modern inverted SW_COLLAPSE semantics;
>   - none of the modern wait-time / HW-trigger / SW-override fields
>     are present, so gdsc_init() must skip the wait-config
>     programming block entirely.

I think there are enough differences to mandate a separate footswitch.c
file. It can further be used by MMCC on MSM8960 and APQ8064 platforms.
It might result by some code duplication, but I think in the end it
would be easier to read (and it won't clobber the existing gdsc.c code).
Add footswitch_register() / unregister() functions and call them from
the common code. Make sure they are replaced with stubs if
CONFIG_QCOM_FOOTSWITCH is not selected.

> 
> Introduce a LEGACY_FOOTSWITCH flag and the matching code paths in
> gdsc_check_status(), gdsc_update_collapse_bit(), gdsc_enable(),
> gdsc_disable() and gdsc_init(). The enable / disable sequences
> mirror what the downstream vendor footswitch driver did on these
> SoCs, with the regulator hand-off normally done by
> gdsc_toggle_logic() spliced in at the matching points so a legacy
> domain that has a parent regulator still gets voted up/down:

-- 
With best wishes
Dmitry
