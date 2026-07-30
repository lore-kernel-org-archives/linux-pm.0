Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7A3CC314
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397357; cv=none; b=TuFO/Jdfptw9FqZMtIReds7FxQoomEdxA0hkncuW+uD+Fd+QIfXm5zLesfTg3VrlqouCrItcaS2swAtyW5sDm39rQQTkyUjovNxtWhE45bplDm4cMR6RQ4vc3KJsCBf/dUl2CsrQxgJwPAXzB5b8IHC2KKepVQ+cq7gdTklLA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397357; c=relaxed/simple;
	bh=28ZLWM/pIAuHM+vAC8WI2Vv9H2XW6bKXry8d3aIER/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/OlxZ54QEzTYVIIUk7ZAzeMH69F1n6ppK+HNHZHCb/bFX6DxjFevV8QCSfYDFB8/Vp9ImZ7wLIW7KiintWxahTGUAGB1vBopEGB7SI4WpZ6tENU/ELclXGDaenIOT8heiPx+Ipcsb7eu/IYqF7VB/ryAOgL4jYEx00xoy7wx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMpM2Llx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vjb/y4ah; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMpM2Llx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vjb/y4ah"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U7MdV73832192
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 07:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8hNYcnTlO2sEp+wOOaNROgXRLuhpC/AD2RNYMOE4VU=; b=cMpM2Llx/3TaRzEk
	5n/xZ4RN8j/H7gFGCXJEZ8I49KPSnIb++JFW5DNcuJJT2p+ucWozOi4sAAKoVWHQ
	vvFCVdgYc7c7rTa19I3axMmNWGn/xJ7i+DnDiQSPcTWlUNvm8t+dPxHCJGKTsmdi
	5DzJxzl77JdCQrGkiYEI3FtxD/WQBGmBNQ3Rx0idWXJdv3d2I71Rc6gHnYM6JRtm
	xNz9e33mHuNIEISjNAR2JOvJqtfQvDVTU/mnQxywqYtEXyIt+wCv3aClpvcyRQmC
	LSlvFvnGXOAxFJ9bWYN+C9EqG4glFT/Lpu7myP3dcvoU+v86WnA4O8va/01RgL2N
	uxmTpQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr25wg2u4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 07:42:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfa45b280so2944731cf.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785397354; x=1786002154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8hNYcnTlO2sEp+wOOaNROgXRLuhpC/AD2RNYMOE4VU=;
        b=Vjb/y4ahmXKxpafbYC6+1yMAG8hM1+SvYOGsnZdOzARbZLPe/AoM5cSx6wtJYNE8pP
         6B9JgEtprXg8KWCTc8zD+Wj8JCdEypzSRr7S0D7EJHnZy89QzGuCwiFPTCbt32nbp6iq
         VWefYidUvHbG8KTCpFzXr16zeDdmROOiPy6buD8ICx4vzz/evxH8c6G0nr2NtIftM1OP
         MWJ2gRD067bZSFzAaD8AsKSpnrGKB9xj932+RekS4Btaml3fvDFrDVy+L9aGaDm9ayxb
         lh+7nuC9uFbqxsUecwNkk9ldGFJb6naNOOspHsnaDiea0sAlRTtVsJRDy7YtCGPpDRtw
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785397354; x=1786002154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8hNYcnTlO2sEp+wOOaNROgXRLuhpC/AD2RNYMOE4VU=;
        b=ob93ZC5dBUNg7HQwe3IUW+pmwAAJpnNR/kpFdAfXCi7eRoz5qoStEDWFHQyyrX4UV9
         Q7/aWpssfkSZkwV4ARCLWpqzhJsDxXqPYLoslMEwcNGtTp+8vTeTiJBo3liUv0iBoo4o
         E25AS8qKd6IHjnetOI/fR55mITsmSTdJ9a6rGFCW1r85DnqEUTJItYwVcajeSaBdycFQ
         ktiylmx27Ze6TO8Nxn0M7nYB5jGD+r+lwz4EUgcfv+qMYyAf2CUo5sJltB7nh+l8p4qx
         GzujpR/OYEAKJ+yUNuiXds2vbHEO5SN4AyR5DwPvAaP2fZOHt3pesySC9sa2I8M7OoSz
         o18w==
X-Forwarded-Encrypted: i=1; AHgh+RptXdw04opwtzYCHm3F6bp8lN8MWweDPJdBes6LRqca4P19qtQ/EEcORWBE++Cxrf+iykLWyZFtmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs90D3xvTAQkpMGIpgBl2cfp2Iob4WHmaE6tDcjiM+yjv1S+XI
	T5wezSEIoFrsKQz4S/uqurrNDtbwfjaUjTywo12sL7Y4FdkLGjJehS2XaUoPnmZWxpZN1Cg9EnK
	y4kgb/8vWLtt2bRHBYLZ2x1lTmZfPT6fG3Rr3tQEQ0OUr7lb0kdrv4xWObe7R8A==
