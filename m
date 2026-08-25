Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4438757D
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659978; cv=none; b=td6CVLFlbVSmNQMVbayURXKc4XLW0ih+e8X8c6CtvA/hM7X8LZmpUoi0iRAC6H53sNqqg7e3cCLVSQwWGnBGZv1rOpJqKV/XSsVFDTmifB2C/6LLx5HHM3phc5nHOfy8KNF9JQgJEE/iKBUiDXyGFfapACmhkWc6QOlVhz2hONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659978; c=relaxed/simple;
	bh=Zy/uplELbej2l31ZzUf+KHC+qlsRNpMsRObEQAmlf2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzMbUnrUPDfiXPox54/oqiLj9AlkG/tkDx6ZknftwrQq2/ZpNeDXyEJq5cHYkkyLNamEfw26ksD4r+PXH25WVxa1d9BxHUz+5p0zFM/ZFPHzgICsikv0uyp3F4+qUZ1TgeLjo7q3gik8j0FlQajgsFXFwjKtS37fgI7aevS3LBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=STOUkQyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRrv3QaN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="STOUkQyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRrv3QaN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAut521152810
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GFYBfDMFLN7EfoYr1yKrbGv2vHYSkMdELyDJzYvM8Ig=; b=STOUkQyJC7MwAcPo
	Lbed1T5mcuXzoWZ/nuwaFsLC6jSrjPmBAWI6RJh8b7LtXeUfHOhZRtsXfQxf9Vqp
	KCQNJJ1FKLH9Eq0r4aRYaAjEztgCNCPhurViedD2PdncOZeug+uuCiuBLlw1VUVH
	t1C/yMCkhhJVUPN8CkycbQvVo4tfB7wjqggy2VFEDxKNvB53bsInutWnIykI4G6l
	h+N/Sb+lc1ubOSbSrz7SeulJL61RzM9eRNMaX9i5rMxhcUIafUFJzw73JXVJUWf3
	MJh4L5jgK64xm9wNlWGMNkigYGmk6dmc7dofB1ZwJaPCAMRKzCqMvJeKwIMurqZ1
	BJjszQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93nastn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:12:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so46168505ad.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787659976; x=1788264776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFYBfDMFLN7EfoYr1yKrbGv2vHYSkMdELyDJzYvM8Ig=;
        b=BRrv3QaNeTjSo87ZDwyB5xp2VVjoiWYSLVb9cbx5nFH7E91zKSqMGZYR17cbrBSlVt
         QwVWmUGu+24nxdkXvk5kcHOzwKx+QOHXkdAMmDFWKiE+eeNpE6wehyYxvWMjm9ydNUqW
         c5wo5nv7t/rLLiHHGcy1/CFRRpRIk2PZ9MyI0UNA2YKb2HA1d6T7ZaO7mwL3ZpuW5Iu8
         OC+yUuY8S6WbjKQoKmcERkHJpCYefBem5oQOT/LdbT/w0QtB830ItWnBM67tt2p3G1f2
         wSStJd+DB/nF6/G7xZvcetQ5x/j2wSZVnVYgGOMv0PJ60SvLrOyeHn5QhJGjVl05/xNu
         1nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659976; x=1788264776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFYBfDMFLN7EfoYr1yKrbGv2vHYSkMdELyDJzYvM8Ig=;
        b=XMCIbRXun4fqZO8J+M6FZCX0EqOua2q4Ewyk7czxeJQi3L4tD0TVI7A0HJXfiAoVhd
         dd/oaU7qcoDF/HGeMEY9FX6JcNK7gOCTJcyCbiCXtguxA8f2sVSgb4oFx6GNqb50SALe
         nOBeyzYVvhi0MeHRSIu0ZNIjoP3oK9VuIptWCUVOoORXeFkyuUan0QxkGWB4b5kq/3Rw
         VRl6HoUOz33ll0x5IQ5VJOOWb+8Q0twM/YhUVy7DeUmcUqOUcRWJKWqfyRz1nqf0GiMP
         GX3G1XySi+x778evpQrkLpKT6t/Ul0gupQ3WjDUfqjIu7lfKlIstWC8F3Lw2kaOzTzWb
         AVGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9HZ1Rw6OWE/sc7iBH/BoGRzfyeNzg/wKyNo4CcW5IwE/AjZbdy+qsqfFj3KQm8oLIIGRS1g929g==@vger.kernel.org
