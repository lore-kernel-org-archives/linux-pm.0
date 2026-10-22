Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678514;
	b=VGWFKL8YmYR6EpFKNsql10WLnvylINlwmKfFMn+P3FkYWyEYAWCB3RQtnRiQ/ZTLBbdN
	 27s2a0edMmqTX9cqfXs8K3tf1lI8wKyv2fzhIb7iaFArSZ0+X5P+KkcDDY1zbTw45X+yS
	 jEMvaveT3N4oS9gCH8gu1T3xoI3UJ43NocPmnC8VxKe1/wHWd+IgZ8x2mNVCHpTqqjnYv
	 I+aK+l//MT2LHPRSJ04ClDTu/k+j5k61nKWimXehTNksdAg4kSiaBJH3sgkkozjAFRh1H
	 vLUVRKyeeR1WtF9eqMeukj/3c/iMqlE2bwesqyqas508rHlSD7LDuSK1FJUGnOBfnag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678514;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Iorya9CJVmbbeV06oongNxWV99dGCu9hixBeNSCACWI=;
	b=WnU57XFTfudwBJWQ0ursRRkkyQIxZCObMN18CTQ8twDxpesb4/+40mtJ+ls8TebAu52X
	 iKj+d/jYhrmX1KOyB/mVw9D6AvIPBDKGjg4k2yYSv+PfaNs7FR/ReOsgbyvk4BeWkDxnl
	 VgAPm25iPaseNusgMXCf2PMA19uxFxtdrLumk5+0sg/s9eZBkYmMLek/aEzdyx6yssvbY
	 vlT61I4WiOM5F3Ls21z0hDK2GvEx42wbSv7QNrZVHMMcUnYMNvOrmsxemLGgRwQxpoGT9
	 P829tpiPffmwa1DWhakiISLBI6LFEUD6sIeq60RGbZYEWDtTg300WPl3KEBWfXBDTPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Be6NBfr9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="NVZCD/mu";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C3606A31D
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 14:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8C3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Be6NBfr9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NVZCD/mu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA04lw1963368
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 13:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iorya9CJVmbbeV06oongNxWV99dGCu9hixBeNSCACWI=; b=Be6NBfr9WxHlkwvF
	6nOUpLIAC3TICYgkTGSPqkQGmc9FrbjdwwbEoeyHY4x0F4/oPnHenlt1Ed9kc2Hu
	jhAiWVqtYm+bO4j5UPJaLOWq8OAL80XWTnv8l0j7n+APsNAuw1Gkh9KD61DwQQN+
	lOQzfqTo3WkpCSZsUjiNGvviNfyK4OYpTTxyAN9bqw4SU3yMczekcce5hfcfyR/3
	+3HeutSj7kN9AKcFVnLGpCtK9O+FkzZxnnw93IbTFBDw6Zpzd4dbv+fdIzqdqsza
	wNQARzANHSc0UN5oOnySx9p1vBNM/MU/XOqmgSq1rDh5xrXo4IsghUysItnogfRS
	szIYNA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93akqcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 13:39:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3477350eec.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792676393; x=1793281193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iorya9CJVmbbeV06oongNxWV99dGCu9hixBeNSCACWI=;
        b=NVZCD/muE0lO60jqUZKKgtOyvNnOmvIHPHMpENRJ9MFesMq5HIM4e7aaNAT5m8FlzB
         i8wMySKrS2V1v+n2mOUtgeUXgG3yEMnnUhoFE+FfHwcoNN0z1jEdATXO9a0S3HrRwiSt
         VEbN1A3V6NoSGJnjw6H4XSL8SqEiddkKq04tOdpFtt5jlUu7eneVaGHxabIGUZJhIdXQ
         VGlIJdqcs1xzOyMXRH+T4oeUF4Kwb7OcvrBUCiimnxiSHCrbohwmAfKc9V7b19lB676b
         ThWpPSYgamnOap4DplpqCj5dU4P6USpYroA1Iw6Douqxuc7WR3xRE46EXop7F4YjyjF0
         VQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676393; x=1793281193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iorya9CJVmbbeV06oongNxWV99dGCu9hixBeNSCACWI=;
        b=Q7sCs6OSyrcZtiQGinl8xlpWCj6GPVDsap+j9u7g5bO451Ge4X6UfoMBvQTUimgzll
         8Q3TF5il5AW+1rd/ai2gnN2iTwuzlaNF1lvRMkbBTUMez2V9t/Os+5ss8JrlAHcW+sJB
         0pQX3MReEA/XYEIcwkNfMStb7DsyfPcD0ECcv4CQZkOw2Va1JSPyLiEFbPiBmIMfujnW
         o5FFYOjDJqGMoZLBFx/y4Dm/fGtojb1wa1zEnwUCrZw8xoxn6wWJeerJiHs+A/gbra41
         D+Htj8MEjZxI+hRW9be3G3oVNzRbTBGC/JHqZW9LOmiiti9PhE84dZJAsS4cGaTFPGZL
         zCPw==
X-Gm-Message-State: AFq9FYJv8Gk4thOqoqh6sA5MdqoRnra2rBf1zN/at9iC+QTEkpOHgWPp
	QkNX2IWOpCBKfFTkxQKWb6e+e9S2tXnSFTUdhhx4aVJQLcZ2Bh0JxvykvJR2swiGOz2KT0ZSdCr
	Jpso3xytLUJd1dQ425cPLqqc/3xDAPEV9lQoIyh7K6+HzrAmpYFMy8DlW9V89GQ==
