Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61806371D02
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419751; cv=none; b=nkbnUrJvSRIZo4KWA0drNs2wLJ6bmPx8DL76BN1V2E6PPRI1uuH7yAxrxx0zdNhFFS9aH2+GI4ryfTbk501V/iDeIRyxiIcIUCMN0vBWZ7sNDXNGr/FFpASD6FGepRufF7m6ucP6pDgA1FvFsr59jz+PZyh15NvC1zYwsfL3ebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419751; c=relaxed/simple;
	bh=C/nOroiUx2tLirDxWurDVQ4C//sLkZOgC7vYB6hGC2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej7lF9UUeTZe+N/WP4v6zEcgDopOZ/lpwbxsod75FFIMGLTw5ywhzlApRJGfj0tvt9YvdtF9Q/IhQi7PGUVbctSUgvded4h1siLumBEbTP4LVGUmCEXMrYhzRhGtd7ey/7ADZiLKtdTOEQ3yQs/ydNmkCMwUOEpt5jFybAeb8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBWckHaX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M7NdC8K7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBWckHaX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7NdC8K7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lKA9721313
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 07:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pX+PuPvcsLEjY2KfdhpqviBYNIleY94z8WtD2Xi80Y8=; b=IBWckHaXl3817XYm
	ukaExoP4nI8UFw2fvAiKrTF6yu9aRIuXADXsJEf1NjhqEBhVxMGuuji0xX/D5NPu
	h9pZ8r2HU1BvmmjEAJZgjChESDu1bUY4V136pjiodEcWT3Jn2f6lFLz3lF6zqXVV
	9+IxshD5RX3pKmDEdoBZbvXWAS2Xkpo1X+n2oJvEO32H4uCfJ9adH0YMVD2xlm/S
	8GRWDdX6Gk+9713Zl4SIf9Eldp6jYflfxnOxEEfG+/K73YRbHlmcQpJLYcCoQH8I
	GkRg60LZaLzASn2XLFoKbcrDXfMW7/QESq3CvjhiL8a3ZMbWYnbhTiNGLDz6W3RC
	hzBgkw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnksqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 07:15:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494b1e35cso42727685a.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 00:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788419742; x=1789024542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pX+PuPvcsLEjY2KfdhpqviBYNIleY94z8WtD2Xi80Y8=;
        b=M7NdC8K7pUZG2mRnC4y+d2+APZXjqOvNJzwevtulITwsWsYjshJXGZYMEm5zaz9sph
         o7nkLtYbw668NIGFwtv/7y0cx0Q/xj8RaKxZ5AjiWONJmbLYh6cebbjrA3g/AKbidrFP
         lQDZB3g6apdIczAt31fr+fTbR/Com96CFYKmJ5a29vLVFoo0y5/zg5xDfRN01fxqvaQ7
         wBJnbhHERCCVKZ75Zn0sOUykitGF+kr6heCTkQfX99SaECIlXSN334oIbPA7Di8Ie1kE
         aWhKUB4MX9u88YaH3i35XScvz6SvD/Ver6LATZDpklX/cpVuu9yj+054FpEaVsp5Q4oP
         /o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788419742; x=1789024542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pX+PuPvcsLEjY2KfdhpqviBYNIleY94z8WtD2Xi80Y8=;
        b=gacVWDBLlGtkhqboFS24FlygdHa4JB7HN2DaAur5DRB4A4H7nVH/CzGeBVrKxk9U3H
         SY9iTWWg8R68hFVwaU5/eMXllhLrXhq0UqIzrJL7BkzcvyLyg7fq9Lgk3xKXphtDdA9K
         U3XGxfMqxVVCCiW49RJ7l2wmB2/dlm4LUWWY65ULQNSyLmmfg8q16r1BluUUcXorIWvl
         1cf6ZaGppCM1qWar1etjLGulD02OwOWDpXbEP7SOa2qM6NCRVu/iWk0jdynrrv5U3ohn
         ajtUQSYBg5u/pDde4o3kgIfRNO7Wax2N+m3CSW3lWgxW0qPjQyogFBdCJArz5kN3ZkLH
         rDQQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6mTaZ7DCB99J8c5QUYaQ1lW+XavKjaxZsp28FDRjTmqHijusd3g06zycy3s9w6yt8lrr9t+/nCg==@vger.kernel.org
X-Gm-Message-State: AFuF++l1z6Hoj/Z6k7LdU5kXtwmoxO8DQhvUAWZEV+dCM9qKAEWDR5vS
	0oOzwMZRGjh/XCnCvZxR/TJduR30p/N7nMkFZEL58UXRoAik0luaMC/laV2tPBRorrUmpPEStaO
	FcZnDQn1rowVgTYvYrgh18U69Tn9W+kV3mxfRXJej2zPZS9yxSYuez7A50U/qbA==
