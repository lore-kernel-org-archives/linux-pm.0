Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B60286891
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750001; cv=none; b=bBcF79iMfrbdx7v0RoRsRPAOk+AM8va6MaEJtbBS+BbSTGxB8fvEunMCH2SH5/LQAchHWT0/mKftEy8CZ2rzqIdJtJFK+xNqjNPtp+qMW0BWw62m0oCuNcjBDicgsCkkku6m0rQ4gqsb6Fe5ULJSejeucJF3vAEp59sP2rfiT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750001; c=relaxed/simple;
	bh=OI567XHaJA6LozE7XWwl+YveZRRZTacd3XbS8yKhF5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvORNQ8Mih/8E9OAcHP3xqjIu7B4t0z+Tvf/OVCQ3tzG9mCa3LSmCGVYBbrHinq2OBz1JkKVhM74h9b3Hkbe4HaFCaQsCVFvn3qEaNhAbFj5c/twOV8uUznqf7etHBI/PvJyuY9mkHkF4yRhotDLhGnE8+UAjvzdU+6xRIkTpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqT+ZoyP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CYM/YM2F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqT+ZoyP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CYM/YM2F"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BGWJ21301770
	for <linux-pm@vger.kernel.org>; Sat, 6 Jun 2026 12:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I36GPlABczqU3ZvBjdX1WKxM
	8wMh046hFW/NpGLSrOY=; b=HqT+ZoyPu7rihrID5L+BzIf5xcfvfvCCSObd1m+x
	wbvfU8azUbim4fQkVhepBhZuOpPNUJR9ENl6VTx++tqfZJ6x4ViWO1dWatBB6Wzi
	64CwBXaz+dEmvdJ5ySZZ04ayt8vEFoQNrMFvuWxpAbSbFZ2yQInPdwFfkVebDvcE
	0kp2U4xtexlKiRzXLACGyV/R+A0XW2N2gZtjquclB08VgUzF7U1lzJ5xswznIWZF
	4798Fdkxj5cM956yRAgJT0x3/YE6ThflMjD2JWkijcnykxfRVvdu4aMGeFo+DJ46
	BhyCub+RLD03LiblXY4uf+dMzT3W6qtOy+qYDgsoExAGQw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx68y60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 12:46:39 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9638fe9399dso1447022241.3
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749999; x=1781354799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I36GPlABczqU3ZvBjdX1WKxM8wMh046hFW/NpGLSrOY=;
        b=CYM/YM2Fwa7E7MlLUu8bP0npR3tWAYYrU/vdIO49uPON9lOtSa662G4fJOoJWPCps2
         bXbBh4IcLxRzQaLD/f11zFt7uwCDrkDWOaoDF72L91HUqWPvmw8qrcwUl11imUpG7wiH
         cgJhEf7H3hpeh6AKYxNs2WzMwJcFPlEZckwcKbfluO2KlKjdauH+MscJf4OgtZOgcDd8
         AUmQGpFygWaXrULK629S9TuUu/hK0unqltQO6Pw4R++ukriwoKAGZn40I+kAGJdPeSB+
         aGVMZKTCFRTQt+143P+G7QneM9xCVYxGDmcSYnVVKBappfkyM1NypSjVySY/zU64jEi5
         M38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749999; x=1781354799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I36GPlABczqU3ZvBjdX1WKxM8wMh046hFW/NpGLSrOY=;
        b=F8Py2UMOKWNDL7kPQWlLtZcpx0xCYCBw0VQalet/4mpIasYWRVHOrGEVzu0i0aR0ym
         zGo7YJ0oCW91pqg0QhhaeB9PKNwS3RulQevPxQSCiUM+UQC7AVVWKmNqRb71w69ubPky
         ByYby5wum8Y7DS0v0/saFnV2m41UOpxVE+D1DNZ6QytQXv6zHEgfYinCzdiLvnD3HXsW
         VYEvb95nnXDMqaWTT3UFvz9/lzUbzteGCzZioM2N0RflbdJDtqaCFIUEvstJutyL5ql8
         Yen32vWki/fq1MwRilTRO6wZ2DXBd4cmgWszTWng7Nhib+wxz1frfNye1SzT4t5twzv5
         dSRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t+kF5Kz6i2E77/6iHtwsmrpcjp5STUBtOzgzSXE9BZ9wBOsxIJmefV4So+mkAbeUSzQ7S4ErGng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCQb/PIP9yL6c3YWhqmVmcWGQIhzD9zZsxoo1X8YC5Ss4GpMN
	xyJsD744mTf0FcZ3QU925bMXJnIhWq335ICHvhUocuqX1BiIfTkdobhHFs6hl3iHAKIHCB1AbCb
	ps4ISFvpLfkoR2YI90VdVjhY9AkKmv8OWinNs+dFB/1xf7rfspJtPiR+Kq9AGOQ==