X-Gm-Gg: AYBFou0AriFvjLXpRbRH5GKwzYrJvyOWo0fNafPEVoJN7AN1g5b9MeH4ZU/8MwiqLAV
	mlY6bFl/mLKV3xQAskRh8pVAAN2U4QrWO13htzaJtakYvvL/Cjfl0IugK4FYXDQLeo/689DaSSt
	ht+ksUjrCS9dwyJllW/+qrpCNtkrk7wSGiWUgIXaGFn6UD1eRgChWB8zd28/a5LZOPzhsaAfbr+
	36MvUgTx2mEEX9A81At9WAsW/SgNbfm7mgXy3NfBDib446LbtMMSzc9gIsg6rne91H9b3vHHtEH
	lCsPoXIAP62Elcf5j3rGBC7VFfpWM+S+zCgk48Si6P51YlzNCFUu43SUd4HOxe+TTiUnrJsI3kw
	ui5gjY7VRfWnDldAWJKWxv1zRQP7xRQ==
X-Received: by 2002:a05:693c:87d3:20b0:369:7c:bfce with SMTP id 5a478bee46e88-369008c220fmr2325122eec.14.1792676392902;
        Thu, 22 Oct 2026 06:39:52 -0700 (PDT)
X-Received: by 2002:a05:693c:87d3:20b0:369:7c:bfce with SMTP id 5a478bee46e88-369008c220fmr2325059eec.14.1792676392215;
        Thu, 22 Oct 2026 06:39:52 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.235.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367416a1fb9sm14556522eec.20.2026.10.22.06.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 06:39:50 -0700 (PDT)
Message-ID: <f83c366e-e3fe-4921-8407-ffa90b7f933f@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 19:09:42 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: kodiak: use thermal hw-bin trips
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
 <20261002-thermal_bin-v1-5-5a29be7e8ec5@oss.qualcomm.com>
 <9800eb77-0188-4b16-a672-adb7ee1a603c@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <9800eb77-0188-4b16-a672-adb7ee1a603c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1NCBTYWx0ZWRfX7MTUFUxfZZKe
 PmFFTiY9yoXwRxfhXLevB0gOH+waBjPTVgNR5/bEeLv6Jk/LsBXmzlVX5jib+vqz96tQ1lEZXA7
 RHXhUS17+PrnjaH7B1NhsbMwbb6Q3YyUHu6tN561ZvBBGMA6V7EU2XG6o4O2b8v25ECl7FgWYDL
 vud8tmga3Q9HHPwRis8b+EOfRxx9k+4BR5p1lnUgyHcNNIhBWmp/Ds6fof9PlHSZP/Sao2S1pwX
 tE40b0KZB1QMUrAyar/WH9/XU+KnpYiuGukyzVpzchQfX9B5PlxsAPCYHq3oWWU2fONc6B+akLN
 R8zgoItxww9GVyWLylTGnY7taJg3kTmAL65mPLOzfB/Pp7nRj0VwDMcJax4Ez1bnVXgDmSxpklu
 Y4ypUJr23hly/0284ESjeuUA9W+sQrn4twenE5JVs062A1VmyzoO5bvhkSI0PXj23LgY6TtVqMu
 FN244U3B94mwmaYrZKA==
X-Proofpoint-GUID: 58JIwGyqopTXgElElUUhCdIlZQl9b5C4
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ada1229 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=8wa5AUNoahJ04lRaSfAPWg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2wNLjvyEnIyB1ESV7yEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 58JIwGyqopTXgElElUUhCdIlZQl9b5C4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1NCBTYWx0ZWRfX9mzursTbm5IO
 TbacfTkSO83/Q+Nwe3jDROMGDrRj55SuW/5ld2V+z2NZRtEgGdn7/wVF8+xzvNBCdDkTOHEdYid
 NVMuytex14L3oLENuAWWYIgsNrin1lw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220054



On 10/22/2026 2:39 PM, Konrad Dybcio wrote:
> On 10/2/26 12:47 PM, Gaurav Kohli wrote:
>> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>>
>> kodiak-based SoCs are binned at manufacturing time, with the bin
>> computed from the jtag-id and feat-id qfprom fuses.  The tsens driver
>> now reads these and feeds the resulting bin to the thermal core, which
>> selects per-bin trip temperatures.
>>
>> Add the jtag-id and feat-id nvmem cells to the tsens nodes and convert
>> the passive mitigation trip points from a fixed 95C to per-bin values
>> (95C for bin 0x1, 105C for bin 0x2) using the new
>> temperature-bin/thermal-hw-bin properties.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
>> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kodiak.dtsi | 56 +++++++++++++++++++++++++++---------
>>   1 file changed, 42 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> index 347815e5983e..f3bb9cd8f393 100644
>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> @@ -1019,6 +1019,16 @@ gpu_speed_bin: gpu-speed-bin@1e9 {
>>   				reg = <0x1e9 0x2>;
>>   				bits = <5 8>;
>>   			};
>> +			jtag_id: jtag-id@180 {
>> +				reg = <0x180 0x4>;
>> +				/* bits = <offset width>: 20 bits at offset 0 */
>> +				bits = <0 20>;
>> +			};
>> +			feat_id: feat-id@180 {
>> +				reg = <0x180 0x4>;
>> +				/* bits = <offset width>: 8 bits at offset 20 */
>> +				bits = <20 8>;
>> +			};
> 
> Couple nits: please keep a \n between each subnode

thanks for review, will fix this in v2.

> 
> 
> [...]
> 
>>   				cpu0_alert1: trip-point1 {
>> -					temperature = <95000>;
>> +					temperature-bin = <95000 105000>;
> 
> Please do <foo>, <bar> instead of <foo bar>

Sure, will update.

> 
> Konrad

