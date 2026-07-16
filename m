Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF63F44D0;
	Thu, 16 Jul 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191751; cv=none; b=ILe9RIngrU8i0miFgyc/5x+hUnNZoWJv8Pwbl+xeAjAjaOF7SU42OIvJAy7pWuTCckApYaTLVYKvtjPa86DmC6GSNPn1vug10BB7SNum25SkP0F3oyd6QuhhaUQ9hL0R0vpmMt/lNYvNpsgnztEnxrIJB3uol6A6SOM93l6Sc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191751; c=relaxed/simple;
	bh=m6BslHS9AkeIPGCcuenxT6x62TbkAXXDASKkOZjTqTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ4ie1GnL7mFxKGQPi7l/0ON7ttQPsvgXAuPPCjXHnFHcb+TUWg5LGCZF87Kwst1+xmrpUiy/eTk6eMiauMFnSkJZdh3qaQK5lTW3rlBLKUVdzYArJiFGSdL5m3lYhZlMUD1JZ6xByj+DcFw7ayrxpPIP8sX3W4bqZTBEtbXTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PZr4nVDM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PZr4nVDM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7Daj32102894;
	Thu, 16 Jul 2026 08:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1uSTffUrsXnnBfE2kd9C6IQWI9GIGzh5vQU3QuV48sw=; b=PZr4nVDMX6gDVMjO
	+Zv0ONkmrLVF43xh918qFb9JuXIYtmIrG5T1cHUz8ZT9bNZ9CW/VwCOmwkP+xphg
	hibC1YXwlrlL9vpCRQvDB+BYC/vhFDEt5LkUxfF/TMSCB1Mwt0K5lbuQ+fxeKAzv
	RquJqa2kuV6xG6o97+EV+zQjsZhr+RVAAw5WoX8LTSETQ26m363n9edq3jh/EhfG
	q2Ct0qKgsEaHJ3fTXKAmzrhKZRj4u5a1/gyKgQGSBEVfeLmot4XCECl24uDQpO9t
	FVnWnaIybRtH8ZSfoJ0kSFQr58p6vTpazOErqFUn+B6yz6BoMeY3jubguilwvXbt
	Nh2TmQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4w9ghp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 08:48:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G8mprK019775;
	Thu, 16 Jul 2026 08:48:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fbewkm89m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 08:48:51 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G8mprU019770;
	Thu, 16 Jul 2026 08:48:51 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66G8mpKZ019769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 08:48:51 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id AC64EB3B; Thu, 16 Jul 2026 14:18:50 +0530 (+0530)
Date: Thu, 16 Jul 2026 14:18:50 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jishnu.prakash@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
Message-ID: <20260716084850.gssw67izy6vq36tg@hu-kotarake-hyd.qualcomm.com>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
 <ag-NLvh4ROgTCs_L@baldur>
 <d4001407-cdb0-48ee-a138-87c94b5dab01@oss.qualcomm.com>
 <20260702111737.2qtjcfskulav4usd@hu-kotarake-hyd.qualcomm.com>
 <5d5c693b-bd07-40a4-aea5-d9e1884aac50@kernel.org>
 <20260703091319.5kcsqjtx4e4rshsy@hu-kotarake-hyd.qualcomm.com>
 <7c7ab43f-45c0-48bc-921a-8820408c88c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c7ab43f-45c0-48bc-921a-8820408c88c9@kernel.org>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a589af8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=7qTSlFZtBWy26nmShzkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vcgZI8-jRVhptBeUlk-djmSesuI7oyKC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MCBTYWx0ZWRfX3AXmK3kk3z38
 u7OH0oDsy4mLyPUlFW8du4vz004C8VCoXaVU9/2GSfOVY3feOCZ0od1ZFfCPa5HLGDftvUq8iVF
 lcWiVoOJ0sTfY7tte71ciSJZ3RZckXA=
