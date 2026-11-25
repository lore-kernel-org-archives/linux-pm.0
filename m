Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595162;
	b=EaLmzXXOwo6SYGBGTCZbJ9p/smxkHszXp2mdLadivJEQasKstG67OGc/QdgU5HMNBLxu
	 IQJ4yWzatS0oCHC6CXSHS0U9VEFq7OIQHPR6+oFgSKjdcDhOEWJTG+k/OyDh895fmZ7cJ
	 axKVcRA+a6JNtynbU/R6sRw6Yb6CiuwTXWhfDh68To9dc9mcj8yIMJGClgLWre0pA6+rD
	 rwRPPm761MaFd8EAjAri7Yljhmodh/CF1egZ2qRdY0zVrvHpfX4UL9+lZSKcym/oVVABi
	 3+s6wktui4lmXM2GCy7PSJzn8wBaQtGSmGUbPkKwDNTm8jnZdLXGpf5ZNir18TviH4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595162;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rwcFMLr5QW655ZvTsLTR/1uQu64nkcHyAgjyM237G2U=;
	b=pXfsECGoqTI0tH9f3PKHky9IS8l41xwaDpE5ECu30OfUnKrDnMj9Z5TEKhCk8JClrwRS
	 EbRRVMGa/YO8wJT0WGyqQIIl3EIB9zs5yQqvQNIjgR+6hnM4LBy4Uzlwgx56HbBJ6uu7D
	 60KVhP9hTTU304CjJsG9+x8AYfyldRLJDX9H4YATCAfgFauPVTk3lwchPTdh/wrxkW0mj
	 sohwjZnViNmgm0Xub0tMRc6ZXb49U81CBGzPMuRPeBwwC8g+M54HVaywYPrnsNLnBjQ1a
	 QVsbDJCH6Kh44fd3MKhgVJMFaqp7Vu6KB1FYwnTTzZNzacef/bgq3PlfVkCoHTO4KLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SahxhR5s;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="h/CoT9AM";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F04606A330
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F04606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SahxhR5s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h/CoT9AM
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68k7J3113975
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rwcFMLr5QW655ZvTsLTR/1uQ
	u64nkcHyAgjyM237G2U=; b=SahxhR5sWhJ1LronK3v8daIqArtbv4nSZA+Oifgf
	P0riDj44hPy/MWtNzSjHWgHR9BD68IUQclw6TNOFZh4kjIYnayEaLGrDkqW7uOnL
	ApA5o0233nHPveek+CfmzmpOgRWj5N17ceJsnZyIrOPr7Wqn4ePe8GXtxDlAhH1q
	9nz6mXAXw6N2h1McLikSCJOa5I/S1vi7WMDvSWIASzT89f2rPZhm/+Hi7E0hTqo+
	VFaXVKoq7XEw9rfFrHy1RRwNPW/zhQjPXLLkZ/eTVdw1Qt4EtzYhbXdz8Q/xpCTF
	+DWXpXVHYeDUil5Iet7nntRuLN867J3EVZ6OVYsKc87gEA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnsahkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:26:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso9371511eec.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795595161; x=1796199961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rwcFMLr5QW655ZvTsLTR/1uQu64nkcHyAgjyM237G2U=;
        b=h/CoT9AM2boudlv9zzE2Ou5csCq+6ShNxCIW+U/81H5gVDyjWOqFSOTdnbSRH45GHD
         IrCsrKzOznbfq7Utfgfe5HDMnoWwhadVwkT1qKwbH2LM0axY5ScPaQZicKvx99wuXc5z
         92NvZX+LlFi2yLFBVvDznMCw/oW3tuwBTCyYHsd6GbSYYcyoTQUJxGNRW83E8q99oitC
         a9doU5QVxFadlyKl7gX1AuAP0xLRmEgKj6ZLk6KInYasfq2z9VpbyLsZqWvz1DthQaAz
         F+hssa7mu4doToZQ38YRqTMId/oQkObMp1Ga7yBh2zl+RrnnqBJIpcxOCeWSahIi5vwj
         pn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595161; x=1796199961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwcFMLr5QW655ZvTsLTR/1uQu64nkcHyAgjyM237G2U=;
        b=AwiVJ9TohpqtmdLauLX97Pa6gIY2kOkJsk9D9HhsUDeqyeun32bS2C8yzTK/u3QeBr
         1pnsJdVgtW1UCW3XV11JxSwUaeODflD94oCQIc/LRSQP10MxD1J2YlYBbb4vSJxbbPgl
         1T5yC8IdXLmM5AOK1r5xnDRFmjX03lv6yvhYrCN9BKpoRxoJcrTTDhjWM9fNk4U0/OBd
         sK0kUzC+xhdG8otTIgyBmtmdJ1Jku1j4ae1xPasPV+Wrpcj/zfXOQiNEimxKkxc4R6Ub
         J2FjcuqjFlVnVmPQyLE9uKyiUyA5oyIfcIp0AgBTjO63XW+K/320fS+rUXUfMvn6ye8I
         MEdg==
X-Gm-Message-State: APuU4Z8bKhwPM/bhegiHuYXbk3ZlvV7hLru1xTZk3vwZ1FZ1GIalGB0d
	3ghjIfEVdVuYIcmVBtsYHz9PaRvf0796tCrP3Mmh9xpxAJ86HurzL1v+RsPaZypbAMLVHZx0k6t
	AqZUJcgp/6hgmsKOGp24jWjdcOfQbweWsvR79nMZkeo+sYpmD5fUnTCQCoy9GkA==
