Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C613E6DE1
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350834; cv=none; b=WtrjOBwrENqtxmuX9yJ32S8qvp+QgLcrfUq++KOv8RUrQVNTxehtMuAkVwuCiI7xkpnPCMG/cPplQOEjwikgEPjmJQOtPFr3W2yE+3sgnhpqTTa9Luuu/rGdIY8DQO44I/A9jItz3gqmsRazeQeAtD2fYdgn6eQf6wxPO3RJtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350834; c=relaxed/simple;
	bh=SQVPvZi1QiTqiL4AoVGIjHTVBooBkUpJREhkFFCm4So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHkm6w7aQ4t0mzf5JU+UtqKivOI5g/KXd6C+jaQ8xnqIBBDzjoICyCwPYQ1MlfekU3aScHmoCpEd0P5ikm1w89z9XNCNVNOvQ1Hbl6JJqHKQJobgIRpd/ixPWpPgF1Aq7lOgUd9lQDPBmidDPC0pHBMaH811mpmBFpTFY4x1bAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJEkJ8O1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fTYx5v5f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJEkJ8O1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTYx5v5f"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8xhBr2322926
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IDmXyXjtsD/lrp90016J142m+1InnYfXGgFq1lOWOzs=; b=nJEkJ8O1MVXJ77uH
	ploITPedcb8TEnEyw0bdD3ThzsQPPfgawvLvsC0Qj04Q2GevODP/CzZremHvFgoS
	MsWmAYqV+J2fT34aYMboNcpALJ3Ut1NhebrJCjUgAIeWZ7ulMif0VTqNIfDMngcz
	GEV6s8AVlY3eeD9z0dcesjB1iokKQFhsPHIxhIlBxuPE8GMx2LbXDZDblIwRPjer
	uYn+jP+LsP4q8Zn07Sjzh4Tr5yq/VBJhzVkguFZVkwbjIdpuheHLQ7toWXSypMOk
	RifJ3KIulIaWkW2ylsfISbHbTOx1nmkC6fsYJp9eIweEPjgR2lVbP/28JM40sHPW
	Sj6Mdw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qkerh37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:13:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89cbeb95521so802986d6.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774350831; x=1774955631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDmXyXjtsD/lrp90016J142m+1InnYfXGgFq1lOWOzs=;
        b=fTYx5v5fLcd9dCOUO1tkJMC6neAZROdGwYUHuAJrhTsIb/ukRdQqbuapAtMclCTBIR
         pkV7ruRym9q7jxbNsAVqSrGIBsPLJREyem1ZRBsPRsoxTZ7cA1RacBC0FamoHmtAdH/f
         4/dgRvSim/DuhqvToRflZcZg3MIyHbC3lTkrWIydBqF/Aspoo/kW36KtLeukBwPzT0M0
         JxTVJXH+4UpR+YNC1ZGOdlydldM84Y7cYnnNMuhILeOz/+55G2viVB/+KfXEJRGD4nns
         8cVvuilCIhOuqV87PAcpbXw9hJq1mw1AmIoc+VHFFre3TFY3oinMrLMU7NIASlsrOWUT
         zJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350831; x=1774955631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDmXyXjtsD/lrp90016J142m+1InnYfXGgFq1lOWOzs=;
        b=S3ZbnjUE1fFbdBBI9s3tpuOB3Od8WjrDB+tYXL0U/vOMQC6ehzUwatU19OokDex4gv
         TdzBDLnDd2CL/PqoSN5KsnjrFAAE6l7yu3HEiJoPaM4Q2G7LkXdP/CUQbxGSpTFiGrO1
         yvpTAZpJmo5AxAmm2MHm49PB0ZVgXDc03408dwkpbVihj8q4cBGZrua2mC9BHuH0Cc/A
         lo0PLTFvdnNcX4FAptqh+K6N3YIoSBKlhVUEcuQdsoG7yrbPsNEnySCGBRl1/Ia+pG8/
         69KpUOouXUbMaGLEoTo48Ynmw8srrHdsL539pUneYPcxKV6oAs1MtyldEIZ4Wj2K+d7+
         rFjA==
