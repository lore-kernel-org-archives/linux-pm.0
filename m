Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40553B95FA
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476511; cv=none; b=StC9y9IEjTQ8K8QoqnVo3DhFG9dGLq+YSxoPBGbW6ETxm6gwJ7o55IyganCyd7nR5FiJ2DNhKPc6WXFf6Js6l8pySIJcjkNFMFhy07bswzLE/trS1EH5yMq3CszDQpcsHd7KZ0VLSlXE4ZB3yegkP4DzbBHnjSFfJExa+cPPcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476511; c=relaxed/simple;
	bh=L9wFPHnM5M00CRBpaXfsBmIyoXPBno+DoIC0CemBM7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1tak2UrN8JATkcNuQm/gaTmF9Ea3lpz5Pq66odet5SfU8pwbNQs9VStzVOxUoECfpVDh7T/3N2NFCExHFH71ybRyHvbz1IN+AqSFCbiDXGI5OWwsy1kTYYtt9Lgcaat0yoCSNovbaH1ZZxaJXN2pqJRlE5ChPp7dgS0PnJ+9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RK2t1VxS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chZAiQGl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RK2t1VxS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chZAiQGl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FA4XZ33611192
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vti70O1HWYPyeAOByJaVa98Y
	XH/bifp1FDhwGKlYkI4=; b=RK2t1VxSvyYbOF4AJaiGsZysh8Lw/Cn7ef5HmtBD
	qbxLsnPjfCXKHJP0K2pEjtyqesfC7GEXQtqHf5fcQaBO79LiwkWCx+Z1+w4LU5us
	/avnM67J9a8yfjaT492WqctzxLX4KhI2Jf52f3ZxtrkCDPv+mnUpzoVzBq2+lsIm
	gx7ld60mJsjiV/LSoJ+bbkdvDgWI1K9AMvnwK6YQDuxnN5EAsTr3SW3hjlKzOetJ
	aqmm8PE0Wcah9dkZufpYNqL32jcLgeFvGw/UhL/o9vM/pw73a6GrMZltZd8I2HIX
	OIACXgBxOUeB+eCm5rnrbBu5A+62k8nUqj0R2wMQ5ZUfyA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtrscc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:48:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c6725e7891so1925544e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789476507; x=1790081307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vti70O1HWYPyeAOByJaVa98YXH/bifp1FDhwGKlYkI4=;
        b=chZAiQGlUgzVqSEJqqY71K+BVT8A/kDAe1UwmDtSE7IfBGQ1baD6nz1jUZHj7ygfsR
         RaPsqSQeYuQ6Df3Sv5BRrC3tfQ5Xvj2OZJdAD9yPsjePsSMit5m00J4lKNIJN1b5oh3O
         XNTR4kwUEnXAfpUJVV+qrqThnkeZmWfYHCHG/o3FrNRRr/aAPgYqkzr6tc3BTbfLs0hq
         Hb/ejk0oMmDK7ZlpySrMtisNy5bF9JoWsOQGRm4aOtvzJsE05rvFvx7fuy2AmTxCwFvO
         P7MufKhEwNCzjtUQEHAvG18On3a61Dr3dbTnK7HBctWDEYln9O3+vs8mou/RwtTSmB1q
         D7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476507; x=1790081307;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vti70O1HWYPyeAOByJaVa98YXH/bifp1FDhwGKlYkI4=;
        b=RMKVnrxfcglghs2zQRxk7Zp8OfP/NJpnUVJLaK2BSAsiyLU/ZOqqhrCCspeukrEHy1
         kjF9RDAoyi0QeNtL1Hw0U0q4WQpYx254R+E6TdO0iaFoZFWE8sDmmHqR8OF5GIpQUsze
         nGWZ86qX7Nl3Xe+u34lvrsdBvjSkr89hMYk/pE58z+raQQ+qQeeOeyMREeinLPyM3y0i
         pSJhoZfs8vDCggLLztP+yg0F8HzpS+YkXLjRgv9ZGltSFTko+ASNAamplR9KKOJKpHt2
         YejVUOhCFxxod5Q0fOHo6GVeUQX7lhyuMzCj0law0+gwhMtfOJxmfckidJ7XaZD3LMqB
         ZcGw==
X-Forwarded-Encrypted: i=1; AKwUvBxiutE/S2JaZagq+pkKvsg3iJnGSgnNE6iaC4ZwcnW+16bOVwLouWIcxhCLSD7YlQZNIBNZmagXkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lUfy9ChTK8RY38EoL4NYAABTxtG+XN1hTQWKKVvdEK55Kijwmf
	7sUclWA1SlFQnDhf743URKSLhbCcu+E54mNkTUB2guYL7ephGZirTl5MVNAg+cong5KAEjAN6A8
	tTpPAB1mXxUjPjpNCEy3nmI2TIHMNzdDnzkD36ijKdF93yyzkLaQRyA43jOV3lg==
