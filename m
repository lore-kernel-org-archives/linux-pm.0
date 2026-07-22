Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC0204C3B
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726368; cv=none; b=KtpSTNT3fcKQH0qETsLLXrwEz6+3vwiGItYU9sPAgxjBx7h/xOApFffUYgGfI7Ylg5mH2GSRYo9fFoUL5FTz+4lU6TeJKNvFGjE2ieqQTECZbpSQFhcOx55w2qX3OD0bwCo22n912uEb5wVeTyQGi7QtH/ZEH3IX5FwAZvNz9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726368; c=relaxed/simple;
	bh=H7xGXrauGjlu5C8rK1hILg6jXkiS69crqkUF3Z9f4rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJM+4/fkLEJySSUtJfUklIwXK/7HkYK+KUhuXg9/j8LYiXliWpY7sl8JdPFLaZNaHuLhnpwatf7Cyj0BNNw/JFsCk7kxyMZ2wz4tThq/zVzlT/3GtTMIyPcVE5FW1gAKHjsQEKkm6xzPHZuW3I2Z5H4UOaa7hX8kAtW74MVUs1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEx8jeQI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6T/phV5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEx8jeQI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6T/phV5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD1pLN944760
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WU6LFLxtk1pyhpL5rLR8mU6q
	z9tm4VLsS8di1Pb2c+8=; b=bEx8jeQILrJXnGor6QGPQf5tuprG7e5mt/VAriRR
	BDMXZZ1k+naTxAsJa9JO/xgtX/dMK2uWqjFTC9uBLKD4rElVqn9b97zn26zvE5PZ
	2ADK9dHkqChDVyndafUWSBf4mnps2ENDEGKAi8bd2MpuPa9R5WokyZlTDdyASdPf
	t38yFd3YFGq4myOISHrQZm17R1ULuI3Aj/9+7NHwku1pkv6pgQtguLc8JXqQqVYQ
	tx6JOE0voRhJ1KSj/obN24RNGEXZcFj7DWjODK3jNEbT1AJcfBFv2Ck3kHP4z263
	taPbESS6SffjESbNqBLvV/qtvpxA18FV09cZAcG1Zt6gzQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjs929fwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:19:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-520a00c7a03so163734961cf.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726365; x=1785331165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WU6LFLxtk1pyhpL5rLR8mU6qz9tm4VLsS8di1Pb2c+8=;
        b=d6T/phV5U1Odys0vcTstZDBgeks3TYuKYorImm8pcTHQr2uL9eiSuuB0U7nsG3A1qA
         Q8QAW19q6f+EPQyehb4l7xHopBaK7L3LnBUB1wG3oU85bn1L8pds8Vatj7SPU4UPh5k0
         wGn+ZADJgeAAeBa7lOPY5iD1SEW5lPExeX/niNPIvtl3K4AEBt+ZdaxDDz+HHuf1E2DY
         82nV06xE/X4j21NiIiaQfBnr/iiF4ps1tAO+Q5HzyatUjrS9EToO64pHJwqNIO7ln/ih
         U7K3EDZjns3AO82c7E0Lay1rf9rdPdi7g+f6wLshb2y2vZkNvV8R/CksCX0oRJolV4yo
         7dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726365; x=1785331165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WU6LFLxtk1pyhpL5rLR8mU6qz9tm4VLsS8di1Pb2c+8=;
        b=MM3eOtvWy/cAtXevJEE64DaQc8g9XQXfVC867otgJuUioZb8ewo5XO31geSQWCaJtu
         QSsX802Gu71dUIP3340Pb2OddUtofsUjfWOAe68tTGj7D3D0taINbGIxyTV7tjIDSRLU
         UqD2Zuuryky3d/y4xsMDLzy+2/0/ixLcXwF643SqyD6IZ5Z/RPacWT7tTigYZLdH4ZBB
         Zb/fVr8UhfjPfrgC4aCkJcALFR/tAjOq/kzNUZnjB+LwqkQrCw9ODWTfXvCxJqDArnlS
         l9Q0QNtAJx7ZneWw22TKKwtcDpXtAWIehNRrbIiJiG8cM/TWefVZurETUG+MaB/gb7fm
         g26g==
X-Forwarded-Encrypted: i=1; AHgh+RqqKvVYY9Jxl+qjb218pN4WR8DM2F6tVu8e8AgKXVzF451VDqPAGIUMnTL+y9AIKiWcUAjYrn157Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSAhrvX/ItZ4+OD1M4jApvq5HYNvu5aTt/kATL+n7fBbux74C
	nZ4oQSP+OAD6bZ5oiU1yJtFiOAOk4gb7rhYjrSd++H8Z1eI091G7Ejmos8ONM3WhL+8XDQ3Dj/z
	w/Qh1WNUz/InxgA5YC4soo62Oe8tb3dpiL3Kvu2GjwLh8sVwj0TYXi0IG2Hsi8Q==
