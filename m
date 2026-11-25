Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598664;
	b=5cO+0OkrXoQiP8jPBgacSWqNrSShh8+QowY7RGkwMWAFzAaGcCwvWuI55OFfCvFdlU/z
	 hkiKdI/ubueC+qlv/x7lqEd1g2StwtAHZHnDdwDZxiIsb96/5i7GpzUeN55204t0BqQFT
	 Ap03UwzBDfENO/ayWypoodgmDFUIddBlrGScRPE6P8geXe1HiZ45jOXfccDpr5VUkdjJ+
	 wINdt5qg4S4qTEOh5RD8C+pbejfJOpWxEE8r74IkH7EcVhZt49IHbEQR48vriAWqjbTUN
	 Rm4gHmP2RZhcx/3sCS2Zg/B3ckaMwd3X3okpy8/rPN4pXKZLWNh5vMv0Xzx+OgP7aaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lGmW88CnQl9hiGYpiWfwaSM6NmzBZwZKuT4WR9HAtaY=;
	b=rhyZ1X6rzorjUzx5hnc9b0CIV7jGt8vmCCFyY++JYRB0gKiGGDDRB9aE6wMxnu5L4eM2
	 IoQbZO4JFoSKTyW5ltuU1eMAxmTYc1TAfjyqWe/uOhTt4uCK7WaGKSBdCIZ9iPXJQ70It
	 TeXs4MfXcFcBPY2FXPZpffNZTyZ4y1EjESuCCEkmUwrt94FEu1C+v0cIe2pON+hswghHs
	 7b2ynQsFoA/AqE/6t+2tdM7TMIIprz7QZ68uQvM2tO1H4z9LbJHI3RqfAIrY1uZq2VTWl
	 EVdkYr2GNe0N9Gimf5874MDJ7iS8mv/ZSsD5kH9pCltCNGImXc8PZtQMrD42KGgSHLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=izRxgdwI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="H/1z8zyP";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E00606A33B
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E00606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=izRxgdwI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H/1z8zyP
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68TN52629335
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lGmW88CnQl9hiGYpiWfwaSM6
	NmzBZwZKuT4WR9HAtaY=; b=izRxgdwIaLNM3iHxISVTA7KguTx+kGEdEBtikRrK
	MhyFqFTUXmuohngSfhyjMQRqLV3C2Ov5posISQWNN5zezJZZL9hIGuIvVOROcp0l
	zbEfCI6lbThcjsG7ynObKk+W8dQiTQBCvMALhZkDTeD1hfv3VmbsehFvfmxY+b3Q
	l5zCWmHk2e+sjRBgXwvkQprmuFSpW2AF2TBjYqVLjrZajzE08FdFxardJOgfOOAu
	IGYFJjRZy6fnKC8qq9RU73BEPpDFgfeXq7PKqxHFE8VFVdnkkBD7JeGKcyZUth0C
	NcH3hNd7H9xDXPM9enm1j9DmL49pTBpjt6nDiPyB+/9ifQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydbdf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 09:24:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso5039162a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 01:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795598663; x=1796203463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGmW88CnQl9hiGYpiWfwaSM6NmzBZwZKuT4WR9HAtaY=;
        b=H/1z8zyPwKf19jB4zZimqLWeS7jZx/NBhViUyj0b/kkF6tjxH5COr/MCH6AEGtBSs3
         xm/RirvVu2Dx2+Ahvk1mCR2WTkga1gL3KrQvcIWOhCldM/pZQ9+0jW2rxXnmxA7jbL7S
         rC/trXX3BsR48xSUYrhDhg9ORVKVDEgOCtj83FnvGD1txO7Zwo4ovNIBe7/6laEBkeiU
         LnUe8iXM0Elc1hOwbwqkHQHCY1UPYeFc4KP5F9aRK+tfcRzwTWtfwWhHkrwbguqBA2aY
         RSAs8XZhAo2ffKhA51N8nucr/RBwLcFmF0eidKCZ3jJHzLM8T9A6fbmZbZ2Az7+JD7G4
         pnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598663; x=1796203463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGmW88CnQl9hiGYpiWfwaSM6NmzBZwZKuT4WR9HAtaY=;
        b=PihgdPY73kaDMkIAM8RodvRDo3/FAR+vRSIz7uAqTSRWhN43UC4dHZuTJvYdEUQ3PX
         8hyTKKTUbsyYMbF37kqo1xoL7hBxKeH4kbXKwRWsGMh1okSxNlbG5gF3LA0H9PVHQbFn
         r1Aq5igEHmpW2Gxu9bCR9sueUZGfUdBNvu/uvW/cxHxTJHM2elPzSXklB5svlQ28Gt8g
         H1O+aQVKxQPY6XhwzSNt2ffh97CT53sFKSi3LslaDibBO+guGMWW8GMfsYLqxN2Pzc5F
         mADTjucXkZ6kUh4vuSxsb3ky/sRF2TFmVuWLk9Kh3qTrYz0DaqUfiR6sFZRHs4LtZLTy
         oOiQ==
X-Forwarded-Encrypted: i=1; AL+hErGGL2UeWcujBvMS5dzuB05y0xiWINKntPaKz5eso2kiOtrRxwkjFPbgNG13EZpXxgHTypF/nHQITw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DSF8dVTgIKEIIgnyxMY76EH/TCnR7QiDrTAbUDIo6BhoAugfM
	6xwWDdMXVQrNjKhxYt35GvFh4Onu/UZHKOEYjL3EeCAQkjHyzvYeTO9MnpF98SnoNNQL/0Sd15U
	7+UOIfpEC4XDS+g9/PJm/ygrnCDWyjnfFIhEuCdpISfUCmXvo4R8pozl4kzpuIw==
