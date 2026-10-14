Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC17404BC8
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958546; cv=none; b=kEIx1YseOQ6hU5Um88ahgl9wIbMWNg7xUbnfOU08UKnDXRhJX/5U23zceqZWmdrza1dpt3KyZi8iZ05hWnAIpfk8frlY4Jb0ZpM31MfIW0fI3Fg/Of5oYdBmJeDGOEmlXx5VDTtQb/TAMrRCjyQ8iNw1Ljt8WiuNOciBBvUENaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958546; c=relaxed/simple;
	bh=MAVOekCHS5n6Q2kXcuSC3PNN37t1MTSzZ9hGE5LmGc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivSqgvXmt4k1uHmY94GO+ZlpBSPkQ1esulcC4OAmBtXbLgE6Y5rjO9Aj6nbbwnY0sgH+ZGHOcsWJrBD/2pJQAomc2x00HQU1lSjJ5XCnPlYL9XxHuff/vvkZVczv7bJwWB4VYx/x7R2r6iS8Aoa8p72qL+UmPh+yvpUrc2dA7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePdjSEtp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ano4nqxG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePdjSEtp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ano4nqxG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DNCq512088180
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H8meCWJ8H7If11rY8aq323lYK+Pky/xe8poRUEzVL7Y=; b=ePdjSEtpeDFOBSGt
	1k6xOZCDit0L8b4B+FKCXcKCtSxaXGy4dp6tLpnFsabPNDG3wGM8pOFmPwKyEnuG
	ZxKfkJ4g48XZYrdxOinUdnm67KsmSGO/fDXNmNUwb0EfV2aUtwSOsMCrIL8Vb4kk
	46AgGaQxIcCUNgf+N8+8Q8Us1SlBB0i6+nidNk20qUyQyLwtU3cse2dpSfgcOkmJ
	5b6W2mcM/9OWlwcvmAbEzJfb6MBV+gShx/u3FDWwwV5SZMud8u5xRimy/zUHSDN7
	jODv2pvFDzdAY3kl1IhJf9j6EafY7QsGCfrfJCbj7qkXKKuZXv4yQ1g5hT593MJk
	oejGYg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49hab3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:15:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so2009013eec.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791958543; x=1792563343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8meCWJ8H7If11rY8aq323lYK+Pky/xe8poRUEzVL7Y=;
        b=Ano4nqxGyAtilPZx4YQqZ3qMnb25zGFOlgXzZungOiUtE9rHfQ6XcIDpE69qk+Zxb4
         R5AMy+4ug6yi9raiaz2yRHeyqTpVTjyyluCIZJaTpJSaRAYtq8qe7ub8W+YrZDjegb5S
         +UykG0f+8dTxZOUmtB93BetHgL2YcYOdwPHPmiAwxProF30fS/VuqhKvSr6RBJMy27ak
         d+JKjbbcurJ6oyT1cHjiJSvu9niV+PoMn0CLmrNS5cN/DJ+RvyJVePykvVEfkxh0/e4K
         r3yk8oUWZ1Hh2x/lD3mDTpYOaeLt6CaRLZhwj4x201C+sSsXks8wa01PtLYf/hmE3+r+
         eOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958543; x=1792563343;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8meCWJ8H7If11rY8aq323lYK+Pky/xe8poRUEzVL7Y=;
        b=wAHXJa/0qgQm2n5i1WFaBSqW8QAHvjtcls1Dz+7FV4+Z0pcDh6FG1ROwL/97zXh6ym
         3PiqpBjfCQgeQR4fqs12K4za5ITR6IT6Ix/d/VrPz34Jl6oG+n10+A8bXIzKKt1gT4TO
         M1WeUGvXXUG9SvpKIGFukDv0LM4M6mICwT1BEGl0u1khD/Ib6tuPGnPo5mQSBrNpze0n
         o1cJx1RJ2Blwrbz/tWfoh3NMNtOPkFteSURNmkX9G6BGmy18ZAt9YZB6hmg3dAU2SiRw
         qF/0nj8hZ7ySFUccFRz/9QGZSgmcsb1RwHyvQZ5gtDj3M0O1OMTWJncr8xNjWObgDpnm
         hURg==
X-Forwarded-Encrypted: i=1; AKwUvBxQefJNDSpaksmPmsbcSfWZd04TULNTcWNcF+PciD43DjdNUMwEsl1BkYq6IBnt11i1752s9vX9dQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIrSuONM+W0nYoIj1W/SCP7Ot9N7HUI6cfP8vBme5EGnPSdaGR
	EL9DvU55DdthoTFj1+PCUjX+41RTKC/Bbca9FHqK61z1waK8gLLlgNaT6FUPDLx0UQP7d4AGMYw
	JXv6pEB5glOCFoRkN57fuk5b0bGmHozmPZj20nuvB3hyWc2imWdn00gYeIVWDaJ8+MVw7PQ==
