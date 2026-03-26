Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A131E849
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490355; cv=pass; b=kcySQ8C0+sD9lDB/sALaYAGn1O84UY8kWG8buBUpWma22ktG0z6eHmJ6PhJYCPaYH+1qGvOBFVdMSRw1ZqX2IRzeNOswsfnEQRl4P+qNKALReqH7ak+6ZDPsxWV+KMJTE5y2HD46jFx8yjOGP+A3ZNVwf6BrGWSxaPB5TAeCbss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490355; c=relaxed/simple;
	bh=DFDO7VGoKhW9LibtcXJDRr/OcOi2kDPvbAzGM7JHtTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKbJKIP761Z5fZH89EDyZXXvte6UFtonjjjkDNgfIg2yqc6bPNLoUXM4tZgSPkf+4DbxxU/2WsaWJIyu7QpDO4djFxbHfgrmCqWUeS1WssAYBNHV2Mha8JtO6UIDkl+rIkfjUtFxMDM7MxgmN94sXjwOfF6WvCcIwhZNoeEotrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WwBkdG+b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FsGH+u50; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WwBkdG+b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FsGH+u50"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PKku1i051543
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jPgKrOCs8BV3rkHFf7zJrMHg
	/ajlW1vtOsuJgIMhY9c=; b=WwBkdG+bMNAv1+H4wYjSz+Puf4Hojd60sfYMbVLz
	6u7s1GcBAeZuf7rFY16XZRNNen6tUahqZmtZfxf58grsNZS90izuJb9GyiJNwA6l
	jyUtMU9c9gJrXpHrck5QXhLaP9mrc528Jd9uoA8GdtA9jR7E81ExXKHhYrVut73E
	4cXbuRf7ecmlOPp97UnydVYHUSGS0OAIeX3tJ/pfwMRH6KAgVVPs7d2FLHk+1Ddp
	FBl4Fp4U4exKCbvqP+V60vrbx6Lk00MyWfKihdu/ceUYWdPEjIB+Btbd/DQ866/+
	+Xeyo29QlF7hT/ik0vreVZ1XWS/2CHif9EzUZjwWwX9YSA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t0rq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:59:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0b57e192bso4281775ad.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 18:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490352; cv=none;
        d=google.com; s=arc-20240605;
        b=YBw47Ut0FwcsFv+q9IdekZtAX96grdoizqWEFAG7+nCqalvwcFHYf52j161F15vpCz
         N9PUe2rXv1SyIzeGbqTepe86b2Ouqfhu2MoQnkZITjF5dUFWbSXHJqj9XO0E0mWxU2sP
         T5l/WFIGW0CCLOToia5ovf7/tqGg8KiIY04/qdRT4Xa47vcpnEGQPL3ZZ7ePzIBl4XVM
         EZbkpjU7FnLHcW/wEo0HYrng9+FSxk7+ZS7h3/z5k6CkGFoFPfu1iEz2x5kU0JBrEXsk
         dx0aipMnGbWWVLodMQkNBWowalgE/OXE8b3Dds7DTuxDHS/QaOSApkOvmshbXETxguOq
         Oobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        fh=r0KGZCFd1mmpjOLDDEeiw+lRtZAbshRUZlov3s6oqa4=;
        b=g/15N/ITy8XLlo2AvUiA9K8l8L3iwTC5PUIzZS11uuui9mpQlOcNhJ/dZTQtzQE0fE
         9VNIGZ/Gimb7fr8T3alwaZ0FaNATTDDjk36R5OWquaflC3neB4qqcqbzQ0mDc0iOrV/A
         vbOXMU1wjnfq6bKL8OqpOqKOKzY/CoIgYjf+SokJr7qgmtgA5/M2iK39hR7iQpfjOWwY
         xAYXUJSumDwhBAf93eN9qpS7pHWM/RUnJ4Gz2bzk4ndQkZIeSa+QupmsYuWUchx7mgSR
         G4C88DlPdeTl4/COEZZlq7+joaTkfpOn4PoHtwhuZRolMfLI5rPzT88XpxCjCxhBXSHl
         KEnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774490352; x=1775095152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        b=FsGH+u50H7hDfd5eY6SMzZf2ZvWyoVTnMNCWjJPTLS3kggeS/gFVcJBGGv7yziQsyS
         /i6d8hUCNePgWlYN7hb7tHmM7qW204DP/QnUdjnLIqnk/uyeTcrkOZspBM9SE7n77Fc8
         teBXf0BBTs+xTbv6mZBB527yG3Dw00KW4O1XrMifTRStePSGj2lATMjVECwswLN+l5XT
         apKNXqYLhwjZdLf+4yLkWcy/2Pwt7749+JZrnLITEEPo8EPEtCKl5HzZOfiHBhaN+4ha
         sPusz3Rg2PTtRTOPzoxQnmhxvnlfrz4sYKGx7cSz07nWGF7SMyV4kTb9Go2j48HizDj6
         OKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490352; x=1775095152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        b=kLWaEOePhaREvqh1po4M4L92E4fqBsCdYLCZEoeOPS9CGDmxtbJYuGnWC7YuwZzaN6
         TttiN8lUW0G9p4OCKAGeLCm1Fb4K8lDnJDzHV7ccht1oPRvL8xztzj7GAa3Ddqn5HiLC
         jFwANxfsF+aBajjpBk39KDArb1Glpuk3vmG+hUlci+QfVBlZwD2dUo+5Rn3uJT5BJoQ2
         1rOV4HTCygfWGf/qzy1attPL9cgLRWzDMAnc3Gz05IVJpuwA1Y09WaKS0hfzgr+kZ5zz
         S8xggJc2NZZLw+b+AwG+jP2NhuayT28HbdVBgtHpZLEX+RbgmQtfclTbdz1xSR9jUCRR
         AKKg==
