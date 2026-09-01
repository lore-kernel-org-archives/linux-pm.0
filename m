Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B88378D72
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264019; cv=none; b=arIvsgsji89zaZtGB9AwL9gF2avdE/sQWXnhidla+XJu49X0il0o+aYRcurQoZlBFbJkaJ7bBbLMZ48/dizyUPtTlT+hWFu9FCDqRriaFz1COdOgu7Ppp7JTLdbo6G1b6GIYH+LInAWyKK0NjOOSLeg2MWKbO8x+GZilRQDRtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264019; c=relaxed/simple;
	bh=QCJewAmYP8pV6ka7p1vMXODbzprkzYwvsfa0YLhRqfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWSUhl403YXmczokR+ggJZum2DKjuBcjrIxBsjYNhsSVuLJh42Erc6Rh4/2GDr+FrhCXgSmwd15dzA67QioY5NbpGxfg+h0uLhQ9OI8aihYXJ02u4aR0E50+7/Kb1vo38omuwyElNmHvB/NyV4tDGtnMqmkdqggGRJvtclpkL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGnJr/Zx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KXYJsRBa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGnJr/Zx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KXYJsRBa"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJPsp2993724
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 12:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iXGlLDwHtFCPNeY7LA/k6nku
	L3mth9v8r6iZQj6mK18=; b=dGnJr/ZxZMEl07qYTJXS3W1m75CsCaLCDOBkh2z1
	neV9pt9HryvhFXz5KjibWJxqtkR/Jt74Cwm7C/cfmfx17r7g8+FtTg75jct8Z1nH
	SALFcItaHveyOSTrWC8cWn1fEVtu00y4TAs6tZMhtKh/qk2Y8hUwtd1iPXeOSr4Z
	Jy7SGMnBNFcsM7JCjDT5+7GMGFa3uHfdZEKjtAt6oqz9C4mxvmMEYGm6yDa/Bcif
	yHKqcuSRK8BWnNeMLq1UvOrqHISBB102AamsC95mSH69VeJKTDfVlB3AvHws69x4
	HFg4Ha7kBUWRCFfhir8NIkX7gTA5U97rUMQsvaLQ7oDlPw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdeg3c8rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 12:00:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90ce9ff466fso73712406d6.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 05:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788264016; x=1788868816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iXGlLDwHtFCPNeY7LA/k6nkuL3mth9v8r6iZQj6mK18=;
        b=KXYJsRBaL4j58HnkcWqmjjn0oc8mDVXBa8Kpow2rZbij7+4fmOz11SfddM3kFhl5pb
         eM/1CgzfnyHSNq9cAWw8apxZf7RZSe6PPEebS8Hukw30eGp/ehGDE0QOdR5PlJGOVwdo
         vR0wvxLtXLSYno2a3nHJAHmitedhoxfMhc8BQxZ3BSrtRwkszoHeTUVaNrUCYS0ujY3s
         IvYmKYpNz9mq7M23dHO7n0yMRfzCJPkgNs/NZKaBQnI5bbeWYquSB84Z27Jl26gdvS84
         tVxHppJmf9mEx/f9LnoTUfpir9mYKHWhLd+UwZsbno8aGrMEKp8slQSqbvEdZ54sv3KZ
         0AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264016; x=1788868816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXGlLDwHtFCPNeY7LA/k6nkuL3mth9v8r6iZQj6mK18=;
        b=Xi2Sy+eCFxwpkjhut/IrOx8q+eKsCMveChP7ytTEScoiiEG1hZfT1AQDjFjDSAbC/1
         UR5pZVqUafHyWrPsMEdnxF0QUu6a7SGbIUISTxPnrCz3Tnc9VunSEnF3SvGin4UVHX7g
         4oBHjMu5NsUiCsi6w4bxnkJcZkN8dzrB3S0A+uR8uYZMqBjo2hV/y+tmLyq8a2WlB3bR
         NQmhCWSFcX5tFq4x21vsOnWixrX78xD/MuZ2rKjM4AzTet2ixv5xy/lkfT2LZATnvZ9o
         Ataqd92gZLUuGQEDFphmLul6b9fc1lGNxdEQOAESzg2DadHW+JE6HDAFmeOPd3QaQsw7
         h8jA==
X-Forwarded-Encrypted: i=1; AHgh+RrlwZDJjYxdXEljLCrmZVLFlGzDSFopEyHqnGtu0sz7mSlyRmt2DSqc8uAUE5+/RZoSFpt+SfnMPQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nuoIVXUUJcDOHyFXV85a8Y1ebvqAObjHavqwFEUk3GHKawZNYr
	8iWlLSFBpuaHlDVX/5bjuDoTU8e4p1wbK/zWzyYr+FfEb+vD4UmtT2uBGG041wLKiJY5Sk/brbL
	JUvZoVq1gryOYZnPomTX78Hz0o6voa4byYoayJV2GqI/fDgWr8h/HkpAqLmjvmQ==
