Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4442587A
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973096; cv=none; b=gcKs+q9yNXtcY+3v2/l+yK7b+tvITJIUqxaDJku2YaWrL34t4gl698FeDa/OZ+J/ejtr2TKRXzWT7O5BFgyMoCobAn+EH4jJwpgIYGXLM196i1mH5ER0IW4xOjatdHE7ZXcDUDnQijCl4gUfaaFZDwtRbD0KwKGk5oicTqtcKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973096; c=relaxed/simple;
	bh=F1GSXwfyenJO1Pubr31ZUbjndWp9oS4SeHv8I9RZGlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTKYdmm+6md6l5/YL2K6i/Qn+VKALluQQqRsbVVhbeIHx2JeGCcyOPJMjFb9VZVk32Yn2s+kmnJqold5OOQrm+1924rKTEkodyQW1RG+ClhvBMW6+bNv5R+jrC4WqcmEQ3Gyr352CiAPcq8+TvTKJv5z2gPOxFzo0lifXhiLZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iA87aj+Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EA5QAWY0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iA87aj+Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EA5QAWY0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD6IUW2395062
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oTrEpzlfCsrOhTTbV+g8x/HCYMbW2tO/XdIXG1JFb2o=; b=iA87aj+Z9SmKi8be
	luOzuB6NnY9KfUCiUofqNM0EyXl+NG2Tiej+CVCma3IAxAdFwTpVtRxaQJ0c9JF8
	WAQ6SylQLt2BXfX8Z8/avmXtOPgz4WaquOX3tNzvy5yyQ2uj37DsxZip/6TvoiFx
	MgEW7f8sQkPF235TI+A4kG/Fhm5dYEAtfP0ZpP30Y0PKU3OqHOa/u+yK4rnTJOKc
	4tEIMNeykXFVa4tjCGmaT1E/pcbGoMvLsdvFy2OMSeUyFuSq0IJ2aWExG9JiWZsB
	hkXk+l8FOq85mXyGNHAOzsqK/GT0P4sTB+fiAGJ3KoPnyMQN98T6c0UdlSFBw6Px
	dm4TdA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txya0mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 13:24:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52845bd815bso4191511cf.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786973093; x=1787577893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTrEpzlfCsrOhTTbV+g8x/HCYMbW2tO/XdIXG1JFb2o=;
        b=EA5QAWY06Lm9AoVOvuVs0whpSWp8uyPsnHhBsASjPtJakkxDM5/cUrSzCRYyF4Pxpn
         mIwcu2FhZhNA+kqxjKt3gIW/N3U0xkik8aSyTSJjzce6IaWaM7NdhpGMkZokvN/jynTL
         1otbjFkTmE8RnJcRCik06/aefWmOcXvUZXbVQuGWD83vPolBP5cn86x2Bh/JrqVbr3Y4
         wz203xXkeF//WR++4JhL4BaKXmU4+k9C7ODGlVCOzQ4OTt2F5D/ccIa20PoPOFsRLF1d
         3gxweJMLOU0Hql+e8i7T72mXa9hCP+ZMv2MkjDXERToi4nK819ucNrunIp35jJlm7gQH
         sm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973093; x=1787577893;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTrEpzlfCsrOhTTbV+g8x/HCYMbW2tO/XdIXG1JFb2o=;
        b=i+BMbZtmDHz6altZs8we/iCerUCz/9aitj2hwfsxPofOGypcW3kvDRLth6BJtb/b+u
         zahB3gH+mtHg8+Tc8bfZ1pGZnii4TQDAyNZcnGXtrg1Es03ckqgw0zDY0MSDL4X2Zf4z
         3t6f6xhkaM5XeOxNsDddMYWfo8GAH1dqMFa7mlcKoibCjYfYtmEroooeFc3VIqkypwhx
         i6WuW2PsA8xicj2bvF/OVH86Mayba1po6e5ZYEUUnLWDDlzKw3waVPsr+9Djf5A02Bzt
         /CMyYcqJMFxWaV2clD+abtI2+oFQCysr5MaRU+VEnHS74mOK738ad869I3EXEn5X3SOg
         1NAg==
X-Forwarded-Encrypted: i=1; AHgh+RoOLysLYwgJAPO8a4Q7+opnMyCkWg9GWHum+tZgaNaIt//JvrA5fjNe8eokfD3lKxeWv10aqheIdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywcSO/eS0wOuKoVrIvO1LXyQgcnbhhdCR3Hgn+xM20gA15BJuO
	Qu5K7MQzhwGdKGl+cOp8Er7hQxOBKyWBFnKHoyMOlU3goUrxbhaMepYZqcVnASvD0Mv95OsWOL5
	i8R7TtR77agir02GuNXrnI8RK5CepV9kh56P3oJSLBb0/q49mNHXtdcflq/oj4g==