X-Gm-Gg: AR+sD10y3lLoiVt+mFepgmG+wwnsWB/ULM2Tb9nUEHacOSh9avOFuGsN4szbJiLwNFX
	PhZCBCWV7M7dmnmBa5521N5/7WDK4GtJuwaJqg3spYYiHqM3o7ScnEyxI7fLsy15MGK+kg4dfFM
	6j0Qo4vSz3o7bsOsuJFdCRp0C/yihi4YqAT2Y3fIHFvrH3/9my/4lUL7IKIGm5ZW05pF/Y1yoDw
	4YLR1pvI4fu4xNbJnDjnHo5Hlxvon57ckof8bkdu4EYHA060pombwMcxEgvqrtGRHNwBLoPSI9a
	F3QNYdMR0eWEjxzGelleE6837si+asv86rez39Hvt9laWM7jNcoS5sYFE6KCTLLMw3G3p6BSXx/
	SVnHRwZY54i3TKKstMJjj1W2Qzq9cCv/DHrbWi9EzrGxW3UgzvQo3I/wWWwaO+dJHhCLjPosRP+
	wAPzKeTtapemHvrg==
X-Received: by 2002:ac8:5f90:0:b0:51a:8c9a:8fb5 with SMTP id d75a77b69052e-5213f2788c7mr216839171cf.70.1784726365339;
        Wed, 22 Jul 2026 06:19:25 -0700 (PDT)
X-Received: by 2002:ac8:5f90:0:b0:51a:8c9a:8fb5 with SMTP id d75a77b69052e-5213f2788c7mr216838481cf.70.1784726364629;
        Wed, 22 Jul 2026 06:19:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9d318a8sm475581e87.42.2026.07.22.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:19:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:19:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Message-ID: <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX3BngoT3giQUa
 b1ajF2rbA0j6jlbytjasQedP7MScOXHHH/E+y5v00BzvEQ7s3xs5DbT6EjAts+hy44AC1P8nvOX
 u/iEn5dGDLWG36vFBHKKKjvODga//P0=
X-Proofpoint-ORIG-GUID: GD0e_2suwxhLR29nOtq-SBG9Jp1YLEZ2
X-Proofpoint-GUID: GD0e_2suwxhLR29nOtq-SBG9Jp1YLEZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfXxDpdilu9ua9i
 wKwuMTqZOFqLS2CgN4rBs7/NiTasje6hW6jH8poZYPENO5N0/68f9ESTNXsBSouHqMnPeu6DkDF
 7+TVJWdWZWGKY88kRdwyX1M0x1EES21MwcNUPhjkZ6DbG1e3aSBDTgElxjjxF5sqvwhGk5xDzrj
 Mgrpuxqyo1fex3nA4znBsBcVvXjwlhT4xWM8lVe6ZhX94zpq0T3hYKgA2xcVHoU7DDinJ82c1EK
 YzTwegQSDj7acVt25rNgWhUqqF22dRxUQljTfnJAFyRZ5oCIiMXa9VMUfzdKG4EyZ21vxABmE8u
 OsgcR1xYuhkkwOY7rVNNPgKXthxJoIUU/wTbZlRkcGBY1OkbdHfCUE55g5p5YvXranqzJ/QZSbV
 MUG46yWN48hDfSYfcEGGaLQcMmMXlo4FU+OSnGc91uc1YZnINEr3scZqy44W8cUUN608r+4orhy
 qLw3RWZzu393gFIJV1Q==
X-Authority-Analysis: v=2.4 cv=QahWeMbv c=1 sm=1 tr=0 ts=6a60c35e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=u2VBbWAUoUYCFW06j9kA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:09AM +0200, Loic Poulain wrote:
> 'bt_power' is allocated dynamically only for a subset of SOC types, using a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
> 
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicated
> SOC-type switch, and removes the need for NULL checks on the pointer.
> 
> No functional change intended.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
>  1 file changed, 26 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 81fa41915363ce577ad7c6f25fe1b0a69536d462..7e4cb03d3db0722e5f9fa2e7a5a9a0894bf4f18c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -226,7 +226,7 @@ struct qca_serdev {
>  	struct gpio_desc *sw_ctrl;
>  	struct clk	 *susclk;
>  	enum qca_btsoc_type btsoc_type;
> -	struct qca_power *bt_power;
> +	struct qca_power bt_power;

Can we drop it completely, putting necessary fields directly to
qca_serdev?


-- 
With best wishes
Dmitry
