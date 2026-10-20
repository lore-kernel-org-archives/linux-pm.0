Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500563;
	b=ESXOUZiBzV3EaTYqdncr4DMt0TUw5KEaOE+JVi3IO1a1EPZnOnuD4EC0/GbrE2IUT33w
	 Ag6cU5HHxF6xlwHc30z92njMOEBUeyrU/6s/S9JZjndWgYgXghWcZ+flMYApC06sHCNTv
	 WNMuP/LnwXjE641uosIGZDe3Sesc+FKjXHFGGm4VodUOhferb8Wt7ZqNHGplB0FuWAfU0
	 rlsmkxxujbwo55WwMKkaEbS1eRcmRR7VSRDbaGU2Mp5L7ZlZiRD7QFL8F3WQFazNHfgGB
	 uZPTVE6t/KtQSIeF9ZblfoLQr2jZSn7B60KDTfHHX6iY99w3bIqF19/UmzQM2sHUAOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500563;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=oZR/dethywgb+OWlTTYLjm29IyP6L5k94h7PLYw6w6w=;
	b=TAA7LLDXc93QVGsJEhcfDo/8w45A6l5AqJBS1Ph8vRPGLsHOa0m74heTjgRHboC3gRb7
	 q0x82v7lHxIMC7CmRLDAHKMqbJQ2mg2TVQRsycNFEOIH16POgCMomeGbthwFDqxurKv7x
	 OGxLuQcWUmJPu+6xowjgLOZEH987dvpIbDmpekYqnS7C2qNAOUdBafqde/CLX8pw3VHFw
	 Duhlk+rnhT7N3AQL68GlUWDhAHQ9r92+8sGST6zFLRhlD8iMrdWyNAuUQieHQwcGRTZaw
	 Yx2h3Am0aTngEDZOkohUT4z2/yJG9gvoi17M1/WP2goSGVtSSrBbr3ddi1I/r6u7K/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lRpMf7yf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LI0nG2Cf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A4606A326
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lRpMf7yf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LI0nG2Cf
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAxLIs1145637
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oZR/dethywgb+OWlTTYLjm29IyP6L5k94h7PLYw6w6w=; b=lRpMf7yfcNp/VUHq
	O083DxWJD2SSOyfl5nYh1RCJEm0sBLZD9cns1wrqEliBGvO1yjk3jbyDBp5ZNwrj
	ZVjGhJ2SsonlHQDLRdV887MrRw9RhyDBNT3E62ZSihfUyEDOVQ0gG4EsaepzGO0H
	PTfPaIc/cI7Smh5FnwgYXq7dfGK/XG3WyBK6YFFZj/rmIctTA5w50CsRZHTjjoPL
	UifiwWn84EIFk0e/OJaloarlmMOvLOgMLrsumnz0JcO8bUDlxSRJ//OYy4aJHV5v
	kzStxvjHMXTfN/ISFf7XwFbxVddgFeIHrgFtOP3GFWd0Sk+zOeTiy7GqvqBichQd
	I1y8bw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qafuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:49:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c5ab5c136so527492585a.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792500561; x=1793105361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oZR/dethywgb+OWlTTYLjm29IyP6L5k94h7PLYw6w6w=;
        b=LI0nG2CfRMB0TDMj7kdGreMXiV/FDHjQVwUVFd1YcacaCxrNTckVGXpjypsOxlyXcq
         aAalxYTdraJKngl1Ju4u0lBwG20IPCOkpF4dDELF+UIkKBBHhW41ys0XUjRn4nQNUuqi
         0PC3tMC8BrIK+yQEfyv3l85SdmJQiZoHlV6BhAkV3N1pSpOcf9mKNoNnPfb/GbE5T1IE
         nxbkWKDvwpx103q8C6GKdIkSnNXY4I0Q7IUMPyLgzPeitNefkWr4nQnpElidSuwRygfi
         cLJJ/fSuGqj0OIrmKn3YbqT0bRGzCBV7N1DBDNbLdlkar5GCYq4bBMwFx7MTOz+E/4x+
         xb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500561; x=1793105361;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oZR/dethywgb+OWlTTYLjm29IyP6L5k94h7PLYw6w6w=;
        b=xb3cGRwYQtTTt/N1raJMDaiGrk4yZ5dZx5FT9nYQguEs9qr1V8FY88egZgoGLJMfaF
         Kk8j0UE54z0nE8ZVwPfIIZTUtj8B+H2BZagwhVUNsb6ABmk4l3EpS2fDmBGNH2e1Wifc
         Pwl/mX8m6OXabrC9uMtcXe8xqHTpfMw4Rq08U4kI+JQw0cHw2F943lyTg1bVcoR+Q0le
         IDkRrDXUiSStavEzE0LjMG8GD5PErauSE75WN9gbtR0FB3FLo06MUq1x0iSRMLQlRlhP
         OYl4H3XRbPxKSyUCeCtZNQd8ZzjlpPj5iYldFB/KTvATSpNu/JKbWO4GGmHziYc/okpM
         II/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxLTQBJRzLu8ofVlDXQDO3+X2sVdzhn/rGKK/mhPUONKr+FljPghh+VME/02oy2DzkVvNhKyUQEQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9kCwV1k6gwcgR704o4rwDtAF0ILbzI37HoaiH1eLHyX3USZCF
	MYqfq8x+xnU8c77nTN8UYQNBisyn6vHp+Ju/tKuUDudkHUSyZT27SSA6wmcrr90ylXlGOs1THH5
	vza+H/GKDQ6hRH/H2kxLJvQda9Zy0+8TD2Ym81+U10cslWZ6nOeZRbBbvreTq0A==
