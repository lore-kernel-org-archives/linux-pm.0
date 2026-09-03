Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61078433050
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421473; cv=none; b=d6WzL4PqWTcnCXFJ8IILgSu9eTePzH2DMl/H4yCZ/L+Wb7XgZXVW+pj8JK6oSZ9FG0eaymBKbSitVGfbuqL9RrlaIr6KlkkbatiKfqdk7ducP+6ifYHOlULvgkL8oGKTw5KNTgiEU5r698NxbRP6Zk3NCeAkgumGflHWqeksa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421473; c=relaxed/simple;
	bh=ucF2EVxtrIYoxtwjlkqVyNBpVkby+vfh+VGNmzhPjeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNA+tcGD/LR9ify4CyxzSWeRXUnMIDtgGaEUsK7erwLnDeF+glElf1syL/j1D/tMkUS9IpypmenWM7DBRd6EEXbjK2WO0PmpGbsez9BznQYQaO/jSPlrN1CXn7r2dltTx1l+VNG0TI2JB5s8Wn5cW3TaUyZA0qlKK6ddCbtdPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d9GxE2bY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bzr97yYx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9GxE2bY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzr97yYx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lYun3244943
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 07:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X4wlcDg8ar/Y5U5ai2uST/XXVgdvqbZerTIKwtSKorg=; b=d9GxE2bYbIoV9J6n
	3vAdo8cRpuhlBJpyQyad7H+FU7PYcbijJP1ETlOhTt4xdJ0Xl0ej/Axf4Ez2yfzo
	7SzmhzSuhOM2tpH4P18CCBXOockXvXOnlGxZdEiY9hmek4iyeFvT4jNQnzkHImRS
	0XyUQsYVqLkFHQnhKdnAnIu0F55XT2M9HlSJz1UiRZthqx/YS6IwmiM3TDW+Pj9y
	YjCehQ7iDz7IEJPhgNjTEvimqCGkZtVVvGf8AkB86Jbk06arLz0XgLN6lbGnap3V
	KSAFy9tjCo8618qpilFxAa30JMpECeNKIVi1Iowkaj2wT0DuT8XnSHTp4pXP0SjN
	xKp56w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemcecc24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 07:44:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9390890ae83so44185585a.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788421470; x=1789026270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X4wlcDg8ar/Y5U5ai2uST/XXVgdvqbZerTIKwtSKorg=;
        b=bzr97yYxf0fcNeudTS5dAAfUAPqFH+QCjeOPEF/lS6POul8EcFEEN+y59vqcG19Sk3
         w5S8a7Ipy5NvKc1oL8N3zRbB9AUIfg8QQfMKd9j4nqkuAh+zGEqxsE93zRI31N+C4dU1
         5NwWXRbmS7/XkVIVB6nh+pEKB515js62rYrSH2OhhymikFGq0+agVeHKu5/jxV1FdJm4
         pfaAPagPwcYTWBhfWqLlwRp+0dQGefN+O8wlHAK0p1W8WT3n5MRzadPlgcDU2cYnvEAU
         LKIqR8EWxldOzCdHRTjLOnDEGRwxnDG7HQn3HkNp8GAiEi7mlWBk8kMHZOT/fOLAiXuK
         UiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421470; x=1789026270;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4wlcDg8ar/Y5U5ai2uST/XXVgdvqbZerTIKwtSKorg=;
        b=hT6s4Dkp/DpM+UeJiRIyIq1uvq9DivnD6pAuvaRc3Q1lu02Axqjcg+fn3GenBXLBGA
         0RU+snCWx7v4ehucrZGoWXWjkhIqrqHXkeDOBQKxG2Io13hPcUvy6SCP5gdjijyy1SoN
         xJrbfizCiH+fsK7+rIZaqKr8/WVyC99Sfqjq1efwVT5efqvnBEf3VNlW3feHJ5gneJgh
         5glskvHHk0aXMkx8NTuu5glURaLqvAOdOImWUOab0LgjqN3Hq2nz0wUPCK0wy8uzJNh1
         Z+C65oTcq7YVdYrXhKNTTAGLrzrFpLz5+ytTJ2jimDLfcTPS6NWCqzayiq9WEhfTc5sH
         e4vw==
X-Forwarded-Encrypted: i=1; AKwUvBzZn5j7zZv6C0CfEKImEWAst65iJFE4xT7L5SDDgfRWcI3dvHK+50oTzqTvlyRf3H4qt4xwtooqfA==@vger.kernel.org
X-Gm-Message-State: AFuF++nz1Bm5QpfEiq/HAtgLZ1lrUS5eephSz52cBdE6rjvMWtmdEQ0D
	6ZIv0f+0YrpnihUektgTKR5KHIpADxZGL7MSKwKYUxj9whnMV+cyfRw5615h0GmOtaG/UMNtXzl
	cO2kIdBwMT33HNkHkz0glr5Y1hHUvCjicfJQBsFBByWHp7iS8WZW46JGrue76m9yC4Wc37A==