X-Forwarded-Encrypted: i=1; AJvYcCVEtea5Ih8Q4NW2EZ7SFzIj017b25vNVXmdWQIXscbUYX+vewKjzXLQrVCCXK3OJj+HK8F/7AOmLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+IIMIACMDkT6I1H+UMOKXBat0aaGFPbRMxs8EBiPOujlmw8p
	BflHH8fNiqk1reAYfLVJltmlq84VI6JseoXnQbZZFpEinRliuZS5YBROrJapTrL37jgbBWot6ci
	4xMAsX4Sww+CceAxo1fbmHdNQIsqz950z7fVFM3gLYpmbT5zEcrxvmTqpR47A+ejlfpltkLrhHY
	tz/xJv4cs6AYmM05pQyN6YbknrRUsUIFtp78c0
X-Gm-Gg: ATEYQzxM2G/eUgiRb8yZBxJWj99dMaJP81TQH+0UY+ylRamTFMlwOKcwRHorayv6U09
	hyfGyMzFKtrfUkBvK8z7ZS2NSKnzq/C9bx4SEGDngV1O7oPmRkrgZsgYC8r8KpPfgIEjn0LJrOK
	ede0xixN4cyZFnq2j5JCkZ5xGdnQpYXlDgGozkmBVlcpt0TxbIZLGLVFvzmND/YHhr3vde2yW7a
	XGGFi2+zVa4e7/3kSDJ
X-Received: by 2002:a17:903:3c47:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0b0abe504mr63387375ad.40.1774490351618;
        Wed, 25 Mar 2026 18:59:11 -0700 (PDT)
X-Received: by 2002:a17:903:3c47:b0:2b0:6df2:8cd8 with SMTP id
 d9443c01a7336-2b0b0abe504mr63386895ad.40.1774490351133; Wed, 25 Mar 2026
 18:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-7-948df19f5ec2@oss.qualcomm.com> <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
In-Reply-To: <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 03:59:00 +0200
X-Gm-Features: AaiRm515yskxcvd1wtiR9718njLTgP_TuNpDNdd4YtWA6E6jp6B_uzG9KDE4-bM
Message-ID: <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-wireless@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c492f0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=l3dzM3eKOFk7Ec1IfqUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ZCWdDTROTJ-g79koLwpwqejccHlCnZJ_
X-Proofpoint-ORIG-GUID: ZCWdDTROTJ-g79koLwpwqejccHlCnZJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAxMyBTYWx0ZWRfX+K4li3mJzz0x
 btPIiQihYYofGC/sp7ot6jFce29bG90Tg7GeWn8ExSnxSuSBl9iTvOwDzIh2sILOzqMLEBGO44t
 gYTY+kW/PO65ayowfsAtq2jdUHNMzP2A/A+PPMyweOXsYFWH36aqZVaYPXZkTVqBDUv1C8QL4pj
 EPiZ+1bqLAOaHVVErZZ85ArGxRgSnMyZeU2q/RhT+AHsGqc1a4w0qAOULMA1kZQ0Fn9VDMCTivq
 YES0RRtdLXEa3Qf7BZpJvEMTA/Ij4ZC/ZwjM+BC6apgenFT2gkXsO76Vf/EbeI/LMyngSlU7lhP
 3JJ6nzgf2l1T9SHNytncfacDOouhobEtt9iXqPNzQKyZjb0sJXq/swrMozATWw6DVHPUaw9pvDD
 e9K3l54dr4JufVRDznY9+Tb51MUowjvwpIqy9AF6j0U+b6CSY+XdX3JiyozDbZz1D0Vw42cOHNV
 IK2KekEy343HRoZD+8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260013

On Thu, 26 Mar 2026 at 02:02, David Heidelberg <david@ixit.cz> wrote:
>
> On 19/01/2026 18:08, Dmitry Baryshkov wrote:
>
> [...]
>
> > +     wcn3990-pmu {
> > +             compatible = "qcom,wcn3990-pmu";
> > +
> > +             pinctrl-0 = <&sw_ctrl_default>;
> > +             pinctrl-names = "default";
> > +
> > +             vddio-supply = <&vreg_s4a_1p8>;
> > +             vddxo-supply = <&vreg_l7a_1p8>;
> > +             vddrf-supply = <&vreg_l17a_1p3>;
> > +             vddch0-supply = <&vreg_l25a_3p3>;
> > +             vddch1-supply = <&vreg_l23a_3p3>;
> > +
> > +             swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
>
> Do you know if the GPIO is common for whole sdm845, or it's only recommended as
> reference design, or nothing?
>
> I did test defaulting to GPIO 3 on Pixel 3 and WiFi works as before, but since
> previous downstream kernel didn't touched GPIO 3 at all, I'm worried about
> toggling unrelated GPIO.

It is an input-only GPIO, but nevertheless, if you are not sure, just skip it.

-- 
With best wishes
Dmitry
