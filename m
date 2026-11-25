Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602834;
	b=tM1D37ZiDIKr6boewzLRape1Ru76bXy5TWoFEMmxhc3clX0X2Sho9OtV62y3JTMiODjF
	 cTN4RqYOSsnGDEM5UUVhe5E1wKSCwflSxqliACZjw21cWVupNysdZiXgfv6jzM+l2NYql
	 JVbvSScGkQur3lRHcW9DzWmZiDKkd/31YlTItL5zfWbZZ+eVKABQ+dqK+QJ8l2kDKTx9V
	 WN1HR0GFHexY+yYd1ufLH3mB3mMLv2N9bumfLsbn6VtTbQ0+264lqAsWNC9SblDUNd5h7
	 DHuqRTBJ46YpwN96IbeLDFEzNmytgfV4fWr9A+kZZfXhfFwg+XNxXCJCwRdELfiSd+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602834;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=;
	b=D71FdLIAsUwf9x+CIoFMIZCQq6+1uwneOcJCY/mmoupNGglN1eVYnmq3rSXdwAr9yJfh
	 kLcYB6AWXfSQAmLvUVJj9sBsrS3eXXlTfxzlPjfCAeXvTupNuQgnIMsDPs5dTqCcvVd1v
	 gyttQxCw5ZxCnCOUvGAp7A7Y6BQt6MJdlCb2KiQmz/0lR8petO8yGb68jstil/nQBx7PW
	 F06F+Q2s828m+DdyeZoU6d6YjfhKtA9e7cyzNHh8CRZzyTFghpWIUwVXZ9uwCkDNG+LfO
	 eURjCEZzh8xpuYpJMHfGNfXryuj7VCX8AC4fS6LTxapmpSvUMLvcMkhoUP0eq2URu5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1jkhZIa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RaKf96Gr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC46606A32A
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC46606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1jkhZIa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RaKf96Gr
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mlQA3611470
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=; b=g1jkhZIayrjzYxTj
	uUBCN5a/x+W2VAyWny9Xm7cCzFFqQNiQpJ4CFS6NtKtumxvjuhMrm+y1eiktdRf5
	o2MlhaQAlF813ddB1/efHervQUd/jA9kj+SVq9ZAK5puN9Yp6M/G3pdXzMILDVUC
	MgEPRlyZrMpFP3qV7n0mvkzgAo+NkJFjH+l+ygH18hIGU4kPxS4i13SAwTWBjphk
	KgvWc7W8ofJbN7EboJCKUmJTfrnRrdFZHuRyxK3PNbzvGJOXxjpW+bwt+0yw2bNU
	CvMfNamR9lCjwRYqAp4X46/uVC8JEH28eNIDuwmO5dhRyn6FSRM+AP0mhsq0Q8vY
	IHz4Eg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnsb5k5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 10:33:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d03bfd50aso14248211cf.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602831; x=1796207631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=;
        b=RaKf96GrG6zG88VXlSI/sleEgjHzkgXkHYjLCw/XlKaQJfB0xDKTAiWD97axAeDlgn
         Nsfar/VVWh7/mCzZRp5aFY8u75JBRBX9+uSyDy0bF2VY7WplYRi8kBviGDrKCjgpZmd4
         8RyeK66n6pP7w1Vm7eNDEcGjkcJXeRtWSdrMRIAvAr8yKTwG/7r2uz/CoL0eb5vMYGPl
         ujXLPV02G7VKHdIl5nirZLLPMuaJEirM2rzs6/ScNU7ZibMXaDhtCjLYk4y/Rz+w3exJ
         Jz2JzJPrgaNb/ZhfVnUbfFebKLl7NBKeIMr1qHGc32dShdw5ttQPcG7HwoDkfVe0nwZX
         mdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602831; x=1796207631;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5YTXasqnbB2xHdsrAa2S2NlKmSeJxLC6xnSplAPAUs=;
        b=Nkc6ZQrEZ3uKsjOs5AeQnoIYPB8CNKBB7hB0nHJzbFhhoQ1t30jsPon4QN73YYeCgx
         8tevdV2EhHlmIA9Pj9CSHkTM5e8Uiw+/g2y0ws1yHhEOpnc28elmT3kNjGKn1sjBysKe
         Y8i29Rs1P+C6ukDMUvGXjS1xI+WRPcGUyFBWiQseZ0SU+/qnBqiSLEF+FE63fymWskNR
         3JH68Ej5sTB4/wsB79osIkgg7dhrO1IfhCOVxd0mn+qTvrPnurbd2FcuoKIQSqF7uf09
         EOkcP0TzvPY8np8XFPp2H2RxjU+AOM5pepOuEx8FSRiQKJuxxFb9gdtUjkCn1nyEbmVe
         gpBA==