X-Gm-Gg: Acq92OFQ59lifzifHUn0JOb63yXAW+TuQk3TVjemnd5cQ97MWA6OF82kvLS0DGOdw+4
	C+8Ev3xuRC97MnHw5bG/TP6BaXkVvdY5f4wvElN3gg8zga5ip6s7LcAne7cGhfgYH1fXcSPEJzv
	N7sPkjGAiaxIsarbaknrLaBYS3NJqCbwC6yWtV4qAYfWf5w2T7V/p3/5Gf5T3loNxXO6McnXmBV
	cCaf6oVE+f4WRuj3417URebWDUhIATtAsTDamr1csJc0QRlCyQeJPlRq0zqgXHgVawdqF5tp7qv
	29JHraBSwZKIM+Cae150QbMFEngyz81UE04wN8KrRoWEL1m14fUcvrRIwdWUQbdsYfJ4tnY0pWZ
	jpwgM62weD72essYhTVLmFvtjvdD96psrPXgwOhmJts4VbPHhlv9D6le64zYWsKwnYBY6Cn14ZI
	sF4El1Z5eOLofX4G6paKT+iFqUqlKx2PKRD1RbvFM08ZoVxQ==
X-Received: by 2002:a05:6102:c03:b0:6ef:dd26:e2c3 with SMTP id ada2fe7eead31-6feffcf11e1mr3964109137.24.1780749998995;
        Sat, 06 Jun 2026 05:46:38 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:6ef:dd26:e2c3 with SMTP id ada2fe7eead31-6feffcf11e1mr3964092137.24.1780749998585;
        Sat, 06 Jun 2026 05:46:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abf66b1csm31175831fa.9.2026.06.06.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:46:37 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:46:35 +0300
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
        Xueyao An <xueyao.an@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/10] arm64: dts: qcom: Add QUPv3 configuration for
 Shikra
Message-ID: <6u4rkb5b5m4p475h3excgaufeipor3o4oifga4dmsnf3rcqe2j@b6us6m4h6m6s>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-3-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-3-0fe3f8d9ec48@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a2416af cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=lJH66iwPDgcm3tFhcnEA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNyBTYWx0ZWRfX2f6CmwFPjtpJ
 UK9EljIqvgBYNmusX6Yqb23vjcbeW8KM/d6KUzcKjXn2RDotC8UOXxxvkcs6pP0YTiy3stTKJBZ
 0SapiXhUke/L93XzAAeD4rlvCNYS0/z3YP7QdHqsXhoyMUFgH80alOF3TkfT8dmQ659eleAcIdY
 AOr75uaqgLCYzeGZZPgjBjebOJHlXv69vf6ehuBJA752FV7EWdBxw+HvTUt3FK2xaMUJcTaH7pF
 QGRDMGRhzPbDyefoNZonZ7u8ao7ngCWD1vFvlqRGln4rbhPxBaIjwOzqaT3T2Jxhcp+80m2HXi5
 p7Z9b0II4/dv2M3/5HkLK2CObxyL7/rQSdSOe4CPWatXXPcvGSmQnRyXvc2d82a6BEFw8YiX/mg
 h6DAaCdSBu0aJrZTn8HB0C+xGur9CxEjFumvvvVKqVQV1jwUkBTnCTQw5PxVoE8iYesk0CAQsdC
 +qDgKyNBNOpEZTxt+GA==
X-Proofpoint-GUID: XqIgW_KHa7nR6T572cAv-so_vhlu7Eay
X-Proofpoint-ORIG-GUID: XqIgW_KHa7nR6T572cAv-so_vhlu7Eay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060127

On Mon, Jun 01, 2026 at 06:25:05PM +0530, Komal Bajaj wrote:
> From: Xueyao An <xueyao.an@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Shikra.
> Shikra has 10 QUP serial engines under a single QUP wrapper, all with
> support of GPI DMA engines.
> 
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 951 +++++++++++++++++++++++++++++++++++
>  1 file changed, 951 insertions(+)
> 

I didn't completely cross-check, but it looks good otherwise.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
