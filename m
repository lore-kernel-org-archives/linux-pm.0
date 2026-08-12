Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074E384CDA
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520209; cv=none; b=GLTg5UjRrDYVX5ykBdhvf4bX7Ipwpsn7TZ3aUrrhODSLBWgDalzTcrflgLCxEV288WPVtWTgrmUwDv2cI02znozR58sHSFPkjy76m1cxTc5Wm40AN0PGAbDsBr8RRNISYvPE14S4HczBM+jBfSzX9gu0O3S6fmLezXuLI8IXACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520209; c=relaxed/simple;
	bh=Hn67GR+gO5Esig7XtQGNEiHvrdUGoUdeHXneZMlfYRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I002hmpCPYVWGiuv50eqsGAk5ByQU14lI7cGOjtMSIKbUmOMXcJKabXyjWQXOFbPz+aIyKgdP/6uLtiWzS6/19uo4HYxT2gAR34RIWeX/qA9ja9o+1PWpk/0Y+KzfVCBv8Fhz2v60mxTCs0ObAjguFYqcWTF3zMJrlOWmufaLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUT6U5LF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5aj7xxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUT6U5LF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5aj7xxI"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62U9Z1720208
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=; b=DUT6U5LF+ORWHPgL
	7A5td5L/EjOH8p5NfbokYu8RsMKY33NfTAxUJ2dQtUiQS2PYGYMFtcwLFGQ0RhAW
	2s/AE0vc+NDkEPsKAfG7qWeyazG9/FoFvPWQJVznO85jF2K1nQQ7AS3XMz77sghP
	YKKRZVoh+BdtBdGfTfBp0MDAlueYM59rI2IKupHHwqrZBh5w0y+TillzsXrqa5l1
	9kh8YY5CZ/3sqcHD7KDtcCXuj1zL3AFBVkwpo/HkctruQhvQFfgTKR8TicTp1sWL
	FzZ9vua5JnOpHLzgo/7Dc/ms+JMC3+77Uml+D3cFHfrbfgk6FltE5+RT/HeoWhwQ
	JDJXbg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw0r0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 07:36:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso533698a12.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786520205; x=1787125005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=;
        b=V5aj7xxIGb24dsIzjhBnFqzUfp2Kb9WEFqp7aaZfnDP2SyrIHFxtY8+50hqg7QrwkA
         jEaMQXBq+j0YaY1m/0XpsQCyKhvMxKJyHvpr5mg1P09N2Tmok70RKtqbQu7ltlo6D9ib
         TQZjFt4p5cJTzpG21K2FztoYyHeAG+ld1ejuc/l2ZbDIOmKEmDv4E4ra0eFoIjfzLHqK
         POJOkJQ16lfdVnYdVd1GOPX3fy9GtXjuI2xOUHTohUSb/ethHCPrAOfw5tloMVGsWZRx
         jHxOQzknr0B5TemGz+2og8cE5F9dpDXX9aoJE28dXYLl5lxfA9w91RYwx8DlirS/kiOi
         A4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520205; x=1787125005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=;
        b=EEQN8xmXRWdGVNhsYEzXwKWNOujQ+nLg2820aBQ4oUmSkEM97eJHOlBWXQN86RfsLw
         NEjTv42Kxu4ffFO+25UQfejJDVgDgS6vCvaedY/UQpubowrYat6YuueggwmYaOc6IntC
         DJFnRuR5rJG+v0BTjsVpTwVzBslso6nlj2eXJNENkCnMNvp+FI62LRoNgFA1R7zx2Hk0
         DVYYN8aIRZ1edi4TF+fQPDUAdPRezf+xo2sanSNmN3/NmGEJhckrT89coQ+ZDruM5wx0
         /Ac6/dhMsUj9G71s8ukyY0kdtBdV6XR7hAMDczeD6u0bN5OYc5JaalmgJyDhA64jJyl7
         a9zg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0u4RJ6rTLqMyC9pzRrXuKfV4bsqT5UQt2tliaxVJ74IKF0npc/wTOVn8QX7u8TKG/Geh2pmrhWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjelpevir/t4o83Vf1ySRtwcYkYYzt3cZjmgNA+UP1BoOQsPA
	u5dmsuWfPO9muwl3+VTWpjy6HQNnwqZFwg7pp760qJXUhKpbZ8S1YTP00fpd1svjy83i2Bv+DrB
	Lx3Vk1/hJSaNT1PZiG3cO8T+RMkTtC66y/aWOdRuMKCPmV4ek7vlr1B3qIgtRIw==
