Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68F40803F
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820973; cv=none; b=Qe2Twbv1A6GOLILcx6wBrtRDV84Nw4bsAAEd7m2xxTMqhJPoUmALHFh01DvNKMrdSL9ygRwtrd/7FE2sS2RWnpC8L2r0n2OqgH4OIlAa6Hw5ZCwC0LXu7u8I3xYr0GeKs6ir3x1v/m3Q4cDkGjMvlQOICTs/CeKC3qRw2+Dq0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820973; c=relaxed/simple;
	bh=IkrrKblyFRnZ1byHDFmhe+JUsrlUq48bNUMknB/GoBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXaSF4Dx/953nC3t3vxPUszZ3wl+ZimPA6/2r8MCJgMPKP4/O0Z427WyebHoRcjSvJiwd94ErBNoZLIoaUO5G8+2zIy29IkOzXnJQVYtNrEAfSXygQcOqn+0P3HhDTQW5IseVe3zQrKQ9Rq0nDpRY9KbM9jRI+FDOXJ7cBAUVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EuW3R+Zf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FkQp2VH1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EuW3R+Zf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkQp2VH1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n9kw1605917
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ya5+g+B+at0U/7OO6VM6O0RD8/Spck0YHmmMx1X0tUM=; b=EuW3R+Zfx+vg36Is
	LMQL3/vMGSwPVGz7kxuWFew1GvWw4BbllhgInfnELAPhfsxcKZ0KwctnDnSZ6q6q
	kHxP8m2/jN1MlbLz06zT1OeXWTsXymlnAIyTh/GFd/aL3KlsfnvYVyRcXIts7RiH
	RIqH94hGAZt8zaozgb1Qjfn3GwANxQOYD60VxGRWWHCwZz4kqoFA6lt0GjCXdJMY
	kj3xZgJ6dgAmm9u3WiYQIZzXwdDM5DvVkMvW65IdmK36p0UMaiha7yYwBsTCsFKS
	sYE7adtSzzytESvXbVutHxJ0MSdyeu+of+YHc+2nYcQjMjGDVWcXvFVufWxZflb9
	e1DttA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5t7gv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 12:02:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37fd28eaf13so2015361a91.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782820968; x=1783425768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ya5+g+B+at0U/7OO6VM6O0RD8/Spck0YHmmMx1X0tUM=;
        b=FkQp2VH1ajoSsqVleFU6YTbl5dottUE0PY3geUVErP9KxfIng395BCG7jzN/V1avoo
         tvI6i3sQ7uum4rfWycv2EoW2MS5A6lruXfs5dvdcL6O8kdFpzfkoggtSChVcnLPgT9zx
         dOIG3C9Jx3aChfkw3KmIcVdKbWfDbjLolgzl1dMjg7C2roakMSsDsaEUV5wl0OyB3JzX
         qZaH+nfcBh/F8pcqcv+D72jGGh+DTBzD5g+RBFqxyjUm5enhA8GNeRlWfALoeAg9i1g6
         1PZ5tigxOXeeXMd78XIjTjkhg7soMnIgroNP32hJSU8PKXX2RtmZ7rFKUOEs17eZ5f7M
         aB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820968; x=1783425768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya5+g+B+at0U/7OO6VM6O0RD8/Spck0YHmmMx1X0tUM=;
        b=rxuFHSG2sKtUPZuQVHLrmzOLNVt6eg2OIJwaknBZYM4FG0vJZEGRe9Ns2IuZTEvbua
         FLy8Z0RbelFDUOdxuNIElB59/0nfSSzb6lovm4HyKnHM4E3Lm+aoMavGBxyTLQ4XfX4l
         iRT1U9s5fjcQpnaPqS1e6iUQVVKhWihgcfFeoyGjGZijetC8L+J8jxLaX1fPHTJqKkfo
         yYkvvCbLs7l2AaCNThxEIc+fyfhL5vWRZzQ/RDXrlYSEDQefSe2AGWfHrYJOWG3N9xST
         jxi80Iwga6IKwN755THbTVGo2Ha3gPrmTT4M7dPqo97tj/vCL0oj75wTbQSwacVSS6tn
         xmzw==