X-Gm-Gg: AYBFou107UTyc6Occ7tLXpswcWGLKBf/JQf8M09V1pUOm95gyr/vsNqMfty7aX2fBew
	YsJPqHFCZ9dYs/uRgM2242NcRh9xQZkIyayfs4Mv5d4eG7Z6qD46bwtZW/lyYoiKzop+qfjTyP/
	twXa6Gml+VrgQXfeCoPL8VgrpI+YUJtWPlN/KNCj9t6J1RxDX3DLAQTC4pgPKng0lbElM3OKIdx
	IjrF1DN98VO91yNoT6Y2oKs5mQOCVo3gPL0w/PPd2H9fhuI715m+PK8+PWyXWRd3MFcGNtLsBKx
	kNop2xgtCqyaZ3QhK2LDxZVYqdVnFzY1sYGsfyVlnPE6oc0VMU51b6zj+Rv15rKypclyNW1jSS9
	plUUiaG/n1dLkbAQYCeKtsM2ARfh2J3o=
X-Received: by 2002:a05:620a:3955:b0:93e:7898:4d73 with SMTP id af79cd13be357-93f29d79550mr1681664885a.45.1792500560811;
        Tue, 20 Oct 2026 05:49:20 -0700 (PDT)
X-Received: by 2002:a05:620a:3955:b0:93e:7898:4d73 with SMTP id af79cd13be357-93f29d79550mr1681660585a.45.1792500560283;
        Tue, 20 Oct 2026 05:49:20 -0700 (PDT)