X-Gm-Gg: AR+sD12R/fDD2nrVfZawoFFGl/OY0j0kIh+5jmfVHPjR/iwHaiiOPkUBh5pJZu+O+js
	wiuZtu64wyuS9mT02NzkRigEOa+7+9I25+tKW8rdxn2911HTQM6RdU/4VbYi/9pLlZT2uOS/i/A
	hqwKIr1Fc5RUpbSRoRniSAwSXdWitvNEuaq1QrAFnB11x9JovXT41g9pU/dkM+FgNrMPrkyHCKG
	ySjoMdQA2sJchWZargTN7gFNaE//m5m3pqnyjy2+r4H70l5SDt0UffuFZ949gLz9jAQo6mvaUmB
	MtKyD/DgSpIW/gRDU4EDIlX9Pqu6UtsPnVul4Ms1Kr6xKMBnz9rp8JnrRTBtIorEUcJwmtmSNzG
	C+pKXy1YDfndYR7Yf5SKWRnDH
X-Received: by 2002:a05:622a:1a86:b0:52d:9db2:7924 with SMTP id d75a77b69052e-52d9db28d13mr103954691cf.1.1786973092605;
        Mon, 17 Aug 2026 06:24:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1a86:b0:52d:9db2:7924 with SMTP id d75a77b69052e-52d9db28d13mr103953141cf.1.1786973090323;
        Mon, 17 Aug 2026 06:24:50 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185bc66a7sm26799466b.59.2026.08.17.06.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:24:49 -0700 (PDT)
Message-ID: <b88c7884-f86b-460d-9880-8dbc23798b02@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] pinctrl: qcom: Add Kuno pinctrl driver
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-9-3079794f0f73@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-9-3079794f0f73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwMiBTYWx0ZWRfX2M7Q1Tk8yqZm
 cQ1HfWdtlhMHrQn6poTIXjq3oBhtLW7KeJ9XhwGIg/9a0l7iUgS60mbso4q8ZadJFU3PMg1K+pN
 X5lePre+RQk+O/OWhVUJZrS6mr8Ymvc=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a830ba6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4tAzDn1lkwtfZF03VZIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwMiBTYWx0ZWRfX8m7CqRGdbNvZ
 1HwguqC3ob5Egf78ZfctGvH3efJP3HgsLxPv02q7cFWz+8IvB5auCdDaxt2v1hZpSWoDRj+otBa
 UhbmLZIED5lM9bBYLu5I5l2VffbYrYJcTeEuiy3Wno6w61RMzp64frY7WLmpNvpFs1PzTdKW3qq
 M8Nz2aZo/Jas0yPMaTJvNdUncOo2CsSOuksJ41C4WIAFSZVcqsoLFcP29t4CpkFJfDoLH46OjhS
 sWQiSrpBPUNsj9qgIHe4PiHfQ0f1WL2p4qsw6korRo93vY+eLb3PZijd8pa4+uzNkRN4YFxlRMH
 R9s+wH21ENgiXt2gOMZEC7Sso+UGFWh8ubLx/eJQHGfbpB7iUUVd5eLbBLZWbE2ugd6dDugnp/o
 K23+bSLa/XzhjxtcjlavM0GM70jWsF77DnNNhy1cAvAueErHmJDeLCpk/NUGH4wikH1dGQHK22l
 iragsl3elqxVaa5QoCw==
X-Proofpoint-GUID: Gw0JFV6ezq7hF9rPX0n4kDiFmWmxOVxT
X-Proofpoint-ORIG-GUID: Gw0JFV6ezq7hF9rPX0n4kDiFmWmxOVxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170102

On 8/14/26 9:31 AM, Hardeep Sharma wrote:
> Add the TLMM pinctrl driver for the Qualcomm Kuno platform, supporting
> 110 GPIOs and their pin multiplexing, pin configuration and gpiolib
> interface through the common pinctrl-msm driver.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---

[...]

> +	[65] = PINGROUP(65, qup0_se1, qdss_cti_trig1, qdss_cti_trig1, NA, NA, NA, NA, NA, NA),
> +	[66] = PINGROUP(66, qup0_se1, qdss_cti_trig1, qdss_cti_trig1, NA, NA, NA, NA, NA, NA),

Function3 can't be selected because of repeating names

In qdss_cti_trig1_groups, you have qdss_cti_trig1 specified twice.
Perhaps there was a longer name that got truncated?

Konrad