X-Gm-Gg: AYBFou2/3TfHLeoyt5r2+nqrIRtG6thD5MZaNcoupxy7hAVG4e85UrdI1Z1piMuSZhr
	5sg8Cp2FRimIaR9TqaQd/b5NzXCk1vNvi1E9Iu4RCot9pmDLj7JR/T6KH7WFRbvYUOBtW8QZobN
	BxJ0CbfwmiNgSv9m6b/k/hWh8DBDA7r/XIK4D51qih1kjuKGZOT8qRq+z502d5ZkX/U20NoRJcH
	g2htGoU6Bfvf5MmQC++E/3DOKKSVMhPBmuVEoxdYeIreX3CtHpVHZWJj76BHabWlGJEcaf1K31u
	aGgKr/8cY07sGivcpAjVplYQN7r8LnA5Tn0/M+jsHkwYd9YVcL2dBtXpqGmAezjsr8bMYr+ARAU
	MahZbHD/OwrjABxc8LsGN+g==
X-Received: by 2002:a05:620a:4623:b0:939:48e9:51a1 with SMTP id af79cd13be357-93960e1e27bmr745787885a.2.1788421470486;
        Thu, 03 Sep 2026 00:44:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:939:48e9:51a1 with SMTP id af79cd13be357-93960e1e27bmr745785285a.2.1788421469895;
        Thu, 03 Sep 2026 00:44:29 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f6c2a8f6sm46285266b.35.2026.09.03.00.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 00:44:29 -0700 (PDT)
Message-ID: <e4338457-dd40-40c0-b250-b13246e8215f@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:44:27 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NyBTYWx0ZWRfXwa3zxGZEu8L4
 l3CnJmkhB+YSYtVbJz+SnODfekL6Kgp93ilpttNfCPgrWqc7UbN4faQzyV+z1ka36y2sEyWCDjV
 4i2/s2KrAVxLa/TtKvuroXz8Otwovl9p0eDdGFKSvbtwLcX14vBFeH6U1oqsTPCq07jpvg9xpJc
 PShA54d1ko16ycCXfBGujyo/bZCme98SgqObqnbUD/69S55QiVHePaPlARtz/Qg/03mNZCZYP3F
 5uu0y7uI57xDejy90Cw464bKnCOKskABIjJDHCmApHWkP6DHZEwBZ0a7RSnIgoQs46qi0/CfEKU
 zBVB2ZFWsTcmR6pNFZjZAcANRVZOxb8mbagOI0/TesO0KLV2D+3yOdwZB6ICiUoRXYYFuTqLWPp
 grKgq2CFZKh9ydJpK+ixRdUn7CBHFo1MLpY4j133bgIPWPJTMstXCzpPBZXXHeuxvIE70a5wGBC
 LT0SE2tMnsYWeGtbmkQ==
X-Proofpoint-ORIG-GUID: C73yB_freVS6EAaCjYYnwd05E5mFKVWa
X-Authority-Analysis: v=2.4 cv=QfpWeMbv c=1 sm=1 tr=0 ts=6a99255f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=katsNAF8sUe2rKcHUFUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: C73yB_freVS6EAaCjYYnwd05E5mFKVWa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NyBTYWx0ZWRfX5VJCLoM/lw9G
 sxxitqXXCp58YFhJVZJ6MDsqUnuvPS3Bf45HXeS2T4xeoqBESjF/Y446k74beJs5RTQzXhNbVWv
 nu6kIwJ5pV8eaFEP82Y1/1NTeXfWyv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030067

On 8/6/26 5:06 PM, Kamal Wadhwa wrote:
> Extend the qcom_battmgr driver to report up to MAX_USB_PORTS (3)
> USB-C power supply ports on the X1E80100 & Glymur platform, which
> exposes more than one charger port to firmware.
> 
> At firmware-enable time, query USB_NUM_PORTS over the existing
> BATTMGR_USB_PROPERTY_GET opcode to discover how many ports the
> firmware actually reports, and register the additional
> "qcom-battmgr-usb2"/"qcom-battmgr-usb3" power supplies only when the
> firmware confirms a second/third port. Each additional port is polled
> independently via new BATTMGR_USB2_PROPERTY_GET/SET (0xC0/0xC1) and
> BATTMGR_USB3_PROPERTY_GET/SET (0xC2/0xC3) opcodes so its properties
> are not aliased to the primary port's state.
> 
> X1E80100 ports report their USB-C adapter type on USB_ADAP_TYPE
> rather than the SM8350/SC8280XP USB_TYPE property, so add a dedicated
> x1e80100_usb_prop_map[] mapping POWER_SUPPLY_PROP_USB_TYPE to
> USB_ADAP_TYPE, and use it for all three X1E80100 USB ports.
> 
> Give the primary X1E80100 USB port its own update/get_property
> callback (qcom_battmgr_usb_x1e80100_update()/
> qcom_battmgr_usb_x1e80100_get_property()) instead of routing it
> through the SC8280XP battery-status update path, mirroring the
> pattern already used for the usb2/usb3 ports.
> 
> Also add the POWER_SUPPLY_PROP_CAPACITY entry to x1e80100_bat_props[].

This should be a (easily backportable) separate bugfix

Konrad
