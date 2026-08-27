Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8F476698
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849850; cv=none; b=s/dCidMFYHrKqEXMtvXdMFTthgWs0pQyFPzM/DSZLsRJCG5LMm0dLSFz2sx/tdH5oeM9SJu+/2Zc4a53QewrlKFxO1NMsjU82l27aYVfZV3SVLg+L2Xr7cAdCV3sJqfXZ8VoG/z9VfdCnCAdsojRzeqbQromYhXKR5z6MfQ7HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849850; c=relaxed/simple;
	bh=qEI46zWGvj414rMM6lTChTcs42RUxnnFlPJd8dnMJx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJqQdyNKD9M1fVSh0fRTPBZmTO3bWVXurGGOptvuVAscVU5S2CLk007RCXS1udM7RMdmzmhw+rFwnIrL0tCA1F3x+/qfxhpTsBSJLcq9NVjEBThB+uZajACi68WGk/ZjR/tN/l9e3L5UlfFsTl9p0GefMTkI/aXwwvQt77fN2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=arQpIbpc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Szeiu3iO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="arQpIbpc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Szeiu3iO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFc3fC3921931
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oiZ7uRGm/rRj4Rvi8JYAu2VtLeEDmJodOlaaWxlqkG0=; b=arQpIbpcwtLvFFTN
	viG3nysBDMW7KpAs8xxPsTGsyxFADHyXX3EraVSEpdGbOr2M/oGljNT5of0mGiFl
	moPdZmBWMTs2LjM3dswcLvfLq4zfCaFxgK2MGfGTjCaKq44c/q/+WqihTzp/tB+w
	da7VwsfsMVx7YDgF5rTNwMpp5OczfG3dMb8gFdzKAMcPIIWdq+gk2Bs7/xZIsOwv
	8po/GXW4E7zb3KL4WWeDbSEauqVxaG/mD40dj8LNDtUCtyee+ieDxaEx1AiT3bMo
	prxt1dKsCjkjyd/ZBJ8Pzw3ZE4GnXX0rhCGDnL2IBjdsf7AcCwa5wEDXD6CgKtFI
	bxmM4Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw0quc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:57:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb6823efcso739035ad.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787849847; x=1788454647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiZ7uRGm/rRj4Rvi8JYAu2VtLeEDmJodOlaaWxlqkG0=;
        b=Szeiu3iO0v2kPGqjFm7z7lpKmOVkyeCmvfugVtG353WoLmqJ4as+cVPg1yxDDscQg4
         sXKlx3Bis3q7GWvILEXfcFMigbUQnCVhN+vdbR8NfDsmq6rE3h/OMjJ1iriPXWhCj/Yl
         gaNBGUhjT2Nqn2V8Vs72jgvGObmRutQ6WqnLFVWe36RzKOewvngEvI5qEvMPvgjGxyA8
         Txspb6MhJgX95Cb4lie9yxds55vMRmOpQ+Bji5H//s+b+tmuYFolBVj21SOaSoR8/HZY
         joA5YeEA+Mgky8ee5TTQSc5G2pPAXu0GCgtgeC/m3zungFsrnoDOGmoC5L+dcjT12K27
         wA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849847; x=1788454647;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiZ7uRGm/rRj4Rvi8JYAu2VtLeEDmJodOlaaWxlqkG0=;
        b=E4/C2R2iYxbJuZtyGJH8RQ2rLEWsiL2BXE+dRdDuW1C3xszdgxKo9rlUKdQhrFKLpH
         8YtSjqpVhj6wp29sBksGayQyBmiEXT/An05R1iZMFC11ipf7K5rXKwiRnE6OHxAxCruF
         /67gibxAJGPaH4Gehf+UrQB2XVNSPLlAXm51i/lqfH4N1jhn3UqrUFnKkahGRQTBwJol
         A2a88t9TPpgu3neDQ9HOBk0YuTcHt8zuM5ift9jxaqkzyJDVda5uu1V07UzdVXmyoM/E
         NmVIm8DecRlzdVvie+5CEbOH1OWyOhatjI0fN0fwMBmXgbXnR73lXKn/ndQaXQ+JgHj+
         2xLA==
X-Forwarded-Encrypted: i=1; AHgh+Rrz0IfC7EGICeOjU+fh99U+jGJCivYhkluqGRecDR2LH3+WiND9workaJpQ4s4utiCaU/6jM7tUbg==@vger.kernel.org
X-Gm-Message-State: AFuF++kQsw8MjfMFCesTBd8C+zjMuRgFKyiv3F40p7Q4UF4lvqVuprtm
	7ZedePYw3yqm+tmMwjeeJgqRgt0TCePFYpbewutpg8olfWDx+IsQRyoLpHklQGpMpnSzANikFSE
	7ckLKBbFQXUCnvdz9f9/rKsRwhV/BOiwwVuVjt6VuqxHJpSq0rLbKcqr/zotg3w==