X-Gm-Gg: AR+sD10dcldHumBRrCFetONOCDzS4/X5GdD6m35PhGUosMx9OXRP0QIAyD0rrcmUr/a
	NvPLiEQhAiJyeQ4WXYgH8arZ6TsDfi3lez8Hp0beoWoS7SPglfUPA+PWhOVN4XJg0uXQ/IFu8Yz
	1x3/qvzdekHyH4tKjWsliQCbGFHXMN+NFznb7B8WaxYLAeg/6lfe/1yOokRd+rTdHNuV9yXhYO1
	rV1C2768XPZTZe5hMg497cDU3Wzls5+KbIVG+BdEaV4RvA/8br/9ltjV+qqEQqtx9nVNQ55eAZj
	1rgZsmO4lerH8MTeIoW87CV+bCcs5NBtjrxpdZ91RwIJUgppSaJvNVG7S5bKY4gw8E/ShTUyFyl
	f+GVx+hYO5pZjTA==
X-Received: by 2002:a05:620a:29cd:b0:915:a953:4b9c with SMTP id af79cd13be357-93913749780mr3536576185a.3.1788264015941;
        Tue, 01 Sep 2026 05:00:15 -0700 (PDT)
X-Received: by 2002:a05:620a:29cd:b0:915:a953:4b9c with SMTP id af79cd13be357-93913749780mr3536559485a.3.1788264015261;
        Tue, 01 Sep 2026 05:00:15 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d7e687sm4664913f8f.34.2026.09.01.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:00:13 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:00:10 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] cpuidle: psci: Move initialization a bit earlier
 in the boot sequence
Message-ID: <fuc24y6pvanwxxxan66pgwlshcwz23kiujk4s56vlflr2zm3zg@7tgx545sqlvm>
References: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
 <20260901111441.122436-6-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901111441.122436-6-ulf.hansson@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEwNiBTYWx0ZWRfX3Fd+21l65m9W
 gJe6VIxw/vaE0Zio4z3paGsefMinIY5//Nlkc3Q2lhjPRyg0SNy1uLh73VAAbzoe25z7USEmeMd
 ZtjizwQWjigTeahvdtnbcn3jmn3zGTMb9aQLwT58Gg+/BPXTp+8Q7ELS2iE9y1jZcU7p+rDejgh
 Eyt0rHm3MYIgtw+QcfKRjGoxtk8L0XJOEfreI8wU6977iOvFNKhmXPPfC+g/z531ZCI/LD8W0CM
 Il6ndWTNrFZD+38EDCcZmgsp0L2LbPkmsvfZzh5dMjzqn30sQOzihwx80Dcb2+UI24aqO1TpCZ0
 7tedxlVErL636eNeAkOSLe0YbPzlLPM1oJXsuhsxDnt5rctRcUiAgLh+19k2+QZ+J+HYZN47n1Q
 aMsJ0qAhw4WslQuQMUFELZYeFFgizW7HnG2vLxNEW3nCjMRNw2S9bHrJ/WU+LSyH50pMAj4IxU5
 NqZ4JCLtU18uu3FWk2g==
X-Proofpoint-GUID: V95PzsigDzx5Idd6LyYkKz3yHlxOI3Ei
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEwNiBTYWx0ZWRfXwqJTZj+uORpV
 hNt9YrgHIYGGVXOC+2fuNdQGTN7IGKDRIPmH0f3oecU8mYtjY5tF4N4w4qWp7zVZU2xUfjHq7ih
 5FoM6EPt2l9kPUY9zyeMH2UlvFmNhaQ=
X-Authority-Analysis: v=2.4 cv=NZnWEWD4 c=1 sm=1 tr=0 ts=6a96be51 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tsJcdtOPNZE9NDYWY0sA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: V95PzsigDzx5Idd6LyYkKz3yHlxOI3Ei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010106

On 26-09-01 13:14:08, Ulf Hansson wrote:
> When using PSCI OS-initiated mode along with the cpuidle-psci-domain driver
> it's of great benefit to attach the CPU devices to their CPU PM domains as
> soon as possible, as other non-CPU devices sharing the same PM domains
> depends on it to allow their devices to be probed.
> 
> Let's therefore move to a subsys_initcall, which should be soon enough
> after the cpuidle-psci-domain have initialized the PM domain topology.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