X-Gm-Gg: AR+sD101emWb4POHgL68R8Fi1cW3hl5aFMbue3I1lFe218Bok34qLfx3wAY3IL5nH5t
	3d+ueRUS3oRafIeJl3d4E/RrXx8OISNKxMRcOVNoqPHwO8ukN3CPq03C/ldMciTLNi/oNNx4zC7
	3ZIwQVpXxYi8S5SGwJvCSCe0LioPu7oxTb62biSvUq3wkr2BzU5qT+081B47fPHPV81MXgOvkOb
	q2i+RSEQBeJsezdOhhU52nh/RXrrkuDip1BFhDgc4vYLUkepNMxUxqqMeKmnVgGs81iXn8VblJN
	p2ionxGyLY4sCO4oPArHwbsYNELUveLxbCa7e/0naiFqm2mEmcpAPn0fR0GhjemJvlAPBofMwk0
	Ys3PDjqyd6jBrku3hdfMZqF+2
X-Received: by 2002:a05:620a:a21a:b0:931:23a:83ca with SMTP id af79cd13be357-93486f06b41mr187325685a.4.1785397353695;
        Thu, 30 Jul 2026 00:42:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a21a:b0:931:23a:83ca with SMTP id af79cd13be357-93486f06b41mr187322385a.4.1785397353313;
        Thu, 30 Jul 2026 00:42:33 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851b322sm34493866b.7.2026.07.30.00.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 00:42:32 -0700 (PDT)
Message-ID: <9a042817-3a3d-4637-8df7-466ffa380403@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 09:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
 <ofkvwrvfpyhjflrmbyi43gd4mltrqdmf3pzdvxwitrqshtttvo@r3xpfq3m42ha>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ofkvwrvfpyhjflrmbyi43gd4mltrqdmf3pzdvxwitrqshtttvo@r3xpfq3m42ha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1NCBTYWx0ZWRfX/4nRBJT2UQKv
 HzhXY1aJPkB1BpuHgZBPVbX34IVxLlVKkNLC6W5e53vkaGV6tH8eRSCYCK9mzVitl/VGTjga5jo
 k0LzFREy2WOtb5y7s/r4hzpJ3G8JEqE=
X-Authority-Analysis: v=2.4 cv=dJmWXuZb c=1 sm=1 tr=0 ts=6a6b006b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=FQzAjSPMhRWCFvqDWQYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: cggP23boESBWnfMqKgzqXk9TuRT1kgGc
X-Proofpoint-GUID: cggP23boESBWnfMqKgzqXk9TuRT1kgGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1NCBTYWx0ZWRfXztIqRk7L0T/z
 yTkkvvIlWeLwYV5OX7AJ/KCp9BtMCG+b18WOd6fqM5L1cOCoxJcAbMCvBefIBehHs3VY5QPjc1f
 h+HXuV3Yod5mptdGL1MDiovs2gogE6KjWsjk0hXnzjM5EFfzDW/LlVI0cnYvatGuhm9xRUSJI7d
 sQjI+qVl9nb7lEB3v/puk37loZpKdH1vUDT0MLMVkIyvzTUPHK45de9YHz8xsaGrnn/QWS4txw/
 cjTjXKILTUa8ubXItbSQECxt2dazzc47DwuPicEa7Jyc8vF5hdBLJ66ZwWC7ZpN2uCquuGvBUre
 EYjbWyYaP1+trpE/mradPka60+87E5WxTT/4RAnK54SRkL/SYu96GbNgChsVhmrvGAINjGm3tOi
 wAORAlMggv9GCbh4p5Rtfgtf8Mad6ywVWnuhOwqfHRIEb6QnQezbl9142Mq02Z3x+22mx6qA3qC
 6T3IOX53yvI/Abd3zfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300054

On 7/30/26 7:25 AM, Manivannan Sadhasivam wrote:
> On Thu, Jul 30, 2026 at 10:18:55AM +0530, Krishna Chaitanya Chundru wrote:
>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>
>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.

[...]

>> +		pcie@3,0 {
>> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x5 0xff>;
>> +
>> +			pcie@0,0 {
>> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
> 
> Sashiko pointed out that you are using bridge specific properties in EP node:
> https://lore.kernel.org/linux-pci/20260730051031.20D8E1F000E9@smtp.kernel.org

Can we harden the bindings here?

Konrad
