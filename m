Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF93EB102
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326511; cv=none; b=mwU+8fzoajgjeuTmLEXIHiMlKaObRctrbICQe/I7JCcsPsN7GTtm8torMluc3una1y0tsXIKB/0/1P8acb+0oI5oCtDoCivAl0wD6RqJcJo35cBzKfpSboxTPcY38bCXshuJZQS81DHPNuU/gq9W77zjKyoHgKnX0C3W10oZvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326511; c=relaxed/simple;
	bh=mPKd+dOcaM/hRkXKnBke5UZDJ3qEGEfIyRISqg7wB6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6wPwwm08OxYYS6XpX+MNwbuHIIlHwHeyxV7rRTKY4WqZoUspSYDEHqSj49Xs2173bYelqJgYCTGDXvDqxgdg0GPGWkvxjdIAwuL2M+SnxtAN17qocnyYhDlkxyl5qi6trClpC67OgYQTzAM8QU8FKBC693ASiXowRH06uH3j+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gErI7nHo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j2cBb8l8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gErI7nHo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2cBb8l8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641kus3470630
	for <linux-pm@vger.kernel.org>; Mon, 6 Jul 2026 08:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mob80sObnBOQjmZYIt894rRAtWKr1ikClaLVZFEtMLI=; b=gErI7nHoDO647b4z
	r4DSFtCfSOrX8VUQsx5UNXnI1yQMl/ork4gmWNq7JYH+rWCXna3v5WTSdvmIDfiq
	tOWOyEO1jhVgIK2yUaVMkbTj6Sl6artmPe3PPsi04a7s1y9JQ05t5AKvwHd5nyRW
	JpD7NyTS0UlvTpzgf0Z0YXGBJuTi0Fpba1KgtNuv6poQA028vk0rvtdBsYqUBVJJ
	w38cza6GxWVqB9DjPYewvDafo0x58LNzM96Uji4fePH2YmUF8Sgv/lb9iJz2hXwx
	Vob4P6z7MUE6PlwTzxuHnWaY0Pgy+wNhxw76uDg+FpZaH2/Um/OGQLQHJFycZ8Hy
	jlA0ug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txen5e1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:28:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e69a569ffso9054085a.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783326499; x=1783931299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mob80sObnBOQjmZYIt894rRAtWKr1ikClaLVZFEtMLI=;
        b=j2cBb8l8AugnQosH+Mx1y81sODjHSRsB//MofBUWrfchPEAVYLZ5WHlxRc4AS0Y+z8
         8+d6Dcqcjsy6QVXC50Tbfh7iCH+PJbepaNgnwimjLhPToNoPHx/t2WlzuddKhnnW+3KW
         BrCAYe410UQ3YIdGekehxCRvVGZVxUlFdLkWU8qL/NfRBDvXCouWBY11Zzyae3vgSaNZ
         ykBe87MT/tlTko//9qdzgXgOTfKmeZiWade/f3mKQrixe5lShmG/f7E/ixTmzWy2Ddwd
         x42WV+vtonA2AO0X8BCiLgjTN7Tj2xYv9CPPjMVXj7Mvp66t3yKUuQfFFWpFzPaBnHO3
         L+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326499; x=1783931299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mob80sObnBOQjmZYIt894rRAtWKr1ikClaLVZFEtMLI=;
        b=tNrrwqJc06oijNcT0m9PwAoWYqZOUouppPMKK7fwu1eT5f7/8TRj/uvAI24s1qzjmp
         9+zbMo9Shl5v6lp9K+gOgradhT1rykVlwxwGqiWlfppQdw5GlRwU7gsndbNHrIB9oEBR
         NExlhUgUyuuiNE5ywGcI4s8e3+31yb/emiWMts2Xq+uSWlLLMvd03EkKRuPp5Hv9V54h
         dOuJn5tPWA+qD8eEi5wYJP9XSFIn58t8yVaAH5sUmg5ktDvfoN6BpdPxaFibhq8QvX5Y
         8nk6VuDD0N1we3v8IxTeFoBO+y+YMHUmsGKELaifuX1dPZumQpsRLH8X9iqbCG+drZ50
         9mVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqr1H04xdNBUDzPBjAgTGXrZV+cF7JvSe0qv0sppe6s97Qh1EYmc8r9MsM09n167BJHj6x9QDXK4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi6OoTRoClzjg5DtNtU49loBy7JFYFsUPQcz4PVX/nqaJwixPQ
	P8SZZCDWZx2xgHYhSvxJOpwHQznTAcX7htgcKi1q9nhvTJv+cpQMVgc/VcpmRCx9KqpOMxf5fBI
	u0g/zd2rbDoHgvgwWdFOIvlosxvzV2c0mLeXKC4LFztbc8JP47asHvbQTCyhNBQ==