X-Forwarded-Encrypted: i=1; AJvYcCXTCTR4PKYWcXF1Z0kH1/yMsnT3JoFfqIAEh3dO4By1NXixoKIynyofzy3qjW0jluWtbcu3TW10Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvn+6nAYij0R3VIvI0KWQEwoIJG+2tU9JZfQyUOWUAIqH5KH8h
	PuSD5nFx9Z80S2Bb+R9wLZKVLjcwCgBNbK2OgtHMUM7Dy1QmNQhY4Q85sMd81VefCiseGPnv7sz
	nkht25yaSYrRdziBHutuz5anW7T9GurSm1d0bA5YDd4on9DDl0fB7YHDjO6Ns3Q==
X-Gm-Gg: ATEYQzwmHgkcDFNWgQkvFLr09o0LHs1SAq0+M8Su+mFZua5yVMToauQqn+Rcj/chATP
	wxPmKwwcFh1ARq1JQje5qf42knvcclI8LJE5omha9ZYd9YJ6oYW7cMAZvNQKPbCgqtn2cT6abr+
	g6HHz63ucfB3gWT1/dCP2izOXbfaGJoD3D4mqnSIWlGSOOJFBBG+fKpD6NHzM5L1yi9Nzc/CLUB
	AeFnvcgAqX992Uh35QgKzyGBymhS6QJWmOstfx1U+fxI66RJN29EVIBlPhdd0/dZ+DN/veYsZh6
	oaIbNqNOnN2FjIWiqlQ0hTF2qHiIN5eAURZgW+8i30hT4YwwxMmXctlWCfha//QOY1qG764zrnX
	pMhYxXNClkStt4iKB+RO4H3NMmrPU7GXAVCd85IUqvS71c+W3L9jBczERQdzYl8U5qDbPbdoOwu
	+p1Xs=
X-Received: by 2002:a05:6214:27c9:b0:89c:4aae:408f with SMTP id 6a1803df08f44-89c85a3e99emr186591886d6.5.1774350831078;
        Tue, 24 Mar 2026 04:13:51 -0700 (PDT)
X-Received: by 2002:a05:6214:27c9:b0:89c:4aae:408f with SMTP id 6a1803df08f44-89c85a3e99emr186591436d6.5.1774350830576;
        Tue, 24 Mar 2026 04:13:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335de177sm622414966b.29.2026.03.24.04.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:13:49 -0700 (PDT)
Message-ID: <acc4c006-27ec-4ee2-9d99-7efdf8249364@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 12:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
 <20260117-efficient-fractal-sloth-aaf7c2@quoll>
 <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
 <9f8619d4-43ac-4bc0-9598-c498d59a27b8@oss.qualcomm.com>
 <acH7aEBvSbiNwhBz@hu-mdtipton-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <acH7aEBvSbiNwhBz@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qJWZ6-doQZCfVcYlrDH-XhCe-IHWHtoj
X-Proofpoint-ORIG-GUID: qJWZ6-doQZCfVcYlrDH-XhCe-IHWHtoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4OSBTYWx0ZWRfXxoRlt7+HAtjN
 7BSNNEtk+jbTaEwh8jNhWVUKMMO/m7+ckDj8vjEVUWdMbzkkvr7MtLDk8a/MLJ33TEG3HTfC3n5
 d26O645baST3ZkRKbDwWiFxKSr4OuAmRgmbROAdrBnHXoatJCHE9dFEMfx7uHJOJwKqdD/N59aQ
 c71bnz2nEHB0sD8yCYUW2e4bDH/A6LxwNu7JuOmAAAdojeciCR2dDD/N9hQOqCZufoQ8Jydq1YG
 uawlcBcI8SWlDlsKgGJg3GDaph+SroXbJQY+6c4qMB37CTrmyliVA5cccZFKZ9cavO/EFF3xK4i
 y80CYJSKEeArPxbeu9nPAWJRUfp2NDFGQ48U6tgUOzJSJ3oZi11FsploxHZmD00sm/lM6Gm8+F5
 Sz6cTy14coZoQzCl7YfNOnWcFUnZtdCFS5o1oL2Auv5h/VtOOfvXj/DQX/eEKuSBp5sfMpKjWQW
 ZeZWQyS0nz1EDeb6VAw==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c271ef cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=WLTbINpYHCHO6pnoh_cA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240089