X-Gm-Gg: AZFdTZceYFsv9n6LxQ0NeokU2HTphEekYJ52GBTu/+BsbqfaNgaVMjUb7TuYTPPaH32
	eDFgwssisgBSXHkrixFx7IxkhM6Jw25Jl2MhVbVtkSTIQqvCsAjFj7uCLtg+EywtAAIuutIViEs
	wV6dSWZxTdtLpeNDg71wafuBq+Hr6HC1El32zdkzQcuM2MlYc413bru13Ue7ITk7hIqjFhuSknV
	OiNj47kFdgRoxSuObRsKDolvyuBGtt0SDXHcVL0c7JGBniYkPY0Ci8UQd+bsh1CDPDuMTYu/SoT
	W+g1ke2gqa0ldSf7g+PdbIlGPOtb4E1UhQduq56rCLLHO+MubM4xWhxnh/UxQHAlP/hzbPQnpvz
	XK7HGqcDt9LpasrXXXaJILRJl4l0TR3m9qDTl9ZC82nLV+ujAJ0s6BCwXcNHtHPm2tcEMZq6yOs
	Y=
X-Received: by 2002:a17:90b:4a48:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b41c7b5fb3mr16297569a91.1.1795598662727;
        Wed, 25 Nov 2026 01:24:22 -0800 (PST)
X-Received: by 2002:a17:90b:4a48:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b41c7b5fb3mr16297542a91.1.1795598662124;
        Wed, 25 Nov 2026 01:24:22 -0800 (PST)
Received: from hu-raryan-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm27225013a91.2.2026.11.25.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:24:21 -0800 (PST)
Date: Wed, 25 Nov 2026 14:54:15 +0530
From: Raj Aryan <raj.aryan@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] arm64: qcom: Add SMBLite charger support for PM4125
Message-ID: <awapP5FP902jwSJ+@hu-raryan-hyd.qualcomm.com>
References: <20261124-smblite-charger-for-pm4125-v1-0-2132c9f0601f@oss.qualcomm.com>
 <8dd3d211-d5c9-4a8a-8b48-04de60922b22@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd3d211-d5c9-4a8a-8b48-04de60922b22@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfX0r8KqLhpM+WZ
 ne+o5NZHWMjQDIS0lyi+oKw83cLrzwipRFACBDd4fnVX51u6UONsQ8C0JsnpDvXe4FWaCFZCyDs
 eQysldFlkrMYc+SF26pq1YYnl4w68DY=
X-Proofpoint-ORIG-GUID: lwsWDD-bNnYAnWiLxr42cLrLLkOim3ll
X-Proofpoint-GUID: lwsWDD-bNnYAnWiLxr42cLrLLkOim3ll
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b06a947 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=kZJHlUTYguviTMVrfrAA:9 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNyBTYWx0ZWRfXxJCJnB7CAi/v
 wUU6dp0eKqMJcJo+jr/3YBFaVQAFDNiaSOc+BBQM2qruMssmwchHld/rZCBbbL4TjXNr015njyV
 jfsAjWg/e0ERm54zC+tEs0pNnsWG1uSjcWmID8QfTtxW1VTcjsIYtaou61iSNVhteF7cTWvzSrW
 QkNIUX7HTpmcFszSVS/bI/uGotHJ7UknbJrvjD0Jt2bcdpCUK9pKo0tOMYCynCUZmbrTbra7QpY
 2zYLCXA9tz96aW6YRQFRuBDoUDERereB6dfWG3ww/x7AMYjs8iAjMZGhrWWOyGw0HJmrC37j4Ab
 i14mgy9lXwYp4Wf8a7iN1oDN3zmRXNHB6AeuwtMrSYR6KP+D93HuV99Rzq8CphG17ISost1CQWk
 QwsiIqtmDu7ZL3SxOGsXHwdhcuMBt51/KjpjadW3H2735BXVj7OkduaS9hfKHttWYaYcjiOwwMu
 8fUzi0Nz+SZazwP0z9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250037

On Tue, Nov 24, 2026 at 10:48:02AM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2026 10:15, Raj Aryan wrote:
> > The PM4125 PMIC, used on the Qualcomm CQ2390 platform (cocos),
> > integrates the SMBLite switch-mode battery charger IP. The existing
> > qcom_smbx charger driver only supports the SMB2 charger IP found on
> > PMI8998 and PM660, so PM4125 currently has no charger support at
> > all.
> > 
> > SMBLite is a reduced-feature variant of SMB2: it shares the same
> > SPMI bus and overall driver model, but uses a different register base
> > layout (five separate SPMI peripheral bases instead of a single base
> > with fixed offsets), a different battery-overvoltage status
> > register, SOC-based recharge instead of VBAT-based recharge, and a
> > different JEITA configuration sequence.
> > 
> > This series extends the existing qcom_smbx driver to support both chip
> > types side by side, selecting the correct register bases and handling
> > logic based on chip->type. This keeps a single driver and power-supply
> > class device covering both SMB2 and SMBLite hardware.
> > 
> 
> Why do you have unexplained/unlinked dependencies here? Why dependencies
> in the first place. Does it mean this is not reviewable?
>

The dependencies added are for charger type detection, without that our
driver wont show proper charger type i.e SDP, CDP, DCP. I apologise,
I will remove the dependecny in V2 and mention about it in cover letter.
 
> Best regards,
> Krzysztof

Thanks & Regards
Raj Aryan