Received: from [192.168.1.73] ([92.247.57.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820822sm6490980f8f.34.2026.10.20.05.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 05:49:19 -0700 (PDT)
Message-ID: <a01d8d86-740e-4a25-96a4-d4dfd664af5e@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 15:49:17 +0300
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
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add camcc interconnect
 cells
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com>
 <usade5zkrncpry4ufbdtaahoa2zyd5hx7tjgfvzfte2aqbkgs7@t3mej4maj6za>
 <3e5b7781-20ef-4e84-bb62-29a081c26d8f@oss.qualcomm.com>
 <x5x4av76vm3swozvwe46uq5vz2ys7bvo4bducpp7flnmhykg65@pvr3znxyktje>
Content-Language: en-US
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
In-Reply-To: <x5x4av76vm3swozvwe46uq5vz2ys7bvo4bducpp7flnmhykg65@pvr3znxyktje>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SPGvf4-BptwlqPo-zjfOmpTU_DTZw7E8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX/t2URcKY0kfn
 nWQW67OZsvPKkmHGwqHtf2Bc7JYv+FzT7Kutw4UYKdgcWiuxf5+ARI4kpNDRJMCc1enqHhtbEWx
 EB4u2geFhsEaBeFHSWLkbQWaUQaGo/IgxY7AmCB4gcMKh+yzi/qkyhXee2amSH7Vdj0GuevKuGE
 UvFOaeWeiWuukEj9IOKmIGCZk1rE5ZnqVO6yqwe3v8UPPoI/7sOtkHFfrttpJmxJcFfTicAUNTi
 EwbWqLYbY+JPSmWrYdPm/1/DCuMBKdM8ALx+rn0bK3YrcoVMz/I3eYHP1DQHL4TUppvgzfAFdCk
 0kFFZBZ3OeKmcfxZ9Yv9fMV/B093PBRoVfZNVPxC5ZBsEZy3KbMX++MB4YfMsk3Zx+2wMcdM/Ni
 T6UJwqedLq0vKxr/6A3zcbq7msXZbjtG5D2/5Y9ff7M8DcPOK6bLBIRx11txrr9EpYiNhUNADjS
 H0gTS18vqshQs+hL3pA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX7RLjmfHyI2MH
 KNvMpqXSHRree9CwDzBi1JzsTp03vfMe20lIeO9Ha834Mw033sQjZeWKlGVgS81Urog/oQcsHoP
 nZnJZQNGoKLj8LtlhkiCFiG88ESeSZU=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad76351 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ybD9qRDIDfZaXNPQ7Ca20A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=z6v0ilfeUS-LjjL2a7cA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: SPGvf4-BptwlqPo-zjfOmpTU_DTZw7E8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200050

On 10/20/2026 12:45 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 20, 2026 at 11:26:42AM +0300, Atanas Filipov wrote:
>> On 10/19/2026 5:50 PM, Dmitry Baryshkov wrote:
>>> On Fri, Oct 16, 2026 at 08:07:01PM +0300, Atanas Filipov wrote:
>>>> Add #interconnect-cells to the camera clock controller so camera
>>>> consumers can request camera NoC AXI bandwidth through the
>>>> interconnect framework.
>>>
>>> I guess currently we have only one consumer, camss. Could you please
>>> include patches converting it to the bus voting? Be sure to retain
>>> compatibility with older DTs, which don't have ICC provided by the camcc
>>> node.
>>>
>>
>> Before converting CAMSS I would like to agree on the approach, since it
>> cannot simply follow JPEG. In either case the camcc path would be
>> optional, so older DTs keep working as before.
> 
> How does the current camss vote on the clock?  JPEG is not (yet) merged,
> so we can't reference it here. The order in which the patches can land
> would be: icc-clk, camss using the (optional) interconnect, JPEG on top.

It does not vote. Each VFE calls clk_set_rate() directly from
vfe_set_clock_rates(), based on the pixel rate of its own lines only.

Where clk_set_rate() is used on camnoc_axi (SC7280, SC8280XP, SA8775P),
the clock is shared by all VFEs, but:

  - the last VFE to power up wins and may lower the rate under a VFE
    that is already streaming;
  - vfe_check_clock_rates() checks only the VFE's own needs and does not
    notice changes made by other VFEs;
  - vfe_put() never drops the rate.

On the remaining SoCs the camnoc clocks have no levels and are only
enabled. On SM8250 the levels sit on "camnoc_axi_src", which
vfe_match_clock_names() does not match, so they are never applied.

> 
> Please note Krzysztof's comments.

Yes. I will reply to Krzysztof directly in 1/3. The CAMSS behaviour
above is part of that answer: today every consumer sets the shared
camnoc rate directly and nothing aggregates the requests.

> 
>> OPP is per device, and CAMSS is a single device containing several VFEs,
>> each with its own core clock and its own load. If CAMSS used
>> dev_pm_opp_set_opp() on its device like JPEG does, every VFE would overwrite
>> the clock and bandwidth votes of the others, which is the same
>> last-writer-wins problem in a different place.
> 
> For this series just convert the existing approach as is. We have two
> distinct questions here:
>   - Letting camss and JPEG (and others) to vote independently on the
>     clock
>   - Letting camss correctly handle per-VFE votes
> 
> This series must address the first question only.
> 
>> I see two ways to keep the VFEs independent:
>>
>> 1. One OPP table in the CAMSS node, used only as a lookup. Each VFE
>>     finds the OPP for its own required rate, sets its own clock and
>>     votes the bandwidth from that OPP on its own ICC path. The driver
>>     requests a separate path per VFE from the same "interconnects"
>>     entry, so DT describes the hardware connection once and the
>>     interconnect core aggregates the VFE requests with the other
>>     consumers. The rail level is not applied by the OPP core in this
>>     case, so CAMSS keeps handling it as today.
>>
>> 2. An OPP table per VFE, attached to the per-VFE power domain device
>>     that CAMSS already creates, so each VFE calls dev_pm_opp_set_opp()
>>     on its own device. This applies the rail level as well, but the
>>     virtual device shares the CAMSS of_node, so it would pick up all
>>     CAMSS interconnect paths and need indexed OPP tables in DT, which I
>>     have not seen used for such devices.
>>
>> Which one would you prefer, or do you see a better way?
> 
> 3. Add minimal VFE nodes and let camss use those. Converge towards the
> split VFE (IFE) device tree.
> 

Agreed, I will take that up separately. To get it right the first
time, could you clarify what "minimal" covers:

  - child nodes of the camss node, or standalone nodes like the split
    CSIPHY?
  - which resources move into them: only the per-VFE clocks, power
    domain, OPP table and interconnect path, or reg and interrupts as
    well?

--
Best regards,
Atanas