X-Gm-Gg: AR+sD13d5CE0aUOj2mQj10AIKV0VHLQxcNCh7limaZPAfCAGCNJ7BGzQwPF3lgjcxFf
	B5Lhui1aZ1R5bTeNWliWH3ocAD8OPlLT2MtQVoSpLquUPC7qwSWQar1ZXmUXDelO9Qt3qwrD7Te
	mqxc74NcHgKysqkAwG5V+vFYENlqbkErwc+i9pvj303C5b5PRKs5uo4yYfC4yXCoFtCswBqZIYl
	5iyVnmrppJ3MquF4036vcsdTaK1lws0ci4pZ8NMRvimyehzlcDnxFU9a+UGIBpg8OkL+uwSXT9G
	L3m7eYLf18ZsoefJEIdJzucJTqjif9wwjjDcZAPo4FCzdnxByetHCyZ+36CiGmMHEoWLq3jSxSl
	guhGoxqTS6tcmw/NOyuzQ6rgH7hcdd/elJw==
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3195031a91.10.1786520204571;
        Wed, 12 Aug 2026 00:36:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3194989a91.10.1786520204012;
        Wed, 12 Aug 2026 00:36:44 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f9675e32sm829428a91.0.2026.08.12.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:36:43 -0700 (PDT)
Message-ID: <2c036793-23b3-48d4-834f-9daf8000b2d5@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 13:06:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MCBTYWx0ZWRfX/gQCpprEbGtz
 uAYIV3MEcybhaWaMTgv3SBsMzvL9mzSDLPomGtQaAl80Zj3IF1+LDBLZk0PiEWFV7qPeQJsXdGq
 fChc0NjOOkYOhqE7kuXWy7ubiOkDTd4=
X-Proofpoint-GUID: DbQIQLUJ3MsbhjWHJzwgpFFyiEtkF21v
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c228d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: DbQIQLUJ3MsbhjWHJzwgpFFyiEtkF21v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MCBTYWx0ZWRfX+cm2ODkCh0qM
 DZltfQSDX1znEKNzMPPjNtmojceN9EHk2dBMQPbtGzNO/Gt0LHh9SLVw4+6EBqTYuugpApVyJZH
 Q7UaIa2YuRQHPoktYaqYubmkpSpIB72yi+LPAKpOgaw/c/bhBowCNDrCQh0I1KGPQE0zIIqL9jV
 TgvC3uWmGIPzsh1W4ofxMFFNSKTe00ryk0rD3E0eAe2X0+GPFhFIm4SFJNzce6z3XN+RC03S8VN
 6fr3B3CGRJnP11/F9sQ1VHTN9OK0Aagh81Xms3RBSTNMyVrfss4LFmBzmr6AipUXE8iEWWQalo0
 4JPRezyBd0GP4eC+0pLzHqY3j4Z4YA1hqMVNvj+13URQJ78taw3OZR2DJqQU9Pm/0+VesyWdV70
 xNt08XPFenoPtGp87kAddw0wl22yjaIYfHOYsWUeqMRYZ54swypXGdGKv8CbMi3yJS3IBtlynZ6
 8kUiDMyq87XYCAVns8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120060



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> Currently, on the SA8255P platform, protocol drivers attached via
> geni_se_domain_attach() treat each OPP on the perf domain as directly
> corresponding to a protocol value such as a baudrate or requested
> frequency, and simply request that OPP via
> geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
> computing a source clock and divider combination for a protocol
> requested frequency, unlike the Linux clock managed path which derives
> this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
> applies the matched source clock frequency with dev_pm_opp_set_rate().
> 
> Change this by treating the OPP table exposed on the perf domain
> device as representing the actual SE HW supported source clock
> frequencies, the same role clk_perf_tbl plays for the Linux clock
> managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
> iterating over this OPP table in geni_se_domain_attach(), so that
> protocol drivers on the firmware managed (SA8255P) path can also use
> geni_se_clk_freq_match() to pick the closest supported source clock
> frequency and calculate the required divider, and apply it with
> dev_pm_opp_set_rate() the same way as it is done for the Linux clock
> managed path, instead of relying on a direct frequency/baudrate-to-
> perf-level mapping.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
