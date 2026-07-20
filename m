Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BB47DD6E
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585983; cv=none; b=E7bTHMQ3wdUra9gQDfmvlPqkzJBJcfvh0R09josoNOlIfQp8+r7ZpVEXidTxBflB0hmL8wDLGmykxLtTqpYGkcuDE3izoVv2TYEsRHEAHcm5+Dl8c1VwN46LM9VM/diuTIVEPiWtcHHqIOLuPOWonWy67mK/uD1dLERmUn0eycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585983; c=relaxed/simple;
	bh=bm7Z9TIfufzBOFaLpexxq6FROsH79ShJEvHWwLi1ONA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grhXQfy03D/Vf3J1GVpvx+fNBcaDYjfZTkFHTcbnjs9sNosp4xcr+TdoKD4WWvKLM8frt70/ppSB3HJrJnQEumDAKWQA728L3j/fmWAUCWG7QBRDNeZOkQtl+224nTFkly4p5CC8Ssbq662f/P4ESSQzMXpIIpQDSpIFUXZU6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WHoFPChd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QqU0vaxm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WHoFPChd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QqU0vaxm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJTe0G3637646
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 22:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OCWivWDLjQUU4XplDWC2MJ5V
	z3OXYDvt49Wj3ddVztE=; b=WHoFPChdKRgCA3qmZiF+uleQI/6r1ShbPRDjJZe6
	zt09Gfqdimuobpa4tPi1k+RCUNyANIZTtzMyPIzBhezxUw4f6G60JkNHNb/njKZi
	M8fUBWtzhWom6AwlupD1yM4TOaiMbujrcJ7LFBX87YEXZSqgdAg6g10KaPuCjM8V
	TvnXyf1Pf8GxZWJlM8BzAOQOCqGLKmTY8D/JuI4XFITIao2u9JDFn0y+Lf8BZ8/q
	N/7KIwGo0Vg2MyRDXz6BEkCPW0K9N6PmU1fWPzqUSbcEDKy1VSJXySCXiRuHg/wf
	/cRgD1QzZbSbzgyJ35PQM0Opqr84X5ePzAuoegj4KGSDDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhhgyu3h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 22:19:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51ebdfceddcso121607851cf.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784585978; x=1785190778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCWivWDLjQUU4XplDWC2MJ5Vz3OXYDvt49Wj3ddVztE=;
        b=QqU0vaxmWE4D+HUkThVg7i48ezZESVpashDLuZeoWC2KDh2mS6J8EBjaZrwBrKelUa
         U2kQMe/7MYWYEx+7oy3VLFmJgGbQHyDmwlGYKyX/UMZ/xsCZ/n53gntvXVVPHKpay14Q
         HUAdUNTUYiHEnWIBWq+Wa8a1eAFUwjbAMB54/iRaGk7LIPBKpOtrtbeQ2AZqz+ch5JQy
         gpSbVglKtl5nQjBYe7ZWGJjaDlFGpuWQkJJZjsSeZXjcUlyJvM/Rtga2quH7muNL1omX
         HLA4bRjDmSZ/2XyJaemiKhvCAWXee7GYkEJAr+Eiry3PkVArGpGa0flrkLnxrm+fWbHN
         RoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784585978; x=1785190778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCWivWDLjQUU4XplDWC2MJ5Vz3OXYDvt49Wj3ddVztE=;
        b=S4yaCg1EaNvMa6tVqz92R+DVd3i2m6Rl4fWsHJPZcll02jBUKnl/4snzfZRKTfQI45
         UKSknfuO8IDVzvQu6i5Q74iN/1G9qvJvM5Zr28MqAaWoL0tnZLwxyXSLtzH1msJi8IyN
         WSg4RV7VhnHIdi98sXc89CeI0trvPgDZ3i3Q7t0m4OlQ8uwIR/w077XMZPACj9u6K5CI
         jnalKD5sdiBobAcqgg6luD1ufNYmQFM8u9xednyjxcnr3o15J7/88XtIt14Q8V/riTO6
         YUZdMvfwzzTp9yyxfPyKyv7F9fRAnPfzLcwjb9BRp6R5FSsG4HFMrHYtLkMXhhaJNPgL
         PZvw==
X-Forwarded-Encrypted: i=1; AHgh+RpJ7zlRBfCFrNDCLb32SeW7ZhtoiXaO/kpSGxVY+0Obs1nnA43Y9uSc9l1Bydmdjov9IOXfeqxXVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rbhhI5QgMI8i6JQUzNLpa1lS7+9Stf4/wZpf+IwvnRfJdVBf
	NIXfHkZ/9HiaiyMV33TD5fxNt5nEdKQlbmrp92JfFknyDqenU+eik4RvIKzeTcrK12nZK/uAmkw
	NNv0jP1QETfBFY54q+N4U0F6F3mp99uwfwoFH+5lwwxIPiLoyxQUTLDHm1oPWXBGoQQi25g==
