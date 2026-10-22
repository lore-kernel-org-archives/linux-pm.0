Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664075;
	b=YNvpJleXPAl8CyIGNsKD4aTTeVsfvmKrAZYtS/TUOa9/X12lBUjDig8K/5Gi6AywNuL4
	 P0OBLZ38KTHetp7t4btj1Ghxg284DF4jSRgXLiJAC6lzoNj+KX0b4K10jptslwjXtaEj1
	 Q9vcaPCBpYZe/woa/vt2Tjh0rI8Arl4eFkbmonUiB+jBT8lGAjlT9y1GT2pbV+ZDTyldc
	 krLOGPpcNQQ4Gtn79nbqsRDEfXfkEGGQP2CcR2E25lk8epgDOhNmh7qSJYMS+ujyTCgc6
	 9pk9YRqHX3xWyztxS2XoChYe/JbjO92v8tHPxO+rHqThEehwP1LGYuafO+wYuWDd97g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HUE0GXS7XZN5IUzugzmvSNJ7RHIYozYf5z1Xco3daL0=;
	b=O/lZuw9VDy19R49WmIBXshBr6bGSMSEC9rrflz4osnKMDC0EZQpbLLMsbeAQ6bcwq1bd
	 5EQvU3Z8nUyXRHjq0yulOHHPTQ0nMrvjhgGO0mcPH/l42uyj2o8gCe1asbkQWeNS8mMMa
	 u9j3aCgr4r2sDcxyoYeJq4lFgtjMwm5PILVUTA5gVO8aZDPBvn5yqZB1HtQCKRChsPDHR
	 IzPWyHHHJYTtcyhBx6ryMXGnEFwvWwC1SjfCs4VbSvtGMLa3F6HhGCFSgOeW9Ypm9E+WE
	 q5dNMxiPxf7a8/nbEQYBgXYqP0sECP2sjEsaT9iXEEayu+3qa6ZuyBICUAMRw1qTGrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3bA9Cc2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XJ5ctBke;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF619606A31D
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF619606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3bA9Cc2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XJ5ctBke
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA04C51963368
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HUE0GXS7XZN5IUzugzmvSNJ7RHIYozYf5z1Xco3daL0=; b=Z3bA9Cc2wmwHfcbQ
	2dXZkTATr0wGHFo6NBXCZxGGDR+EO27hkpzXtAfi2tenSKG7qqXfP0gFmIucLf0h
	MyV0ng3YBN7qFqtcX5HSJkPD4Gkg50I34Zy1kdL2L9x0DFBmYs+7NeWvwptxG3qQ
	yAdqJGbpRKRW/wIKfPUmrzCpsgeCHThUzyZLhf4oUb4ineHgE4IWt4B6Jy0/0G5K
	uhiuMvKSGt6uHG+i3HImzTZd60MTWbpm9kyoBXPRk8XwXLPnnranV9b8SxmAm8C0
	xpbj0Xe+3qsnDXGKJW/8OAkBQKqokJ+TXjOZgDkMuoiNhzS2TdTVNCCAZGG11sW4
	4oSdiw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahxja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:14:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93edac5877bso49977685a.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792664072; x=1793268872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUE0GXS7XZN5IUzugzmvSNJ7RHIYozYf5z1Xco3daL0=;
        b=XJ5ctBkelRdT6ekouP1PD+Pfo0Zhva2e1J98smrdsPgMl8/p57TsV8Bk377mmmG1EA
         roQyqJSRmv0AMoLZ749cksCX5K1vsFtdvCSR2OgB6MT46wjc210mFoRvFeVbePVbNbn0
         nok4g7/bKiqy/IGwkh2yA8f7yOwS8PGlyjHhW1byO26piiQFea/+VSClwbR6dGvaoh38
         PDvrVLftJaeQv/cxKrcCKMYR40UQN5XDWjojh8q/xT7O9OcJtLC2eB9lN/6ZKNYxh0gp
         w9jkJTWfBUSVIPzUXOj3OlTKU6e0U1Ygd0a1JkQ7Q15qzlMz9/X9ciLvVyT7xkZOZB4x
         SEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664072; x=1793268872;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HUE0GXS7XZN5IUzugzmvSNJ7RHIYozYf5z1Xco3daL0=;
        b=c03R+D1Q8KcAKygAyiP7ujVBCFNpaUSQiBbkXm6SlljvkErRfIbIlKp5j//y/pWBeU
         FVOpBaYFpi7A/7tHjgS/iNsOT0QXcJkjxlrDWeCN+LGHCkvnhmWoKuQuBmnFBQKPmHP6
         A+6j2DDabhW3/yNaG+SwHTUFwTO3P7xLt57aVjzNOLJwmNsK0au8tF/hmXlLCTFtDUjx
         nPFlt7EJ27bBwyU0sN/m3PwFyjH7Q3TZPKuKTB3gIW61xqJUV2D6rNab6YJoRPMDRluz
         tS/A1vyPQzGW2Zlyno51TaQfFlxv2T5UCr4PfQi6XFrrnHBI0rc0iGQWayO3+1LXL6u3
         dHow==
