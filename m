Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DC274650
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165562; cv=none; b=lq2atKqujAh5yg5+89luVieg7vgUzmHaxe1fyuupqw9bhlXIxcOPWkVZ+3lxvQTw1cf934Mm+j5npeNHJWMqLxADOzBJT2lOHBtIsEKFNS0B1jQ3bKPVkQJknvS/yBol45571yrQu9HCLS2JWDupmJSftONGkdRs21AKFPm8poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165562; c=relaxed/simple;
	bh=osMTHnsGznPzOgq2+7JWanAZThHaeW5dVV+gMpQPPZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBQuVmdVm/kQLJaqdoSCLn/IVVPIbY1cRfQUvsLi2JE954CH6mV5XCuYj3UNmnBNWUfgpWEgrCZEEwYwTXjLn3NgCZSL0z6/8JUjX2YWDSZipmnvM8o8SEcqd8kH8BP/qd/dtee1vmd47itbP1ordD+MXC+b26YesR7SRUThYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQJqCtDf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3T5ZOOy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQJqCtDf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3T5ZOOy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlcmG4115117
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5/Vl312DYfGSYqw8ngN0+bZHTiDTUX1IHF60jNSBHv4=; b=lQJqCtDfjuuRIyX2
	VpgPFvxqytfvdwDrvWe1EvCGXqfNsxrDxkY8CZugU21HFzNYlNcjWdy5bjkn7y3v
	2gFPOf03dECQcn5QWvcKsqfgev8tw4SyZaWu6hYE1BlYackOlQEXINvh4uM9calP
	lB1PneLByRW1oqsbObgdR0pYepoYXZ1PcwHCLasO9NFZ5MmgUyDt3Bs7hRVTl0ph
	lp6mMXWL0rxdnE/84UDijUeS69JhOEbIvw75KrjaQtPgygRvyDrEHY6uAN3+FyA3
	NKBWL3Q+Nbhqx1midMrZi0MI+F67FPMs+9+1hPGw6PR8lHmAY2CyVjzQE13NfT4i
	oSPiRA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrse94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:19:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8e934385db1so44542716d6.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785165559; x=1785770359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/Vl312DYfGSYqw8ngN0+bZHTiDTUX1IHF60jNSBHv4=;
        b=J3T5ZOOySOHUOxNMx//9PPB/u6CSfqNYA3ETKYE/srcuEbF+LCV1YEhxgU51Ujelo7
         JMfQqBGP5PEmEIF0sfy7vrzzi9CEL+pzmLnrdmDLgSbKsnGYO+CTPCQtA7JujVBhDP+P
         Ys4lnOSAv+rwtwOHajorCt6QeIKhSYRjKYlrpoVcwmJS+IByzsOz5KGGfJFKt4A1oWU5
         9OQZ01AOV8omRaH1auGVGHEQD/xjSfS22hSW24dVOgDru8IKEEYeTdMLDcPoR6Od9yGM
         BFb/HP8NZcmFfgDGCuuEaam9BTKLz9sPmuu8neSMi5DSrNS893VBb8/cHK1rG0RIAjLo
         FYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785165559; x=1785770359;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/Vl312DYfGSYqw8ngN0+bZHTiDTUX1IHF60jNSBHv4=;
        b=pyvaaHjq6KvVYq2nFngXdX9ko/1ilopf+xVMbZTHqU/c1QNxN2UPmub12Yzub68W/l
         PTHDC7OxOMhdmJRquaWxTNgCeeCRHKprQJc+5KBf8arNTN2y0BH53yphCRaQtW1Vj3NY
         l6P3tNaxxa+jgQKgu4JqrzMIt4Zc4ELV4nBlQWPUI+tjOEJsOuODXRIaaUeCatuGDzm0
         GVoFcKsunL8g3Wg1nJ+m48vCi9MldjNqD7KaATIDxIBdiiAnAVXGYkxrsQS8L/bD3By8
         mcOcRdEBZHhth8QG5hySkxVCO2bn583rhN/KtUf5sbVnveu2+PB79KJtYHnmDZNn5PnW
         Dj/A==
X-Forwarded-Encrypted: i=1; AHgh+RpCPjXLLNeXFmjC+RsiS5w+0yGkU9P8EOlqsk0xBG1tr430cwuP13i3oBOnDmyr3vDSG5sOVIXOog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+y5E8QoWJgJ1/aOn6495YkhF/7Jj6bX3IcSrgOZOgGyezUbo
	DG5ijsha1FH9LZwcRo+lxxmgkMOznjvdS4NlP+w3c71QtmxzQEQU/a2DxuByVom9kWvjSQFU768
	2UX/2D0kI83d95JV+lYXIq4Fzg4oKHMkFakxf7rMEySQaQk5sCJs03wL+NbBiTA==
