Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721E3C4572;
	Thu, 30 Jul 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418051; cv=none; b=NyOnyvGY9///0BwY1oOEmVQuAWvjkhNvxrCrHJ1vWStfuTHXvjYZIn2yQJQW7dXkY9Z2KRtMizF+9KvU0rtriyPYctQgGZ4VKOWxwweNq2r3QvNnzkvqCt2U9yhVz+lX4/zsupm2K5vC5ikA6rbNI4ILeLeFritCCVZM94jk4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418051; c=relaxed/simple;
	bh=k3bXAJG7NWiQ5+q9rZvHpUWfUuBY/Z0D6Aae9E7hwJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/thgscZbqTSr5b0TeSt47v/ulUhGit997MLTKWgsAinjKaUfGNti8RWf7yWWviwfNENaucJ4ERT3ZOclLsJCQayrbiXwDY8rOjmQU9yhmd6HP0vdVsWWTlsvnX5fD8R3gTCjrJrZoj+epO/D+YhYOOOHbJdPNQAZAB1gxshYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMOribUl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMOribUl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDP2j920538;
	Thu, 30 Jul 2026 13:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aT+T9J9OUVhzm9vgVnLZSep2Z41lckJUmxQ/vTHQH7s=; b=cMOribUl5QwTMc+D
	voAHRt1RzOzfDGtCIWZTNGN/5obugQiLZPmrNVaRo6+CsdiP6LN9JfMY6lHDTT2A
	rMbBSAWlZM9PdSCADdvOdnGDjEaSxFTSgQk2sz/OVjUYmGBYEokFlu/OiWodqzdZ
	UaGSmRUxH7GGn+WwoF6JWuLtiphV8hSyW2qcQOLFIcASpWy+f6Lano82JSSmdYIy
	9uoQNaXjQ1YFrv+U99wyR3OrWB9YJj1HUawlDazc6gdNhh5VqrjwxQfu6db9XbeX
	vNH2GIfQaefxBGGwiXNNxWcE+arYsOMdsNUHEDNQY9Tm328GToV4zUC1pE72K3Hf
	WjsUIw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6s1r7dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:27:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDRL7k004231;
	Thu, 30 Jul 2026 13:27:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fmp7k65tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:27:21 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66UDRKoU004225;
	Thu, 30 Jul 2026 13:27:20 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66UDRKOW004224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:27:20 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id B47A0B31; Thu, 30 Jul 2026 18:57:19 +0530 (+0530)
Date: Thu, 30 Jul 2026 18:57:19 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: power: reset: fix minimum reg count
 for pmk8350-pon
Message-ID: <20260730132719.onaqskeg6jsjm4y6@hu-kotarake-hyd.qualcomm.com>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
 <20260724-b4-add_pwrkey_and_resin-v6-2-41acc214d93a@oss.qualcomm.com>
 <20260727-weightless-fierce-tiger-a9c6ed@quoll>
 <20260728101223.5uvgmqmpwgvjvysz@hu-kotarake-hyd.qualcomm.com>
 <3e50d846-e850-4c85-97c2-60a34b66e976@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e50d846-e850-4c85-97c2-60a34b66e976@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: QvAhPHqCFOfVvnt-fYi4BxmJ2Te6YJn2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX/m3MEExnAg4U
 L8IA3s7XOQLWGGRlpd3yynlbNunSciS9R2t/KB8OEGoTNPgd+dP2PGVUyZGp/QTm8WayZxfJxZb
 js4YutF1Q+rhM+eAcP63f4sqKh8pO6g=
X-Authority-Analysis: v=2.4 cv=EK42FVZC c=1 sm=1 tr=0 ts=6a6b513c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=94fjyzl-pMFmqcS69P8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QvAhPHqCFOfVvnt-fYi4BxmJ2Te6YJn2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX+cHP+H2K9CQk
 lI0kZUUYSCveX/N+knhZJZ+sQVW3d9JhzSUZnlYgNzEfC3TLJWMdKVYpB97gCE7d4CY7TP0i3SG
 RTz+eD6ixM1xojUndhdIk2AmeuKmjP9OaixR/NiEaB2U6rAIjrwdwQEPvbvszo3iKOhjfj/6PcM
 cA+CIqolMI4dHIqXA9dUm2SQC0CjF+UId7kpkk2E3LbvqHaa9OChhT0jdF5qUg0pVwn3J9lTneK
 wIRIRhVh4C06y2cPSbu7J+oK8QhhzifHlv+cayJSUTwGuSI814d4C//qvgdKVoOY2bzWDl5ioc0
 0vWYdpvA0i0p9Gib6pBcn0hJ7M9KexHpPEJMpNrXYhennnBZUGXGPPowpOFEQh9JD0ri0e4ufIl
 fCKLc7sVDVnWFDt2yFmCZCKBKYX3oCdpLVdlDBlICbFDA/+0Dm0pGrGMJ/OaPt1pu96XYw1uuHd
 /ZVEiFDY7zKK1DmSOtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300102

On Tue, Jul 28, 2026 at 12:20:12PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2026 12:12, Rakesh Kota wrote:
> > On Mon, Jul 27, 2026 at 08:36:38AM +0200, Krzysztof Kozlowski wrote:
> >> On Fri, Jul 24, 2026 at 03:44:12PM +0530, Rakesh Kota wrote:
> >>> The GEN3 PON peripheral requires two register address spaces: "hlos"
> >>> for the primary PON block and "pbs" for the address needs to be
> >>> specified to facilitate software debouncing. Set minItems: 2 for reg
> >>
> >> That's ABI break and I do not underestand if this was broken before or
> >> not. Driver ignores the PBS, so everything was working fine, no? Then
> >> why PBS is required now? Is it actually working or not?
> >>
> > 
> > Not an ABI break. All in-tree GEN3 DTs using qcom,pmk8350-pon have
> > always specified both "hlos" and "pbs" reg entries — pmk8350.dtsi,
> 
> That's not related to ABI.

my earlier reply focused on justifying this as "not an ABI break,"
but that was never your question. Since the driver works fine without
PBS, there's no functional bug being fixed here, so the ABI-break
framing doesn't apply either way.

> What about my DTS?

you're right, Whether an in-tree DTS omits PBS today isn't
the point - tightening minItems retroactively is an ABI concern
regardless.

> > pmk8550.dtsi, pmk8850.dtsi, sc8280xp-pmics.dtsi. No issues were seen
> > precisely because PBS was never omitted on any GEN3 platform.
> > 
> > minItems: 2 simply enforces in the schema what has always been present
> > in practice, ensuring future GEN3 DTs cannot accidentally omit the PBS
> > address space which is a GEN3 hardware requirement.
> This does not answer my questions.

Hopefully the above does now - to summarize: PBS is not functionally
required (driver skips it fine), so this patch isn't fixing a bug,
and tightening the schema risks breaking a DTB.

Given that, should I post a v7 dropping this patch from the series ?

regards
Rakesh Kota	
> 
> Best regards,
> Krzysztof