X-Gm-Gg: AYBFou05jb/BfThMVYQCH1RH7ghVCQgKuagL77omXUspHLW35Uq+7lKFjv/VqYnHrgX
	YBo6WWkrMSIAM9cYtAHjBEB5sNv9kyAMGCZjbC7pQwFPDpB4NcLPGY3Hfqc4niuvHp/ae5+Je2E
	zm+aldCdXWg0OuK9Z+MhL5e9uykgE3MQePkqpcF7DkE3r00L2v7Yn0Ne2UaqNaiC2k241+ug3M2
	JxfHauYnC2Zf44BTKkf054oVM2T/Zj7KaPfjh7pIeCoBz8Akc2P8jh07xrScsSlM1qY87Sx7ttG
	OooacYyH8bRMXlXZPDtBzL0G3dxdkjpjgk3uw6R17+UdzI9CpeZMZ6Dk4zMGXkX8Gs6QUieopWs
	WlFh4QREB+aDGMg==
X-Received: by 2002:a05:6123:82:b0:5c8:4831:1539 with SMTP id 71dfb90a1353d-5c981d86a39mr950433e0c.5.1789476506904;
        Tue, 15 Sep 2026 05:48:26 -0700 (PDT)
X-Received: by 2002:a05:6123:82:b0:5c8:4831:1539 with SMTP id 71dfb90a1353d-5c981d86a39mr950389e0c.5.1789476506393;
        Tue, 15 Sep 2026 05:48:26 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e608sm36484827f8f.23.2026.09.15.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:48:25 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:48:23 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mostafa Saleh <smostafa@google.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] Revert "interconnect: qcom: x1e80100: enable QoS
 configuration"
Message-ID: <qasmlx6tcqz7ou2zkl7kfbz7ni3pu5iwtjms3xu6lzuwffdthv@vb4dxrpvxnza>
References: <20260915123703.3228329-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915123703.3228329-1-maz@kernel.org>
X-Proofpoint-ORIG-GUID: -cx6fyLsJymK_aBubOtQ_b774P_9Ufqn
X-Proofpoint-GUID: -cx6fyLsJymK_aBubOtQ_b774P_9Ufqn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4NSBTYWx0ZWRfX7XEBhHuG/xgY
 1+Ir5jT5tiGGXxA9XGe/BTlCl03nv9Qg0q/KSo9qTgaCV8H7CstmGciaSU5Pnp08qjmTnfhFlXg
 9Fm5xhTjPn5MyoLBh6UTbz9W7QkLIeM=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa93e9b cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=lAgNKBcoAAAA:8
 a=3rLakIzlw2t6kR_yyQkA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4NSBTYWx0ZWRfX9xeTvh2KKYLZ
 VaGvVutRuONZDBMMaDCQ7bHGzNvf57dWhhBqcvYTuu8NC5Olqn2weDF2D8Fy086MqLeqBK5n8lY
 DGpY+zO72RXU2UghUNABmbUfua2TA9oRK7psNt1g7tkS5+mIrB4+P+80sOz8zZAXe/G2DWwVFFh
 TMomYwV/jU1XIBBAiHzdLxaUaiLu1ryuZ1ls5bWUz6Aw5QxeMYDtZno1SAztNkBJHYxU6o86z8I
 QF7ZwWadwMdPCB/Xo1cDxPQc9AhSfIkw+p7YA3i5xX+NYFCQQnsPjAsfC4pEzesSW6etO5UzA83
 bfrSouQcwRILL4p36oJZ2BMzqI4EcIfmc2Cty/s85h5zNOJ2a+AehbAd9UhdtMw7BPhFMoeFYXR
 3PHfE8r5X9hOuSbo5HMxCDBLlETKQDM2hJHvMTMiswK2kxB97rnB6aA/O5h9N5s2TRgEvURvb9N
 fskyGP8cWYu61ifkFRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150185

On 26-09-15 13:37:03, Marc Zyngier wrote:
> This reverts commit 5a8b2cc36e796d595c9d97eab23c2be22805cc1c.
> 
> Since the introduction of this QoS change, X1 machines based on the
> Purwa SoC (such as the Lenovo Mini X) take a hard reset at boot time.
> 
> Other machines based on Hamoa (such as the X1E001DE Snapdragon Devkit)
> end-up with a similar hard reset while under load, most likely due to
> the PCIe ports being starved of traffic.
> 
> Revert the whole thing until someone figures out what magic parameters
> allow QoS to work in a sensible manner, as a usable machine is somehow
> preferable to one that crashes efficiently.
> 
> Link: https://lore.kernel.org/all/apgeBNSiP01YfNcs@google.com
> Link: https://lore.kernel.org/all/86ld9d4h4n.wl-maz@kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Cc: Abel Vesa <abelvesa@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Mostafa Saleh <smostafa@google.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>

Sent mine here:

https://lore.kernel.org/all/20260915-icc-qcom-x1e80100-revert-qos-enabling-v1-1-cc4ba943bd9d@oss.qualcomm.com/

But yours looks good, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
