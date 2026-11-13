Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571864;
	b=uid4ylzbpAVBeDpif/uy6tEi96+JcOEW0rgXMqDfLoUhAEbzPprwCEyFYST4WGEYsbVm
	 fqdo/PJYOVpQtW7N5O+PBYm2/p3ZIiTaZYECRtlvZC8QLzSWZD6GOJbIqBNRF+pQytp6i
	 loG4xD+mqxJXmmidv50qYgUGddiO1RC3fIFN0+bU9F5TV2HjrZRY9gY8omDk2ZRlQS3fS
	 833LQtj/R1tNoYgxWX1/40p7ys7RFnj13IKUgKc9Yk15hf7wloCd/2m7QSd6bP++ujpC0
	 zlKA4r71Q7zaFRT1xeM5E3wek3qrPsxnlr6xIzeG1VSwGA7F5X+66Di5V84KAYx1X0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=;
	b=hHdDCspdX8evKFdjuWyrDzFoH+KtwdCorlAQA3YtfhDNLJE0zP99LjA1vEfXu8wCm4FN
	 SeFDNx1caQuDq9Lrd1BaUB6B60K3BeT34lUexjFMYWUecjAK/4XJzRgSyJLIMG9Wv2OZa
	 ya7y2QpTekE3NdRXBVMauYYt7TX7f0/bHCRki72ggY89s8EwAM3l4JoSPBufUZe8N1ZXT
	 j6diO8AM57DW50/ICf1uXSTeX26wGtidKXcjcMy0kIF6kxaj7tas6cxk3e6qWjJRnVwzh
	 1H+TWZEXXq2sCLWra7qLzyMtjGiZLWLPzm9HjNRUuo6VqGkkG+iUYDrYA2X6lFeWKkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEFiQ7Cg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="gmBZxwg/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883EA606A32A
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 883EA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEFiQ7Cg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gmBZxwg/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC1Cj02085573
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=; b=TEFiQ7CgOeSRnQW/
	Se5AoZ7dU6cjjcaKCcUCdHvC6glfYOpUgtIi46FqA8lPXUVJgojFjfTr5Twfu4Mp
	CQbbN6g6pHf3PwdXgHahKEHyyYCJvFy3uK1ZrPlHyfhXCDZPXP7l2zI3/X6YRhr9
	P4cuWfILX/CScAZSIlXC+90djbPnxUYlMfurTNDWM2n9N5nRSr3Zm+vlX3pnFWhZ
	As8+Ov7kfmMtzFJB0joQo73uFu88E+LeiTT/JhxBaznhr2QHYE+waIvCpoMzvaU1
	mUm3VHg+zCXtMTkhyvJzq0nOEheAZ9Jegsrr/fM1r+Ndg83P6CJP2LKdzamirrDX
	+ZsSTg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5r94uj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:11:02 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ecbb3b4696so50965e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794571862; x=1795176662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=;
        b=gmBZxwg/XbqtrqP2oY5LPz0tR+Xlsf3EK8DvNSJ1rLx9AofPyhzm2VQVvXVe4JZBqx
         OxgSJOVwbJ0o5JaQMKSlltQMxvdvq4J/n21qNljvslQMWk621bEdPn8ttOu+Lbe3UH7d
         +3xKZVHZ/L43kTKUZJ2vU/LUqd+LJrcYZ+SxgNovrNfnrwkRs3rK4WZG2ml2tSK5p+iq
         iecQvJEjCJPeJ+s9iggi4m4wOyMTontB8DhfUyM5I9auPFyujfzSGzZEMHi2FujjyKVi
         VR5uXP6/MOfEY/p8Twe3ZB/IMLUoBomk0ofKmSVtF3tp5YjlI/roFhNUgEOHp0CHwICf
         Sd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571862; x=1795176662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NqXXavtqWESRvkrCUGDpDtfe0DY5TPqAKh7ZVcfS7g=;
        b=rfaXP+UBkM/NpgDWd2KGWXxEtxCKxFdwQDJZTQsof28llPoEFC+BOZkpzP+CLLIHJQ
         u+lj3sIxAIJvyLCLVs+lL6P7plt6sQC7U2efmwGbAJTOf+TXE0QflEYi+2X9nNOwumvg
         C+PVCJ/F7nOd9GlZILy+Iwc1/YzKAZM2qCI1TDL2KQsLzQ1/qk04GTHRQ3+oGqPFhvlZ
         J19dSqHJWAG4y4Xh4FOrNXpqnITFKLmS49fU/hyW55k5T3JTM1eFu5wN797UrgZyPgII
         AiUN5H3puL75m0PAgyBwKIQxD821Yelf4f7a54lEvkJeQhLpFTV6cJO2mxpNEfcOzw6w
         9J4A==
X-Forwarded-Encrypted: i=1; AL+hErGgqaJtRSyhu8YXHMpK+1G43wWfNZE86XIZRy58js8MeZTHMAhwIdWe9YILKNRjMkJUdqQsuYMaeQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Nl/75k+M7QPJT9aCzCl10M2vslr5CQyMtlXllrLwQKlCn2EHc
	S6vCt7PJw9nlIDybKdeEq2UazEgZwEPmfujHlR143DQpTglfStzW5g0b4tVrrjDj9oiMvVew6Dv
	moTtbC/vtBvvRbD9nfIIWgNYrDNahSryYQvYU525j779o+q9LVzEFmbjHkFb/Fw==