X-Gm-Gg: AZFdTZeWUfvuw4NMp/yWBeATnBxeHdKzG2oertfhgo3BDtWpjwd2UwFF0pVP0NNAEUd
	6cp3ttioMzI/GbAvzfdPhZBC34ITDIZKNZJ5RXCYlKbIjrcS9M9qYbqL0kudcfb7buquDk1me6e
	Big63JrTwn0pvThndiMd+f7B4bRH+2qs7dH+3+dGAfZbq+I0Wagh9YNnrKkXny5CcB1jahxhS7X
	H20vDCXwPh87PZSiEg1uaaQOE41CzYSBfN1Msexxe16hr1ju0aCe6qFXYjdXRPruE/atNTGLcXk
	7Y75zzHSMvOBrfVRltwj69tdMXrk/byUzTzpWo2PRDsNw9+ApHwLkDr6mC9eg9LNGjIKVCipbfz
	opZzr47eZD4v85tZH+TlDPEbxib2kvH4CiwsM2sjzPuaueKZblYTCCuxwzNj/7chN72InG+JLJg
	U=
X-Received: by 2002:a05:7300:f68e:b0:36d:4560:dd38 with SMTP id 5a478bee46e88-38571807cecmr16427800eec.37.1795595160528;
        Wed, 25 Nov 2026 00:26:00 -0800 (PST)
X-Received: by 2002:a05:7300:f68e:b0:36d:4560:dd38 with SMTP id 5a478bee46e88-38571807cecmr16427778eec.37.1795595159963;
        Wed, 25 Nov 2026 00:25:59 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm91363975eec.3.2026.11.25.00.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:25:59 -0800 (PST)
Date: Wed, 25 Nov 2026 13:55:53 +0530
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add qcom,pm4125-charger
 binding
Message-ID: <awabke3c2iQdR9lp@hu-raryan-hyd.qualcomm.com>
References: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
 <20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com>
 <179552715903.40664.16651410338735245830.robh@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179552715903.40664.16651410338735245830.robh@kernel.org>
X-Proofpoint-GUID: zPz_29n8eGgiOy_r2IOxFlJFb-xPA5sI
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b069b99 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WLdAmb08tD0yJPlYAzsA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzMyBTYWx0ZWRfX8h6GFxrJDN03
 kP7hw4EbTeqOP1rdzTOI2C5HJaNgtg/EtLgmwRI+YokQAM2H98sHDcd72FlNebTWEz2SEAuG4w6
 VnQUrSg/qZnFRDjX9V1BoayHoC7MLXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzMyBTYWx0ZWRfX6wgxTnfPGEOa
 K3+mfBUIl4NNyJ4TJiuxHczY1cgkh+7Rl2g80OGgmFBAsgdTnowWs2CMSGszns835Q0ln/4NgzT
 pYi+SLs9PO/U5twYtGNhrNAKwW9TQBpdwO3c+gJ/+T0qThyFeErm5Cnf4aWhjC0RxIexLBD2NZ8
 T/s6NCzM1T4AlFRbxvUHtzKYOtiTfGl+iFOIrsH9aJFwzBJJl/8F6Hf3UFsozgP1YAAsy9FdGPe
 stq6erGxXpAfv6iUOwvkS9bxdlw6hV/ceDe3WMxFRQVtHkcYCiQbsdJTRudABBKLW+6cIkShUf8
 PoK5q0uexBLVxS4AUQh3dxMn2ktbn7kCpperNBCdocJamG/pqhzZ/WZoji5Ie8dQ5VdLGG7t93b
 PQeYpaRE2bYMjvS3nCPunnNp6eDt6lBetsUGZfokTnVGc/wcc+KZ8Rxw/CS1SBAXrwdj4avSVhx
 LEjYY7ot6xPUcPviMLw==
X-Proofpoint-ORIG-GUID: zPz_29n8eGgiOy_r2IOxFlJFb-xPA5sI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250033

On Tue, Nov 24, 2026 at 07:35:18AM -0600, Rob Herring (Arm) wrote:
> 
> On Tue, 24 Nov 2026 14:45:44 +0530, Raj Aryan wrote:
> > Add YAML devicetree binding for the Qualcomm SMBLite switch-mode
> > battery charger found on the PM4125 PMIC.
> > 
> > SMBLite is a reduced-feature charger IP sharing a common SPMI
> > interface with the SMB2 family (PMI8998, PM660) but using separate
> > SPMI peripheral bases for CHGR, DCDC, USB, MISC and BATIF blocks.
> > 
> > The binding covers:
> > 
> >   - compatible string: qcom,pm4125-charger
> >   - reg property for the CHGR peripheral base address
> >   - Four interrupts: usb-plugin, bat-ov, wdog-bark and
> >     usbin-icl-change
> >   - Two IIO channels: usbin_v (USB input voltage via ADC5_USB_IN_V_16)
> >     and usbin_i (USB input current via ADC5_USB_IN_I)
> >   - Optional JEITA soft and hard threshold configuration as raw
> >     16-bit ADC comparator values written to BATIF ADC comparator
> >     registers
> >   - Optional monitored-battery phandle for battery parameters such
> >     as float voltage and charge termination current
> > 
> > Signed-off-by: Raj Aryan <raj.aryan@oss.qualcomm.com>
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> >  .../bindings/power/supply/qcom,pm4125-charger.yaml | 109 +++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dts:29.13-28: Warning (reg_format): /example-0/charger@1000:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/power/supply/qcom,pm4125-charger.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20261124-smblite-charger-for-pm4125-v1-1-2132c9f0601f@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

ACK. In V2 I will correct this according to your suggestions.

Thanks & Regards
Raj Aryan