X-Forwarded-Encrypted: i=1; AKwUvBz7InEPsih+gSsckWLXApbxv1Aod2o1ufogbrFJ+q5BmO9TnDzKKCNLOxBFhgwDL9Wh5aZ1ZzQaaA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKs8x0QAxxG4UvRpi/bjptycwTGIkKeoZX972ix82ZvDjHfg5r7
	m8RzJb2uE6chh+5AgFs95iEU1n6qHVpSwrLZMWV9kbfc7vA9x1DYtYpxtTHiLa9ZQShL8660YVs
	66fdrahCq65szUkQF8VRqJTBn0JUCI8S0KoMhnN2fEp3F3xJJFFZD7mSsoiXd5w==
X-Gm-Gg: AYBFou2yFmc8jDP+jsldedleioXgd2F9F/7yar2vyrUUFbvJMlt5FYNblBjchtYLzwR
	uPqWJkKhBSDsB1PykyJyCfOkF8AMHsdFuxmNv3lFmpLw4MHaq6ww7r1qRgJjRCTaWtiTHdWdfCB
	MijiE0Bj4cQXVNzz9paMJAPtH5971/WiFmiO4JZLPV/3VdftlByOdL91dHN8pUteW7nGkbPjbzE
	1eTmIuGw3mKjFE1d/fo6I3+IRmzNKMTuZkydZ78JspYeZzboCMkBqZ0HdwagB55359Z3XATobsJ
	gRYRRiHIr70B/ZEdGxCzcg4Uf56s7cjvl/6G7XftW+ni0qMI4uIdUvsuStWemYK6VVsoWrX+Mju
	npB37QL/ZJKMP2xQrksuatA==
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f580066d8mr1137722085a.6.1792664072313;
        Thu, 22 Oct 2026 03:14:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f580066d8mr1137717885a.6.1792664071871;
        Thu, 22 Oct 2026 03:14:31 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a5dd548sm89397066b.65.2026.10.22.03.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:14:30 -0700 (PDT)
Message-ID: <e0becea2-c5a1-46d4-932e-50517311fb96@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:14:17 +0200
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
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: msm8917: Use a shallower cluster
 state to fix unresponsive idle
To: Reza Kurniawan <imkyufie@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-3-9ce2133c5659@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-psci-fix-v3-3-9ce2133c5659@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfX3dIQL8vRrkYp
 5WshbVlFNxH679RTcgJ65RLJkdq2RobsKgvrj1JQ0cMUd0hjiWxeu4Ia4su2GlYKPDotBWdefwq
 5qVjWyWgQ1llblG/I2XhqGYOH7Be9dRPWiEOn9DiWrDAULzyxCoGWphJir3OONFUT13Vsg3kltr
 IloewK1JpK8knkVyMYDwIAdmwdx5DXauB5HFytA/zyVUG1BFz/OGVk+OhHFIfb8AKi5WsbC0TuH
 mbEVclQAdYwiSN32rIYRUerQeyP7+t5FbbG/c8Y9vvz2JkxHfoNzj8vog8ACKT7AhKM1OSw2kaz
 8a6B68cYVpwYYly7ePVYTFT+stV9fKWq8SRpHlNt6xoaGabCa/6UXIKvui0yxWVxMDW9Zraeyjw
 bTrAZulHr5c//bmi+8SpjPEyliYW5oBcf/8V1UoHEUfQz7Gg1Z9xXs6KOwojoUvfools0hrauEZ
 zC94MPQ7pVkPDGBHXOg==
X-Proofpoint-GUID: HJnAuz01SwOEwQYkab3Gms5QrIAsWFRe
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ad9e209 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VTptWAqQFsUFMNnqaZMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: HJnAuz01SwOEwQYkab3Gms5QrIAsWFRe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfXynGnwZ1HLnhZ
 sZxEpDGZWjDUdiVz+uHmiD0+PhU9qWI2xfqYVWPg5s5SkZ+xKjYRsHXErKzUmy9hyE7Q0NMVlv6
 /5lctQ2z/PhoTab9+es90GdL87z31Qg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220040

On 10/22/26 11:41 AM, Reza Kurniawan wrote:
> MSM8917 is a single cluster SoC, so powering down the cluster means
> powering down the whole system. This causes two problems:
> 
> 1. The system becomes unresponsive, even to common interrupts. Waking it
>    requires an interrupt from the MPM (MSM Power Manager) or scheduling
>    the MPM to wake the system later. Linux currently has no way of doing
>    the latter, so the cluster may never resume operation.
> 
> 2. Entering power collapse blanks the screen. When the state is entered
>    and exited repeatedly, this shows up as visible flicker.
> 
> Even if MPM scheduling were implemented, the second problem would remain
> and it wouldn't fix the system being unresponsive at idle.
> 
> Replace the idle state with PSCI mode 4 (dubbed GDHS downstream), which
> is less aggressive and can wake up from conventional interrupt sources.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---


https://lore.kernel.org/lkml/20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com/

and

https://lore.kernel.org/lkml/20261015-b4-shikra_lpm_addition-v2-0-ac7f1a0d5638@oss.qualcomm.com/

are in flight, you may want to integrate/test them locally!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
