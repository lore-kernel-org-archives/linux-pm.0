Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1913D0907
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042700; cv=none; b=UGVdL+k7QCRj2b/GUvnGop7HmR0uJ+ZTrS+HVhGcFFSxF0PNfOmLckU8RZnR6bpbcBF0ESdhymr3N/A8L4FhFVlP/0f4XkPn9y7rIs3MZcJpRnItWNaK9bVW4ZUUOmM1PKxAkn+AEYQZiG5cObRZClSavNSEkk5iv5oJ/ifIHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042700; c=relaxed/simple;
	bh=djlkaL8yNHbm1bKws8z7fdDy4teOlPAFCmBAJqwMgG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0Y6+Atx2/XMEiP3Ny0qFS6nYDCMoj+wXVNOX4t243FJQ9ekR17F+5oqL7G02l4Hn7cVi59ydUTG0yIuPF88IDRXH91uUjfEWpqNXBrTVUlh6xkoMiTUjjJfxW+oK4HxzKSbcLLvOr10ahtJiZqMVN7TN/HeUWQePJFJD6oYZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwQTIkR2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCLpdpfa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwQTIkR2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCLpdpfa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHj5C2745476
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 18:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zgbu3G2VLkPkBKrxyAQV+vTmrYMaFpJkZeNb7gwNxCI=; b=iwQTIkR2VXvbdkEk
	3qITKPXvhxLYxnBvZUpGVmVkqymLj8GgS+W82BfcXF1sJdYia75dV/nGb71H9Ood
	C4CtWaktWb828zuvZFkA70eK+/ebS99R+sUoKcCwJQOMiNBNfzbVAHHSk7ywffXi
	jqJEa3dF1yB4L3Ast8D9BrjU6JnMBsTwQbDfc44SWjknfh8Ri7Pvtilb27XCo2nK
	Kng2358V0WBrb9QhsA3bkJSnfqlRHJuI9pG94MuIbd0w9W5uaTUsiJ8Xll+NP1D0
	gfBOmHR9AoSKorEySnWakXQpNLeanSYEetf8MEUBTx5Wk+PT4GGaE9tzA/5w1zPP
	NGgYig==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6s09hm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 18:58:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so4159271a12.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786042695; x=1786647495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zgbu3G2VLkPkBKrxyAQV+vTmrYMaFpJkZeNb7gwNxCI=;
        b=UCLpdpfa0qhA1Iu85a8obO5xLsyVa7muKrazscYPeZnJ15rTqo6mxo01sEdw1KOheQ
         +nCznNcLELVSL/6Js1absNcNt1NLbCj9FdqOYSr5fD0k7s0DRPBWwydzCctJXoK5lvjM
         mX/3BH2gGg7p8SsX5+ZUzVr58KXAAkIOapl4GPhPqWx0OBBu1GHBcd/aVzIGLoZzLRTC
         4DB97IRxR/mZ9o1HG1rb5hMYs6D8YC0N6cF3SRge922GftgdKTlLkicCJdKusYqYjaZn
         qdUpuCZW8n9Zfx2SfxFg0zLlmw/ctnurb99X6taoItbuk9Oc71/4o9vTjrE8IwgCyE1h
         +olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042695; x=1786647495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zgbu3G2VLkPkBKrxyAQV+vTmrYMaFpJkZeNb7gwNxCI=;
        b=d/sCkS6jelmKYA6Qk7UcV7CtGZOD7dQ0H+00ZaMgpXRh++dDbCmA9Zbgc9LJZr7dBz
         t27WfxG71f8pEij9zFXk+erY8y5wdrWs+D+5XAizQSiJTFNEOFhYfQWuyQoFwZLitgZ6
         CTezyunERbtEo0EqOJbD5woFYtGW/4ECZCepZ3rdx7Y8oUpU3PCX3n3I6JKlIvqRBOO2
         F5C9OGSHYtYOT/XYZVqyJD6ChXZLcKxaKPrIYD2NwKGJ5p9bdZuyv+3vpG2cMghUSk1x
         w3V1U5QpYLlYXftne58up3vRrt5RI5ljh/psdUjlBNX+nuYGbihe7G0PMAnWmfxRnR6E
         ejDw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6cyG5bZIGU9KPuYgzmCki1uG2ShhNf9j+K+0+hkT1Hnb9W0KXEOaXdljmgtM5D6QE6uHlwL+04g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVXElX5SOPm6MXd8x1ViiuaSjPdOO4X6Gf/3vfHiCoFAiZZmn
	r37pcfGuEuQS5PbzhKbyHf66jvHAuTp2Nh+qhqLYBQsla502VABMXua/DBGBVgeW5WuT6/SRyi6
	9qB9bUqLlaIH9jzALW0umhur1XUExKnj9PJWss8rxip++jdFHcjakwhSs29b3Ww==