X-Gm-Gg: AR+sD120l6T+0x2I32M0qM4dBHetL/tet8AKFcV7Q4DX9NRw4ovtLBhVQ/LKDOSO33J
	9lLhda/pUcD8c5f+rUul08rRcaFQdxHTyOXII+2YeQNxyG2xBEO/JKKA0iJBAX2GKnHziY3RI34
	11GOzws6xz025CjJA6d+2iXpGzniQyL1BzG6VMEANQ4BR0q7j1CwN/9Ez2OHSxCZ20p21QulTAH
	emB7vK4Wy4Yh7/64NEyZKEOkyNuic47KLzN/zQMLizUxFvm22exy7eWQYF06l07+PWGe1GEWPeB
	X7XBb7HvkqhYDPSu8Kb7/iOUfygjGvvwozNLcczIHCDmb5kL/yls9q/n/X0Rtqp2uZMcFWu3NEI
	1cLAZ6hsXqkMick5g1hxTgYq24iA0DwON9UbxP4Zgw9g8sQ==
X-Received: by 2002:a05:622a:349:b0:51c:7b13:62f8 with SMTP id d75a77b69052e-529cd07102cmr12547771cf.78.1785165559429;
        Mon, 27 Jul 2026 08:19:19 -0700 (PDT)
X-Received: by 2002:a05:622a:349:b0:51c:7b13:62f8 with SMTP id d75a77b69052e-529cd07102cmr12547221cf.78.1785165558959;
        Mon, 27 Jul 2026 08:19:18 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm46610113f8f.10.2026.07.27.08.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:19:18 -0700 (PDT)
Message-ID: <02cd566a-bf10-4d78-bb56-420db140dfc7@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 17:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] thermal: qcom: Add Qualcomm SPMI MBG thermal
 monitor support
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, mfd@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722-spmi-mbg-driver-v3-0-ef73064f2789@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfXzMoJpAet77Lz
 lOlHlvg3IBf7I4npffS2hPAjH5hu/TBT1wupsDPKZuoI3c66MUOybshjX5KVkJMCIWPkVt6L0nh
 2IpgWxTxs4x2/you/RSDyXr6PB8x08Q=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a6776f8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=U97uXkcDBxVafT4DzxoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6JrL862PZI7LFXKlTxWzBHjTK5ZVRT7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX1JVdHztz0vC8
 BgH/cexqRxMJQi70Q6Zj5N6RdjLtC2jIGygeaPVvfP2Ix+VVUdBDuOea2nJH/vx4+eRbwcutpFr
 R7ECAENtpNmdMkaUs7lWvK+hmUCssLxTvx5alXgCxzqDeyI8j+7t6oLNnL2szbyA23SdN3ezaXo
 rMS4OnFipBsKkinIUK9md4hV0JVBSqGNX9c6YkeQ97ABgoknhV5nO+vHNzzdIzrgjqi7OeaDxh6
 QgMDLnJSRXqeeFJQMSs0ron77M4KeI+D8FbMmbNb6NAoeJayi0EFyGu41AVUIS0+0sQcj+DNSR6
 /hMmckozi0ebdyZACkjZMKhB6s+i8p6aNnagwD+Q8J8anUQomHO297+PLlCCyDmDNsCSljN0fUH
 yLRYAYYl805q3RoPkflbHNb2DdPjiGKX9reEdEVb1C8dibURsyWiszMmQdEyMJPX42yQB+0aRt/
 0Wdsqu+el97YokloqQQ==
X-Proofpoint-ORIG-GUID: 6JrL862PZI7LFXKlTxWzBHjTK5ZVRT7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144

On 7/22/26 12:44, Sachin Gupta wrote:
> This series adds support for Qualcomm MBG thermal monitoring.
> 
> Adding support for:
> - DT bindings for the MBG thermal monitor peripheral on PM8775
> - A new Qualcomm SPMI MBG thermal monitor driver under `drivers/thermal/qcom/`
>   
> The driver monitors die temperature alarms, handles the MBG interrupt on
> upper-threshold violation, reads the fault status, and reports events to the
> thermal framework.
>   
> RFC patch:
> https://lore.kernel.org/all/qq3cggafexwpdrv46eqijxfmrdbqusl2vpbuswqmcvshqueaiw@r4mrmap4nwkt/
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> ---
> Changes in v3:
> - Fix Kconfig description and update commit message. [Daniel]
> - Link to v2: https://patch.msgid.link/20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com
> 
> Changes in v2:
> - Fix locking, -ERANGE, enum check, and flag race. [Sashiko AI]
> - Rewrap commit text, rename binding file to match compatible. [Krzysztof]
> - Drop redundant comment, return -ERANGE, fix ISR locking. [Konrad]
> - Link to v1: https://patch.msgid.link/20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com
> 
> ---

Applied, thanks