On 3/24/26 3:48 AM, Mike Tipton wrote:
> On Mon, Jan 19, 2026 at 11:28:07AM +0100, Konrad Dybcio wrote:
>>
>>
>> On 1/19/26 11:20 AM, Konrad Dybcio wrote:
>>> On 1/17/26 12:46 PM, Krzysztof Kozlowski wrote:
>>>> On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
>>>>> Document an interconnect path for camcc that's required to enable
>>>>> the CAMSS_TOP_GDSC power domain.
>>>>
>>>> I find it confusing. Enabling GDSC power domains is done via power
>>>> domains, not via interconnects. Do not represent power domains as
>>>> interconnects, it's something completely different.
>>>
>>> The name of the power domains is CAMSS_TOP_GDSC (seems you misread)
>>>
>>> For the power domain to successfully turn on, the MNoC needs to be
>>> turned on (empirical evidence). The way to do it is to request a
>>> nonzero vote on this interconnect path
>>>
>>> (presumably because the GDSC or its invisible providers require
>>> something connected over that bus to carry out their enable sequences).
> 
> The GDSC itself shouldn't depend on MMNOC in order to turn on properly.
> It should turn on just fine without it. There *is* a dependency between
> CAM_TOP_GDSC and MMNOC, but it's in the opposite direction.
> 
> For MMNOC to turn off properly when all BW votes are removed, the
> CAM_TOP_GDSC must already be off. If CAM_TOP_GDSC is still on when MMNOC
> starts turning off, then MMNOC will get stuck in its collapse sequence.
> MMNOC waits for all HW clients to de-assert their active signals before
> it'll allow itself to collapse. Most HW blocks assert this active signal
> more dynamically than camera does rather than tying it to GDSC state.
> The GDSC asserting active signals to RPMh that prevent NOC collapse is
> unique to this particular camera GDSC.
> 
> If MMNOC BW is removed when CAM_TOP_GDSC is still enabled, then it
> should reproduce as an icc_set_bw() failure on MMNOC rather than a GDSC
> enable failure. The icc_set_bw(0) request would succeed because RPMh
> immediately ACKs down requests, but the collapse sequence would get
> stuck in the background. Later, when someone calls icc_set_bw() again
> with a non-zero BW to enable MMNOC, then that request would fail because
> MMNOC is still stuck in the prior collapse sequence.
> 
> Note I haven't explicitly confirmed the Milos behavior, but this has
> been the HW dependency for at least several generations of chips now.
> I've never seen this GDSC get stuck turning on because MMNOC if off, nor
> would I be able to explain offhand why that would happen. But MMNOC
> certainly does depend on this GDSC for the reasons stated above.

In case that helps, I believe Luca originally observed that keeping the
display on, specifically voting on the:

&mmss_noc MASTER_MDP <-> &mc_virt SLAVE_EBI1

path made the GDSC power on successfully, lacking that made the problem
come back

The nodes that are hit on the way are:

qnm_mdp (mmss_noc)
qns_mem_noc_hf (mmss_noc)
qnm_mnoc_hf (gem_noc)
qns_llcc (gem_noc)
llcc_mc (mc_virt)
ebi (mc_virt)

That translates into

mmss_noc -> MM0, MM1
gem_noc -> SH0, SH1
mc_virt -> ACV, MC0

Notably, all of the foo_camnoc_bar nodes reside on mmss_noc as well.
May it be that voting on them ungates a clock that (perhaps recursively)
feeds the GDSC?

Because the platform is not suspended, the latter two buses are already
online, so I'd assume it's one of the MM BCMs that's causing something

I can't see any details about its inputs.. In case that's useful, the
GCC driver enables the following camera branches as always-on:

GCC_CAMERA_AHB_CLK
GCC_CAMERA_HF_XO_CLK
GCC_CAMERA_SF_XO_CLK

Konrad