X-Gm-Gg: AR+sD124RveQGInGRbLxR2lp3znSPVp3cWAxSzuoVf/07kN9+BqMOjQfaZAOGCOl8U4
	BCo+g2Px0sF5840FrgFTOOTCrnvGTfD9/O62lMhj36Vhvi2008gGdnIANmmd3tBiPThx9lifSmI
	uuUNDlncPjJIKjH1hdFVQcP5Ipm9HUwtHuWDc/NVcegjtQtQu30qeR2ipyv+soZR71XjVwbTiPc
	WGO8pwEhDOHaKL/mgevCcDksHLDfCe4WvRG52uXXwzTGDWOKgrUHHs8bQB237H2JMVfVnOYRyxW
	tCKtvJnRGLC3mf+Zi2a0QBqQRcv0BUobtz+7cO7GfMYrHMIp68h6uDzZ2qWPOu/3trcAqYtM8+y
	T5FKy2XTiC0KIfhWfnO/yOtIkMiXipA9yLA==
X-Received: by 2002:a05:6a21:6005:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cb85dcc94fmr22487507637.9.1786042694657;
        Thu, 06 Aug 2026 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:6005:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cb85dcc94fmr22487465637.9.1786042694212;
        Thu, 06 Aug 2026 11:58:14 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14100a3bd95sm460596c88.10.2026.08.06.11.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:58:13 -0700 (PDT)
Message-ID: <4d82ed04-81af-451e-982b-48fe001d0863@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 00:28:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 08/14] i3c: master: Support IBI-based wakeup capability
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-9-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806131857.119830-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfXxDv4NMFQhGGZ
 Yn8wIAy36otBiJvf0bvxejUVmaw/T1mkpADR5cNSLlzLI5JgyimSW+5b17XfCsGhaEcuHx4aNqq
 LIb71CR8WYtj7tSsuUr6LoRv04Q3sxw=
X-Proofpoint-ORIG-GUID: 2tqt11JkCln80HQMnhuZBo6o8IrCcxsT
X-Proofpoint-GUID: 2tqt11JkCln80HQMnhuZBo6o8IrCcxsT
X-Authority-Analysis: v=2.4 cv=B+eJFutM c=1 sm=1 tr=0 ts=6a74d948 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QyXUC8HyAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=w8-nw_vHdxPODZekXkgA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfX0jIo8s9hYmjA
 FSvTerw4IkJQ/AVJdBVYVkgicWtPC6KVs+CQyxOzEneXnBS3Sz0fLJ54gh/4EnPMhcEkdQGjKOn
 qIlJ4qcCM1QxSvuWFOTeLx30ueF7xX9wx3fUVStiiouJexxyV3/SVAqUAYq6wsHl7sCD3Mvqw9Z
 z9dEu4oqYr+SdMgaaVyh4z3Z+FZwFqwtHWn4vIJwML4RCgln2XHxsOc6zD2nxdlvYQBHprBZMXk
 AQMcn3973OtrewcIHb7Cn6gZnqhoKK99F8NY+nNqPKlL1eeWMdwmEsH2RF/B8b5DXEIP7CaNbfr
 rCJQPU1p5vmR+LaxPEqZerV+blVag9YrGMKnUR672bFJSpr502WMJntQQ2PDlxrGIWX0HJUMbpH
 bq8EEtqetwBBujykd6m1g4jPwLDMx8tYtNNmtzrtx92JydqVB/6lh/EolF1pK7PrEv/RjQkVlTY
 qpj9mT652KG2QL+xh0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060148



On 8/6/2026 6:48 PM, Adrian Hunter wrote:
> An I3C controller acts as a bus controller for one or more I3C devices.
> If the controller can wake the system in response to an In-Band
> Interrupt (IBI), then any device on that bus that is capable of
> generating IBIs can potentially be used as a wakeup source.
> 
> Add an ibi_wakeup flag to struct i3c_master_controller so controller
> drivers can advertise support for IBI-based wakeup.
> 
> If set, mark IBI-capable I3C devices as wakeup capable when they are
> registered, allowing wakeup management through the standard device
> wakeup framework.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