X-Gm-Gg: AR+sD110fJ0HHqqGqyK5w4uPl6KxT/pktzzgmsb9HRcTXTvz78Md19XbOQHuTwMLwC0
	EwF2OOTP+yGebPcT57gQ+kNmbbGkLrtF0b+vp9ZS4/NkKHV0Pxes5V8Cfqr5lMQlASlf3ppm3MT
	ki+KYhFi6wyMBhGpXa53k5DW8G62ECtOTrCyiiVlGR7XcgedLYPvZsfQj8iLy3mkzCAbZ+CEKXs
	n4mcvNvaPt3Mzn+ddPZXOF4qZhQjgWPW5vZfZsTEut4YFA88dtpTEwaLZQh+mEc9x0KCSUE501p
	vGD7R3Y+Ti6cr4WWvgpNC9p9tZSHZ/LWQdRgAnrp7bXXrRRWexLVsk6qUX5JnRAPx/fRJmB6lmq
	vdzaYVDILXX3TpjSQMPkVasfwzrg7rRA=
X-Received: by 2002:a17:902:ec82:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d74df293c5mr3946465ad.13.1787849847096;
        Thu, 27 Aug 2026 09:57:27 -0700 (PDT)
X-Received: by 2002:a17:902:ec82:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d74df293c5mr3945595ad.13.1787849846596;
        Thu, 27 Aug 2026 09:57:26 -0700 (PDT)
Received: from [192.168.1.6] ([122.171.23.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704986619sm20011025ad.24.2026.08.27.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 09:57:25 -0700 (PDT)
Message-ID: <15ba1e13-d4e8-4467-96a0-8a4250c8b74d@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:27:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
 <20260821-kuno-soc-support-v3-10-196e2b306368@oss.qualcomm.com>
 <20260827-tiger-of-sublime-flowers-eb8f90@quoll>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <20260827-tiger-of-sublime-flowers-eb8f90@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ytLmi61X4XNyVLVGIf1NiCVaLYuBD-nU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MyBTYWx0ZWRfXyyZu8ppkWbZb
 s0iKGISA8GvF/xceHlnpXQ8kxzymy+VkmWwCMRkxSUJ0tQPmeMm258sGCctyA9YFDeBAKjbqcRn
 1wiapVZHxpqBibLSvwu4tQOF/Mg731o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MyBTYWx0ZWRfX452AhVpCVqil
 yQK0x0HB0EA34p8ZWVt+7GaZCgxoLoxyFOLaPWR4wgCVGVWNSAfWfcODfOWf0budAFd0lVROjbW
 c8EC89yVFb/p7twFTd7xJA6yh6JElJsHhyR/im96SCfMaUSqx81HjT2cfKuAOwErNBlw1EDhkFx
 Xt5+6QBzJp1m/11Uq9BH0CfgM4Wtenm+U4+tg/ssUkUay7yUB2+wiU5M63m5eGZPbxFaqWMxSfO
 3Xa3Y9qy7Cj0szuQmR9kF6L70tzQi1BffJcEVIcRtjT5bPt3iSdnHNWKL46cww4KRDX5+lIIFOO
 zmksW5lUIIMIDDcMbcNMxdWjRmM8+/LfgQqR0pAYFaTT/kLij2iV60YEyfm0x2FMuAIC57b6rMG
 2jf92SGguL91QFVdBWu7XVk9UZtD9iupcfs7TwliCKvjwFqAqgzO/qX6nZUQl/BeA1nqtIfJP83
 fMkIAvcuKH4ihs2epAw==
X-Proofpoint-ORIG-GUID: ytLmi61X4XNyVLVGIf1NiCVaLYuBD-nU
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a906c78 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=WTDSa4fX56zQulHxy5BIwg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KvNN2iZ-vB3k0q2gmRwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270143


On 8/27/2026 5:52 PM, Krzysztof Kozlowski wrote:
> On Fri, Aug 21, 2026 at 09:39:03PM +0530, Hardeep Sharma wrote:
>> Document the Global Clock Controller (GCC) binding and associated
>> clock/reset IDs for the Qualcomm Kuno SoC.
>>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> Sashiko comment was not answered and looks reasonable, dropping from Patchwork.
>
> Best regards,
> Krzysztof

Apologies!! for missing the on-list reply. The Sashiko comment is reasonable
and is addressed in v4: the header now defines the GDSC IDs
(GCC_EMAC0_GDSC, GCC_PCIE_GDSC, GCC_USB20_GDSC) and the clock driver

registers the three GDSCs (gcc_emac0_gdsc, 
gcc_pcie_gdsc,gcc_usb20_gdsc), so #power-domain-cells has real backing 
providers.

v4 : 
https://lore.kernel.org/all/20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com/

Best Wishes

Hardeep Sharma