X-Gm-Message-State: AFuF++n8s3phaZRxK+zgKnNjtxq3O6apSAXbClis+PgAA0wa9VWe0Io9
	xGwjxDgHwRMW/0ETWYt+cc7zzUazb1XTgY0AdfZq85GDt33tesvCnuRxbYKVmVt6HUlM+U/9VwV
	5rRKI0ZpLm+5ZdfTvCAx5bmQUUj8F5w82vP+ZCwXsdAliuNHTmCfPEMbwgOceZw==
X-Gm-Gg: AR+sD10sC/xTElKoEToihZL+XIICP7VSLZkzhO81QnPpjE9a9miRuDCLRqwoHQq8xcP
	NsrjEWgw+ggQK1QUcIYywoYnZv5A9opkNiwTtMABleHSeiW78jPuDukHI1OdKO4H41xn9aQRE+/
	5biTX0Yag1N5hvdYgG8t2ibyxYe+Yde8bVnTmm27Miklir7juC4tlf2EeBuGyPdC9PaSjcmpu8f
	2D7AWIIfPiy0CabuiGlaEkyX+YXxMk57gyRCZxh6fS/jqdKlSU2QDp2pHfX/+AID879DxBIxBKN
	/Y1/r7urNSuUIRF1dXjA8igImS8vtcRSEfk1OBieTQWcQfeZWNFcgU5fjhtc6SMQxgu0HGpncWm
	2BjcZN/N0ygMiCOqPGxLoQyzpRfxUJjs=
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr652487265ad.6.1787659976002;
        Tue, 25 Aug 2026 05:12:56 -0700 (PDT)
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr652486155ad.6.1787659975506;
        Tue, 25 Aug 2026 05:12:55 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768d9241sm28068785ad.71.2026.08.25.05.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:12:55 -0700 (PDT)
Message-ID: <c9964dab-d396-497d-bb67-5e509fc8a085@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 17:42:47 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
 <b471a134-397a-4f0a-9d79-1777ed067c54@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <b471a134-397a-4f0a-9d79-1777ed067c54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwMyBTYWx0ZWRfXz/JtC/8LdK1C
 f/FwrBHWW+f7pAqkWLGLcjMa0glUmJBv3kkNPaSdXbSw21ADKLhdSon0wPrEXIbG06Our/xFnHf
 E8d4+Ng8HUSyQG73UlBqef/umnSHpq4=
X-Proofpoint-ORIG-GUID: Fizf1FjXRZXXcnJIKSw0TOM9u2rFzMu3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwMyBTYWx0ZWRfXxnJelxrY8uvE
 d1ol02Lag3QzT7zUz7cJv7DmCznHinLKAFhB2Wn3oAlsfOdwaEKGQH4nX3Khcwu6sJgcQi8/GbW
 yr1df/vczkylwDXMWiYWLsO8bNseX8yLOnfCXNGpamTFGB5pUkD6aFISDl7xmNiWoBfTYAAnnnh
 aGIkERAbvCaIZ5mrzUNE1oG3OBi4xh/P6ZrbmtBTdVBF/MVyPPzxYTr/NQVbnm2RpTrw8oBqt6C
 RVG0NteKJhIVXuUHnuDvN80Ww53iafOqnNuJeMWZCnfHTZoKnWpjD+UMTtoVdkGjOGwWaYedIYj
 N+v7rHeQ6XWGJTm39cyaBslpgltspAbCZPfOm7cyzFspVEv0jyU3rsVTNdNN0pPiHbSGROFMuyZ
 VZFcJMrIr0wm7yHrraL8YZZdeaPoAarnVRXI8Zb1WFb9NnyuhrDXOq1Tzr5GwL8xokMdxukW9Ff
 QppprvoIAUwaJaKpcXw==
X-Proofpoint-GUID: Fizf1FjXRZXXcnJIKSw0TOM9u2rFzMu3
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d86c8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KkITgS1P2qNXoWSfFRAA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250103



On 8/24/2026 7:47 PM, Konrad Dybcio wrote:
> On 8/9/26 2:29 PM, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in talos.
> 
> [...]
> 
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&q6_hvx_alert0>;
>> +					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
>> +							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>>   		};
>>   
>>   		mdm-core-thermal {
> 
> Should this sensor also be bound to the rproc?

Thanks for the review, Konrad.

Talos does not have a modem remoteproc device defined in the DTS, looks
like modem support is not present/disable for this target.

> 
> Konrad