X-Proofpoint-ORIG-GUID: vcgZI8-jRVhptBeUlk-djmSesuI7oyKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MCBTYWx0ZWRfXwFMvR6Dk0ync
 RdQdOGDuPVHoUyEPO6hxOyD99GBhFVykTCkU93kfwAwfw+2TV6YADyHMGQlgmcgsFV1oK5Xva2M
 0J1TpoeeNv+rQ36DcswmF5E16TSAc+dIyyzsmrgSLBzJV0kSFA1S0EzhdQKVSpV7LDWBsEx9Ecu
 SLvvLFIL1pAdgcFMxNnLzvTDHRAUiccWVfxxmSGq3hy6d2lvBvKWrckY4mN82/je3EG5ThInuqz
 eaB1bviCPBkIIuKtB/ulHQTiEqob7MldRwXE38Zy58w+TcieVo6EDP8W8K5bQQwzk5rYzHivWZt
 l4yIs+wc1tHYmiOD/48s17zdtdHwEsN788RMXwu/zsyckpoge/FhTHvKxpMiz+pYxu3PNPrHcz/
 b76DqTQIQXPeWaYtzcUYbC4IA4OojMcMnm3IYcRVLLGWm4ZwjrUqffoA0dfHJWimjNvxPiJLTzg
 O2vpO7zHnAg4LE729wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160090

On Fri, Jul 03, 2026 at 11:16:59AM +0200, Krzysztof Kozlowski wrote:
> On 03/07/2026 11:13, Rakesh Kota wrote:
> > On Thu, Jul 02, 2026 at 01:28:35PM +0200, Krzysztof Kozlowski wrote:
> >> On 02/07/2026 13:17, Rakesh Kota wrote:
> >>> On Tue, Jun 30, 2026 at 04:16:13PM +0200, Konrad Dybcio wrote:
> >>>> On 5/22/26 12:56 AM, Bjorn Andersson wrote:
> >>>>> On Tue, May 19, 2026 at 12:29:38PM +0530, Rakesh Kota wrote:
> >>>>>> On Mon, May 18, 2026 at 04:36:32PM +0200, Konrad Dybcio wrote:
> >>>>>>> On 5/18/26 3:49 PM, Rakesh Kota wrote:
> >>>>>>>> On batteryless boards powered by 12V DC adapters, registering the
> >>>>>>>> power supply as BATTERY causes userspace to incorrectly trigger
> >>>>>>>> battery power-saving sequences.
> >>>>>>>
> >>>>>>> Does battman really offer no way of differentiating whether a battery
> >>>>>>> is *actually* present in such cases?
> >>>>>>>
> >>>>>>> What boards are affected?
> >>>>>>>
> >>>>>> Currently, batteryless support is only implemented for the
> >>>>>> qcs6490-rb3gen2(Kodiak) board.
> >>>>>>
> >>>>>
> >>>>> What do you mean?
> >>>>>
> >>>>> Are you saying that the pmic_glink firmware in Kodiak has a one-off hack
> >>>>> that no other implementation of this firmware has?
> >>>>>
> >>>>> My Lenovo IdeaCentre (hamoa) doesn't have battery, what should I do now?
> >>>>
> >>>> I was going through my inbox.
> >>>> This remains unanswered, and I don't see the discussion progressing
> >>>> without resolving this.
> >>>>
> >>> To clarify — there is no platform-side hack involved. The Kodiak board
> >>> has a batteryless variant, but the pmic_glink firmware provides no way
> >>> to distinguish whether a battery is physically present or not. Since
> >>> this can't be determined from firmware, we introduced a DT-based
> >>> property to describe the hardware configuration explicitly.
> >>>
> >>> This is not Kodiak-specific — any batteryless board, including hamoa,
> >>> can use the same DT property to avoid incorrect BATTERY registration
> >>
> >> Unfortunately the answer might be: fix your firmware. Since your
> >> firmware is the interface and we do not expose battery in DT, then you
> >> do not get additional properties. You made conscious design choice of
> >> abstracting some things in the firmware, so you do control that part of
> >> the software stack. If you make one choice, it might lead to other, like
> >> rejecting such properties.
> >>
> > 
> > This is a hardware limitation — both the debug board and batteryless
> > platform use the same Batt_ID resistor (10K), so the firmware has no way
> > to distinguish between the two at runtime. There is nothing to fix on
> > the firmware side.
> > 
> > Given this, would a new compatible string (e.g.,qcom,pmic-glink-batteryless)
> > be preferred over a DT property, or do you have another suggestion?
> 
> Debug board is not a end device, thus you basically have only one real
> use case: battery less. Treat everything that.


can we have 2 supplies added - (fake) battery and mains?  if we detect 10K bat id?
since mobile/production platforms share the same firmware and driver code,
the debug board still requires a fake battery registration to keep the common
code path functional. In that scenario, should we register both the main power
supply (DC adapter) and a fake battery, so the shared code continues to work
correctly without requiring platform-specific divergence?

regards
Rakesh Kota