X-Gm-Gg: AYBFou1CQ2nPUuQJNMXK3PMrPhj+NaYIUwJEkRR3YBJBAQjx2FGwGxIhgVQv5t/edod
	De5Ke1ZiSHeMAPWmcLK8cGsXzKuK86Zb/vcuprghnnzwiiHs1j/kHAcAFOt0pbx8idnmNmrR9rA
	kR06qzUkcvMEbWzno+iE6GWMTyt+MjBs0SuKs0J2HDz8uRxbQXGZM1DMu+Ag8XC9Hz0AuNjS41E
	du8gBaQ1uQzSmmtoFfSXIVw4nfAIeOLI+8O+IUQEaG/ejmQWZjwfzaQ7j341cBh8f1gGpXPLghB
	hgZHxXuM1Kb8cdQ7wz6bNKjzRH24lwiUjoK1Cbya/y2+clfqTFSWhRjtSTpzMaEk1RuWdU0UJZS
	R4YauTH8Py5FQ1lm3lghIJPxvIDO+OTi5NF41My4cYbXh3JeK3PmS4wrR+Aro+KrfUxumGlI=
X-Received: by 2002:a05:6122:6c09:b0:5ec:abdc:bb72 with SMTP id 71dfb90a1353d-5ee346b6663mr738718e0c.2.1794571861692;
        Fri, 13 Nov 2026 04:11:01 -0800 (PST)
X-Received: by 2002:a05:6122:6c09:b0:5ec:abdc:bb72 with SMTP id 71dfb90a1353d-5ee346b6663mr738699e0c.2.1794571861279;
        Fri, 13 Nov 2026 04:11:01 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b56df7sm86814566b.47.2026.11.13.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 04:11:00 -0800 (PST)
Message-ID: <03d75b49-dea4-4736-a662-27ef64682157@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 13:10:53 +0100
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
Subject: Re: [PATCH 17/17] arm64: dts: qcom: Add Samsung Galaxy XR
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Lee Jones <lee@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
 <20261109-halliday-dts-v1-17-289114ab8197@gmail.com>
 <3ddaacfd-59c0-4d87-9b8c-2caa85143393@oss.qualcomm.com>
 <20261109170407.2073295-1-lightofmysoul@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261109170407.2073295-1-lightofmysoul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX2qwenj6bb+X/
 2I4fnMRT/XzjIjGcj1S35Nx/mYfE0htyNR9FW+AQJALAwrjOEbNW88IKcGjcUPhfSoPDsv/sTuA
 h44e5zCtUnaaogq7sLWIIQjI8mWf5iAiFAVZwnUlTQr7FDiN5xJ790PQJWy8h2/cu+U7k8UNOGi
 bGzhCXm0nec4lK+GcPr3jDxMsKlhAl+MXAShFxGVxfBIK7Mw7jYV3PpZBIcSd9YzKniZaqjoNGo
 JR1GemejAObxLhTkL10n5UGm9nXumLDM+f1Y6EZHCf8busJUjLkGkSjDrbGrd6y4YuPdtzpvQUF
 l2S485dB6e+dMd3JY8D16xzj0rQtTyc6FohDuKfGdcRhS17iHf4M9sp8Jpz3txMBd086cqrMoGr
 UFJbtRoksZL+BqJRUrMcEYRg6IEN0lb14XeqD5d8TGRe1zy/ga2pRhkUtrMwWwlCSoKxBNzX1S3
 SB04nEA1HrE21kfuDgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfXy1HP3Qz9GVMT
 aRQo5eWIoNgLVQy3xcpHWROpRtyxqQxyBGKWH5bzawDz1/UvjeKTH4Zdu2i19n/fXMYzpH2kCpd
 J/EaudtZAg5BG1W+DnGBwKg6phEwxrc=
X-Proofpoint-ORIG-GUID: bd2qRxSR9_Xyei8TGCntlv7JCuzz54fH
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af6fe56 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VS6XN_di3_qKZAQ5k78A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: bd2qRxSR9_Xyei8TGCntlv7JCuzz54fH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130048

On 11/9/26 6:04 PM, Stanislav Aleksandrov wrote:
> On 09/11/2026 16:12, Konrad Dybcio wrote:
>> On 11/9/26 1:33 AM, Stanislav Aleksandrov wrote:
>>> +&usb_1 {
>>> +	dr_mode = "peripheral";
>>> +	maximum-speed = "high-speed";
>>> +	qcom,select-utmi-as-pipe-clk;
>>
>> Is there no superspeed / dp altmode in hardware?
> 
> The headset supports USB SuperSpeed and DisplayPort via its USB Type-C
> port, I just haven't brought them up yet. It seems we need a new driver
> for the Type-C controller.

OK, we can do that incrememntally

Konrad