X-Forwarded-Encrypted: i=1; AHgh+RrLhKSqfF7mS+KcOdVc2Vs3Uvz3MsnjJY3VsEdo6B2/mxz3SUUZcFEXx1byZ2+ryv/PLDQpA0mhxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5s5QUw6Dj1EjSvsvrs+LGSrrUoHsCJ1e7rHEN74Cf+USSJeB
	s3hnnHcNWLG85bsTnZrpDrRPHgrsdpKc7fMYfmqxYtbqrvvolz8aK4Cb5kifG2biF9034dShvYM
	x81P7fVgO8jtQj2Kk11doIuDRWvrL31w04ToWBDAorzJYpJ0gvArq0nf411TI4A==
X-Gm-Gg: AfdE7cl+eBQaruyCdR0V11kJqFsa/3wYn4XKvpM6hzwJx0B5gpSx/8Qa0ZwsBoTZ6kx
	fwEYQfyzFtHvGetYf55qhKeuwhZ8rOmH8q/jmNXC+lzzVSRs//Z8oZhTYpX+U2xh9pEKmT4mfoi
	HWcw4C8K8Nh8lty1SzGa7+GOn4Ni5JCTe/HPN2YrmWPPtFeGMH0+9WAwUHyrviogeFTWodFgjOK
	5HEaaGh28c0lohAXtKHqcIFEO9plGMSU/2IbmwKI6ybqYPaAOYuL27lp2lBsQt4ZicDe2JdWdRN
	BUFvmtZCCINyvIyXcuOrV8sbB1foJk1xw7YUvAYJuZHc49j1WHYk2SL/Q/O+VovnUFIqEwR8Ah7
	ezuPjoq5tv6ticCw59maszpcqeJNBgYGBXqE0Pc0=
X-Received: by 2002:a17:90b:4a10:b0:37f:9cdf:f037 with SMTP id 98e67ed59e1d1-380527a8cf7mr2310642a91.26.1782820968314;
        Tue, 30 Jun 2026 05:02:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4a10:b0:37f:9cdf:f037 with SMTP id 98e67ed59e1d1-380527a8cf7mr2310580a91.26.1782820967833;
        Tue, 30 Jun 2026 05:02:47 -0700 (PDT)
Received: from [10.219.57.117] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052f47a3dsm1635979a91.13.2026.06.30.05.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:02:47 -0700 (PDT)
Message-ID: <c039d004-4f13-4e23-be6b-1eba18fd0251@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 17:32:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
 <021fa1fb-7033-41d9-927a-5322be71768a@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <021fa1fb-7033-41d9-927a-5322be71768a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43b069 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kvEoWwmIO5TvxaCarFoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: RKI0FpcNHgIJz9Iq8UBCtR2-ZWsSw44K
X-Proofpoint-ORIG-GUID: RKI0FpcNHgIJz9Iq8UBCtR2-ZWsSw44K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMSBTYWx0ZWRfX2ZpzFGANmuD2
 7zJUJQUU4tmRPpovc4XHkdflWy9abZhGWUPWuj04x7nhv9JC45VD0exchRh0xsGhqFywWwf8xZW
 sLNdQQfCPqRmRRbfFMnAmY+N5mizYVU3Nj8zvUPrx58UUi2HMdMvIyulpchaL+7uCLtdSPr7rf1
 BFbUqvHcF45adRX+Y09r4cll4ahpLKb96OsSqiuw1E3246wZoLHS0VL2/txh9ynzCBphKrzljMS
 fugV1Kx7NlhGpsVAX1eRKdSlqkBo/tZDLI+LQ72EXyYchlJBb9G6R/3dsGvG/7k5l/FDXrBZ5Yo
 35itknTbgb+ZSvVbVJ9ctFQxnhk5qkB2+vntAa23+xjekbuuKb2Z1GQB2FFDyEGnh0y96TAxdQ0
 ++cDPk4L0WRbtL+G3Zk0BIFYIUDGxS0I3lEAUCuQaj/lY22lu1LOmbb52w8X+1JvL5FrwGlazJe
 Y28MsY1ZGdPsUpYyC7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMSBTYWx0ZWRfX7AY+nzd4No+X
 CjLpRvQkYQ/IUy/UL7a1piWdjylpi5mdTo8seLJqTJItOuk8wzQx8jAeNPuqtANp6tCkOKh39KN
 T+VCxJGK2ZCQsW5cyltUoz7Q79QmPRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300111

On 6/29/2026 8:09 PM, Konrad Dybcio wrote:
> On 6/8/26 3:10 PM, Komal Bajaj wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
>> IQS EVK board.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
> [...]
>
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
> I think cqm-evk etc. could make more sense but I guess this
> is already shipped, so might as well

Yes, it's already shipped, so we'd prefer to keep it as-is.

Thanks
Komal

>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