X-Gm-Message-State: APuU4Z+kq5I7TtxaJjxMHj8D+gtLeSPlIW4/PPu+fjLNqAhwHGHMi8QQ
	2BFdcY+lMWxfWUXtCt+QJ3iSIqgvkk4kL+uy7XiiKb1+bf8e34bA9W+zz6GrCGST2rg+NlHe6N/
	11hubGCTUhnLrz5EBe0CKc855l/N5GRZuT2R6vBpiUge2kHz72zb0rxPbcxIMlA==
X-Gm-Gg: AZFdTZc7wDXN0DJMmzyYm23Zn1Ht7qk/avoeBBWDlyqj/LKcSmkDEZIxCFle5xe7xcM
	4AKiucCBc2bn7yNSxQycz6RU2CTuq4v/4K/wJFwXpFM7paWOOjY29Ad4aDpEqFgX5RDy2oGlcR1
	B9QTS5oi6pw47iko5r1EqkXENkaW5VJp5PE+wwfvrndP8WGxuP6C9oFwodrqFvnjiQZ/65sR41L
	7rod6zHi+u2btmsVulln5WelH/u0kYr4Ov5ncig9wwrSQrqe85h15+QTY3HdagtKwRLTZt5mR4G
	wgAHBaVhfT+oVfPXDgCsxU9tmKE6oPqRv8bHQo5W09YlwBkBwriMq79V5taXDo451DmVG0i1XZ6
	/fn4RUzw3iKlC4YAl2EgMzt7bzp7qh9XK1nONBaS9i/26cQ4mDWTk647an7IV7sjqqv8Cdw8=
X-Received: by 2002:a05:622b:113:20b0:55d:36b1:9291 with SMTP id d75a77b69052e-55d76741cf4mr301145981cf.0.1795602831396;
        Wed, 25 Nov 2026 02:33:51 -0800 (PST)
X-Received: by 2002:a05:622b:113:20b0:55d:36b1:9291 with SMTP id d75a77b69052e-55d76741cf4mr301145681cf.0.1795602830983;
        Wed, 25 Nov 2026 02:33:50 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8ad0sm7990385a12.18.2026.11.25.02.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:33:50 -0800 (PST)
Message-ID: <25ba0a24-85e8-4aa2-a2a0-23c64729fd70@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:33:46 +0100
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
Subject: Re: [PATCH 4/4] arm64: dts: qcom: glymur: Describe the PCIe thermal
 inputs
To: manivannan.sadhasivam@oss.qualcomm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
 <20261125-glymur-thermal-fix-v1-4-b93a9feae156@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-glymur-thermal-fix-v1-4-b93a9feae156@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iqKMUz_PRvNkfKkNyumLo9HDR1HoExrW
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b06b990 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TtJGJgRM3qr-9yLlEbAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX1rRWdVPLcHqp
 dF3++0n7watJErw4kjkzuNBE/32J3Rqt5i8yWI5m81tcodvVOB600M1BoWhUksEkEJsZL6FGBih
 aoxl8TYbo4/Mv/nhNd3INZjZPpZEodg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfX9ekBs8xoskwl
 1Kf4XfWR5kPPwrAMWihKb4JZNfFz8SyP+0Yk/I2W3dDw4F1INBR0HEHFrJIm/heT+qg2U7Cef25
 3D+qACC1jC7Sfd7vAwUSmakKqWawiA/wHUfSCCllJ25FBojV/5HeCNdBnfYZfIex2A3fB475dxO
 2ZvTl7GgxMlbpHH7YINmKZmalHnhHBie5CwVHfc3rlomF19cg/Tgg2J2vn4x0LHGKxhs9iVlJxb
 uUF/pwEVua6XeBJuC6aRTLeXjUt6YSlOZZxU5DUSJI8wNojFKFP1+xlnUc1dSQMJ5nzk4uQ0eGh
 sgqCPZRQdqRfN4CTeBjclykldMguU028r+0mkjnUS8wRiSTv6vevphG4E5vSfrRh+CqMwfhCYbV
 8VeRXbqWUWSa/BglcZTsOfcongzMxsS8KUKMBbCX8V/efdWpfa6oyL2hOLxb5FA1X5iP7/hCjxR
 eaHyESpgBLc/f0JSdFQ==
X-Proofpoint-ORIG-GUID: iqKMUz_PRvNkfKkNyumLo9HDR1HoExrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250041

On 11/25/26 11:17 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Some PCIe PHY instances on Glymur benefit from periodic recalibration to
> compensate for temperature-related drift and maintain stable link
> operation. The controller driver triggers the recalibration with a link
> speed switch once the temperature change on a polled sensor exceeds the
> defined threshold, but for that it needs to know which sensors track the
> PHY temperature and the drift temperature.
> 
> So add a property to identify the relevant temperature sensors,
> 'qcom,pcie-recalibration-thermal-zones', to PCIe domain 5 pointing at the
> aoss-6 zone and to PCIe domain 7 pointing at the nsphmx-0 zone, as those
> are the zones whose sensors track the respective PHY temperature. Both
> zones are allowed a drift temperature of 25 degC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