X-Gm-Gg: AfdE7cmGy74LJQMvAa9EEjLImwILK0atLug/alKz57wDK6Z4hOkJ+kXwkgreoXxj1wi
	ypvaHxNn6ZZyIiNzCEDF6TZNBa1KHB/pcxiA0AazMlUA4T6vAK+6ujy2NA4L5R2n7SCQh5xUtdF
	sOkkj6wj6UEeNKX631ygNdgmUaI8RtxyOvyoTcnSldt0T0MdmJuwLhm3yGB3DlD56IO55UE9/ZR
	o+DD4/KXKFkEAWQpXfI4lNEjd7O2Wy5IduHkRcYJIGStEZoeBEnOTiiHHDb5n8PRd6Ry92J367q
	X80UfiQfbQ7fN3Ibv6bTzlXuvnPWbGRLg6FyAAyBVEb+NQRbLOvmTUWgv2i7dpxwmze0aeWeOZU
	0OY/3VzajUYzeedCXQei7x9zu4mQ9SYyZifo=
X-Received: by 2002:a05:620a:2983:b0:92e:5ef1:9072 with SMTP id af79cd13be357-92e99f6b749mr838791085a.2.1783326499601;
        Mon, 06 Jul 2026 01:28:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2983:b0:92e:5ef1:9072 with SMTP id af79cd13be357-92e99f6b749mr838789085a.2.1783326498940;
        Mon, 06 Jul 2026 01:28:18 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm692575666b.9.2026.07.06.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:28:17 -0700 (PDT)
Message-ID: <d67703cb-83e0-4598-88a7-29a69c17a2eb@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
 <7ce4844c-8025-48e5-a1fc-4d1cf9f7917d@oss.qualcomm.com>
 <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX/KhtZ/oMpDn2
 nP7qKFzatD5eBBpZJ1+iVaBYG3FyqsIJn+T6QdDDNfO7Pra+SJlOkXAPpB9L3/lerxZYNo6j5C1
 T3fHdnafXyePNE58TGFHb+9CGPIS4pg=
X-Proofpoint-GUID: vGxslWV-zeIXFP1-yaNsXOBgHoQwuslr
X-Proofpoint-ORIG-GUID: vGxslWV-zeIXFP1-yaNsXOBgHoQwuslr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX10PU2z1w35q2
 hEREwMPom607wd4PiHcZPGgiKbZIPbt54tYI/nUaEiwGky8Zeic7k8G+oPIGwG/ViXH8HeBoKNd
 wD/XxHPDVwiHLN/WOAY/DPCV1JskcQNkfUo4SG4sPQrxe+G+PMkRygMilq8S3tFje1MnkErrBIg
 7atLn3UgHt3niuxDLLrPe7Odlg3qbbCDMUtPh9UA9iuCTYklxCZmh4+7RGq3Og69B0r/JFsr9xt
 5RTI7qz01Jehm1RsbATCJXkKfA0Y0L7nWf/+fUe8D1TzynDP5k5lgBoKtclhPFlfdhMzdBZPPCI
 KTZ5MMhvxdvwU8Ah9oznTDIxALON7Luukad0l3nqWO3DTGrh8IpdxfWEPp0BjkmulE1cipOq0fQ
 LJG4ElqfUQd22tK6IfJQfHgyktG3gV3mUplpBEooYlF+iIWw7Jnirb6LmqBAG3LnjQvf+uWInrr
 BoBd7pMe9FltRBnIhLA==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b6724 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=M7nLEK1OKNC5V3jzK1UA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083

On 7/6/26 7:22 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/3/2026 8:39 PM, Konrad Dybcio wrote:
>> On 7/3/26 2:38 PM, Krishna Chaitanya Chundru wrote:
>>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>>
>>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>>
>>> Override the base iommu-map with the expanded set covering all the
>>> switch's downstream ports (0x1400-0x1408 SID range).
>>>
>>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>>> from the PCIe controller.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>> [...]
>>
>>> +&pcie1 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie1_default_state>;
>> flipped order
>>
>> [...]
>>
>>> +&pcie1port0 {
>> This port should also get the compatible
> for pcie1 it is not required, only for m.2 connector we need the compatible.

It will be required once someone else makes a board where this
PCIe slot is routed

Replying back and forth took more time than fixing the issue

Konrad