X-Gm-Gg: AYBFou3CT2NBsO2yzPlMkfxPrbbpc+jsSgv963Dneo9U4j7hZ8yPKRBsrY0Y8eE5Ir9
	zhRejqVONbzNV0DFhWXmXJB4DxFexzrGx5GrbK5aQhcWi4ZDj00+WFvaojr1jao7keyESINdUKg
	U6SXY6d1Ll/X2Uje7d3yzgSVLhwe1mKqiloUCWwJOujZwOnMdPXX20s1Onw6USAsrJonFs5v6kp
	n6TJ/PyXt1v9MqRXBmHlZneIukx1DI+4l4i3yGbLlrTLWU0o82nOzVV2uAyDRtepIbIxw8/UJmp
	FPFqx7ZL1squbQmD6CioNLv/8vHQJMdshEQqfsBt7IwzFjw+yPsWMiLl6wV2dKm8zgqd3mrYkJj
	z+hb1C+WQ7pzFZ1N/vvEg9UJyHcg=
X-Received: by 2002:a05:701b:260c:b0:144:f85a:a188 with SMTP id a92af1059eb24-16a56ab4575mr18163592c88.2.1791958542761;
        Tue, 13 Oct 2026 23:15:42 -0700 (PDT)
X-Received: by 2002:a05:701b:260c:b0:144:f85a:a188 with SMTP id a92af1059eb24-16a56ab4575mr18163555c88.2.1791958542148;
        Tue, 13 Oct 2026 23:15:42 -0700 (PDT)
Received: from [192.168.29.80] ([49.36.81.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm51565161c88.12.2026.10.13.23.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 23:15:41 -0700 (PDT)
Message-ID: <406a393d-56ec-4143-bdea-2d46c5a4d1bb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:45:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-evk: Add suspend-only power
 collapse state
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-3-3c402c66f388@oss.qualcomm.com>
 <0afbd549-3e9c-4b06-928d-34b2912754be@oss.qualcomm.com>
Content-Language: en-US
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
In-Reply-To: <0afbd549-3e9c-4b06-928d-34b2912754be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf1e0f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=84Ru73zTo6JNcb5XwS6KEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AO_i1zjuEiQEncmG7N4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAyNCBTYWx0ZWRfXxMwQDcAC+pk6
 HsMgEbOgwmB3maHHLypZzyRa0swx9pgtpfSxHFw5gXpx1wUsfYEnVbXAZhK0Ars4VHX5cpJRMmV
 p7UAw7lLrtvVOkshJdxxgvT1QZGm0M9yJVTJWKBhL9/gE8ZT7PcO8WN3gk3dTL4bAKRmteVI1BK
 VtSXEP+9fj3WVzTGQ55HxHnNGnsw3jEBkJf1BSD9KPoCYtPkCJk6js6Ey1XkMsa4So2UoqYSA0Q
 WpkBV1XuvI3p5Lorm0SaWSBODthe9CZnzPkooohPCmB+NbPg2zfC/QILIWzq4PRFYyUkR9aNqf+
 EwNMVg86Z15+XoH8vPpXl2dXnLm8uKiJxE9INHe7LMUmgkLUbVKcEhtiHKmIoXCnhqsePP2amvu
 jdV5LRy7qb5TwM79DB2CegQM+2/948yzUqdX2Dn1jXrMQdlsM9LiJ0NqHC2OGlsp+Llrqr8azF+
 jQV2rd3sH+RpJhfnDAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAyNCBTYWx0ZWRfX71RFjLjqdu54
 mgx+X70IzNLOxWenQoAqsZa1L77JQ39nbuVDycFEJ+hOtqIWZ8gnCuwx4HaJLHVfvzG7w+6PzcF
 drDUjOGP4bY+m4A4HrpYsY4hapQ4Adc=
X-Proofpoint-GUID: sKGuc1YBr4ABCrxfgofvm5U26qRhq2lE
X-Proofpoint-ORIG-GUID: sKGuc1YBr4ABCrxfgofvm5U26qRhq2lE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140024



On 13-10-2026 14:38, Konrad Dybcio wrote:
> On 10/5/26 5:29 PM, Maulik Shah wrote:
>> To achieve SoC low power mode like chip rail power collapse (CxPC),
>> the Monaco EVK board with four PMICs requires coordinated power-down of
>> CPUSS and the Safety Island (SAIL) subsystem. This deepest system power
>> collapse state is reserved for system-wide suspend (s2idle).
>>
>> Add the system_suspend domain idle state, mark it with system-state,
>> and reference it from the system power domain.
>>
>> Assisted-by: Codex:GPT-6
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
>> index 539c9c80a808..b2978be6823d 100644
>> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> Why is this board-specific?
The deepest state is only supported on the Monaco EVK board with four PMICs. The monaco-ac-evk.dts is with two PMICs and do not support the power down of SAIL.
>
>> @@ -80,6 +80,19 @@ m2_e_uart_ep: endpoint@0 {
>>  		};
>>  	};
>>  
>> +	cpus {
>> +		domain-idle-states {
>> +			system_suspend: domain-suspend {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x4200C344>;
> Please keep the hex numbers lowercase
Ack, will update in v2.

Thanks,
Maulik