X-Gm-Gg: AYBFou2QfeUpi/3/NArOy878ZzcKzgDz0qiRV3RbSCCEnLL7pwS6FGrRz2xwTm2yH6k
	GphM9aWP/hEZYHR9L5fgIrUSoiHOV2wUJf/JKz9wprqIXpbAg6EoGqe3PgZF3DPmA0FG7L5Fuii
	GZzVA03NEqW8RDnh50iuvgf3qrB55wMVE622r+6v/yb99w/5UuqBDLdHe26BcdjRTBVVySv5XZ2
	wNY30Z551SZdh7orN2A5aEU2X5UlF5dZYieMFMkkTr4BX2EbAbmPug1Uwfm+3uxCbSapX/yiHun
	BuQNYkBSxPtbFN5ACgM2xW6DMqhNjVZjeGUpOVKdJaCuQKNYEdA6vrEY8d/pWAK9xnR8YgiHfbO
	Q3gSo6GT/PYCubXhWWY30wQ==
X-Received: by 2002:a05:620a:2915:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-93960e022f7mr811878385a.2.1788419737434;
        Thu, 03 Sep 2026 00:15:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-93960e022f7mr811874285a.2.1788419736851;
        Thu, 03 Sep 2026 00:15:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f4173423sm55809666b.13.2026.09.03.00.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 00:15:36 -0700 (PDT)
Message-ID: <05b417d2-8522-47fa-aa9a-b82a252048e6@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Add multi-port USB-C
 power supply support
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-b4-battmgr-multiport-usb-v2-1-1a6dd1e06cc2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260806-b4-battmgr-multiport-usb-v2-1-1a6dd1e06cc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o6rWttsvjo0vHpqaLJ9s4Jjhe7JkI4Gd
X-Proofpoint-ORIG-GUID: o6rWttsvjo0vHpqaLJ9s4Jjhe7JkI4Gd
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a991e9f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ErecBaOdECMvu8LCLkMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2MyBTYWx0ZWRfX+ApaqcrlVchF
 LxP73/er1QO+TRuq9pXJI9M3qjP37of1Pov4LLo0eJne/vDiFtN88VNNgOMJeQ8/96W9o6X+58+
 6WdGGQCdb5wAS/SHASHPJLUp9HsQQ2UOhuxcfX4qtcMOzITmnhGBLTW4Rcm7MQtiT7mVtbMYRy4
 qUzEIacFXadk5350TBvW116Z6TuDl2ByTaw9wDxJoD8EJKRYGVeAs6JmAJ+4ocopG/W0/8u6X8p
 L6IP0GKIy4mzkQRXs329ODgqAGhNye7mgmWNtIzN00ULHx7Y9NNkbpvaLRGsVUCgp+BPGKPfUrI
 pDC+Z+NoaLP3wGj5PnvwF8Zzj1Hms0Swl1X/ME9NGXZ3judxCPagxD77VL9vaSLG3ATHe7ao7b9
 fLDYgFY5a8j9eMNLdP2sIExmkg3NbXAhmuvDkwGFq1peW3hDF+/AviTpLskJzzBQl1kW9oEiG/u
 7dhWsHj0VpqK25orgqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2MyBTYWx0ZWRfXws/X9/MVZt6K
 rFeIlTTIrVn697qCTTIPlsXG0ddaB/Rj+STH7mZPh7N98rIUmJX+RImpRCPHE44V7YkDaNxrpxk
 1uFBPjLHQteDPDe26Nip+W+kUyjM8Gw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030063

On 8/6/26 5:06 PM, Kamal Wadhwa wrote:
> Extend the qcom_battmgr driver to report up to MAX_USB_PORTS (3)
> USB-C power supply ports on the X1E80100 & Glymur platform, which
> exposes more than one charger port to firmware.

[...]

>  struct qcom_battmgr_wireless {
> @@ -316,6 +330,8 @@ struct qcom_battmgr {
>  	struct power_supply *ac_psy;
>  	struct power_supply *bat_psy;
>  	struct power_supply *usb_psy;
> +	struct power_supply *usb2_psy;
> +	struct power_supply *usb3_psy;

I think turning this into an array could make things more obvious

The defines also mention USB/USB2/USB3, so I think we should either
rename USB to USB1 or re-index them to the more natural 0/1/2
(or perhaps primary/secondary/tertiary)?

Konrad