X-Gm-Gg: AfdE7cnYaF9XBbv8rh9lseolvS5meueYa7beAMrnTsF3L2iG1xslEwe9pdDlNcfCFHV
	i9/aBu3NtLoxEeSU629Kxs6URbQcvHWPE7iyAoy7eGA/undQTibc6hKVfTJVUlW85K4KkJMGNkU
	v+HTzR5q/gGWqVYomXEJV+zn9SqQnsbrYpsF6zLbBemV/jH1p8rSJrpxE0dlkUToN/RbvnsB8NJ
	mncF2VPjgzme9znkbv6HU2eu5dPt6eYqQctT74SY6/px2Rlu0oIW0tcE4tem/47bfWDrkLruIIL
	VMhEox7Q7zHp/SUmbRAPcW26C7UqVDRIAecvZ5AyxEhBXay6s9Zaikaee9rCDmFQPe2fKfae6XD
	NCQqHsoRFZ9IhvbAMgp7ZJpnC4dRwpvX47PMTqx73z5MONZz7ZUWyYKbHWf5NxQnkfkwhzyONWq
	QkiRwW2cHZPWogYA==
X-Received: by 2002:ac8:7c42:0:b0:51b:ecbb:206f with SMTP id d75a77b69052e-5213c205893mr142515571cf.32.1784585978324;
        Mon, 20 Jul 2026 15:19:38 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51b:ecbb:206f with SMTP id d75a77b69052e-5213c205893mr142515321cf.32.1784585977831;
        Mon, 20 Jul 2026 15:19:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291daea0asm2540232e87.34.2026.07.20.15.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 15:19:36 -0700 (PDT)
Date: Tue, 21 Jul 2026 01:19:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Anurag Pateriya <apateriy@qti.qualcomm.com>
Subject: Re: [PATCH v7 10/10] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
Message-ID: <5houmyc3fu3grxqajn6ivucct25yz34p66lwha3icmcuj2fb7f@ypz3r3mqwzwe>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
 <20260720-shikra-dt-m1-v7-10-7dc99100c6dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-shikra-dt-m1-v7-10-7dc99100c6dd@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX08buO4lD/pNZ
 9VI9acp5wkJ75D9BscSKYDl9J2K5tZK2gUXRghY6i0cA95tj9EM9LcYZII9jtF6Tx8j0xtVkfZS
 64gPQsB3qPpjuwDyzA7tXHPG4ECVXyA=
X-Authority-Analysis: v=2.4 cv=LK9WhpW9 c=1 sm=1 tr=0 ts=6a5e9efa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=s9XTQAQIpqgTDh4RU28A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: _hCSsry__eK4RfjA7yKoJuaaxijv8DGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX3DdUWdTGHyic
 Ueow2lRgmgNR0y9Xvh+CfbX83McHVSsGoXeqP1ihBQkeQ0eeVTbFNG3MbtFLvfx9XjaM7pXWmIx
 8U+ihx5EDApaLUCuB4FFkqBPz2EC8QLxlKsLM7eief7HJUhiIrSDqE7zchr5Xo1ikA6gOTGTvh4
 +DcbeDLWPPHmvijyYm7RGbRYqK3KORvSNgFtPtEilqNoVncKRPelsqTUuJHpXZgv966wYWHj7f3
 1+ZISYclDMBrmv+R3qszsveTadpzUxDvi7xJosica11CehrBprgPDxfnoRqAAs6PWheWhRsi/qd
 dticwAwjH324vgZALvUkyH5m5o3PAL4tceLIUpbL3KtUso0y0kiO1iV8J1VIs588IA/Bp7x5wM+
 XTDH1L3ZyXMtj29Y74cmxVa1tImLgXU016P4WxnxzcLWuD+AqAz6lve0qloSFYiSEGVwSRDUdJS
 3nGyNuITTpgwj89ETCg==
X-Proofpoint-GUID: _hCSsry__eK4RfjA7yKoJuaaxijv8DGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200242

On Mon, Jul 20, 2026 at 04:19:26PM +0530, Komal Bajaj wrote:
> Add gpio-reserved-ranges property to the TLMM node for both Shikra
> SoM variants (CQM and IQS). These reserved GPIOs are inaccessible
> from the non-secure world and dedicated to fixed functions.
> 
> Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Who is the author of the patch? Why does it have two SoBs? Should there
be a Co-developed-by?

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 6 ++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 6 ++++++
>  2 files changed, 12 insertions(+)

-- 
With best wishes
Dmitry
