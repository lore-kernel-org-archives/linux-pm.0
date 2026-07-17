Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843053E009B;
	Fri, 17 Jul 2026 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282458; cv=none; b=rqm9klqIyt5iOiI236eFtbN1x4jRlBOgOxgdqPOQ7nvcKzf1vJr9f+oaAQlIzCoEgbW4FtsezJIfE85PDbdllN6xEsSnwRLU4DI5MfNhCLpcMNPAcXopwCilfQ6HR3NaLS4HM7vgHIuaDv/uGXa2LennDXSTls1m+dMXO4dhSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282458; c=relaxed/simple;
	bh=gZsUIkVU96um2kqgF9GYSTdgYrEAat04u0kjNFHQ3e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eneZ6qlZ0rwFhrtFTrfce574esgGQdKhU//EwnHtFt/Y2Mlyebr/2CX8z8Tl+Id3L0dpGOp1sCZ6+P+GB3h3CYo5ffoQQHjBIGNTAjP80+E/cDksPn0rg9FNqWczImDooGHNA206Lbt/vaPKzENOdsXKOsfV1TK+S0yipeS7D2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bCHcQhIi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bCHcQhIi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cGPQ1160823;
	Fri, 17 Jul 2026 10:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+eL3nFIY3R6gVNIPPVVY9WpuRu+0hVCpEVEi3f5fFb8=; b=bCHcQhIi2Ps8G9qY
	VYEz7hKVeTqwYsnFbPjcG3qZw/xOyNVC6HFrXS+bT7OSblkEvRBxoHoz1ztH/Ndy
	GFB8qAt6BvcOydN8+FjQpu3oPC8Z8eLNjodEMnF12rjFkKkvudHFf6VOlrQdg7ze
	TxjeW3hAeSbljgIvdXZdX6hQb+Y+LF4vhAJqeAsbNClY9N8lP/3VC937JlHzo26Q
	xgZDj0LnlyUl33gdn48QSfJxKApXVKJAdNYTLmHbEq7/ajSc6KCrk+gRkC6kovCG
	nC4ZQbNmFycJCsvUYZpKikUCXpgVEGgfWpmvQslIz/JDRnMrsfdT7k3/19HeHxti
	37YFAw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3as8et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:00:54 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HA0pFs031334;
	Fri, 17 Jul 2026 10:00:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fbewm48ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:00:51 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66HA0p4e031329;
	Fri, 17 Jul 2026 10:00:51 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66HA0o8A031326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 10:00:51 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 114D9B3C; Fri, 17 Jul 2026 15:30:50 +0530 (+0530)
Date: Fri, 17 Jul 2026 15:30:50 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jishnu.prakash@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
Message-ID: <20260717100050.d2qz6inztjvt33tr@hu-kotarake-hyd.qualcomm.com>
References: <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
 <ag-NLvh4ROgTCs_L@baldur>
 <d4001407-cdb0-48ee-a138-87c94b5dab01@oss.qualcomm.com>
 <20260702111737.2qtjcfskulav4usd@hu-kotarake-hyd.qualcomm.com>
 <5d5c693b-bd07-40a4-aea5-d9e1884aac50@kernel.org>
 <20260703091319.5kcsqjtx4e4rshsy@hu-kotarake-hyd.qualcomm.com>
 <7c7ab43f-45c0-48bc-921a-8820408c88c9@kernel.org>
 <20260716084850.gssw67izy6vq36tg@hu-kotarake-hyd.qualcomm.com>
 <alltBcYWULOv7nEv@baldur>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alltBcYWULOv7nEv@baldur>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5OSBTYWx0ZWRfX3zuHEgyZK6px
 xa4gAd2syzdgwX8xgRgkrNPtzdyyEoJJN5Rpbcr5f6L3EUZNsyfzYmjXr+q6sbA9XR0EjEVEfdz
 Eku3NmQY1R/uOY7azQOYevDqebxhKM4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5OSBTYWx0ZWRfX7ErkxNkLb/7j
 +44TeUyibAFlI9wVdKj2df7Sk4QVInHnLSBp84J2dn7emUggKcQODPcx3gYjcZD7OQuYgzPaTUh
 ErjhxIzZ65ayuvUm/ci/CbdlRTvbkhs1/p311AO8W2K4Ei2E60LRTXf7uwO7VcCobtKOt6H5Qmw
 QaxA2fX30sULRwqNEjutTKSIAP8Y0tQGX1Kc16EcI9cQVIukZmHkdLVsmoPLd/R43IMZ8Osn/Jk
 ElLEOceajmBhwDkM9DMqUJ/iEF05YK84gyTexiesycL0I5nwFhngTr4/mfeLTk0yxhQ1rQFBo+2
 PgRlOKgGbDlw/Vef7SKjw2/OD5tim3YlUL9rCgeBE86xrcYMMHR7XuOR10pCTeIZGsO+oKkUp30
 KCHRO+7LEQt0arbXI2oLPH24uYNgmMNixSZhHDXPP+xllVrqpiV8lsdvqwI3eCJjE2WetF2f7th
 EJ4otmFVdHskOgBXnMw==
X-Proofpoint-GUID: B69tYyDa0j5hvZRHHOkY6puiv__ocesf
X-Proofpoint-ORIG-GUID: B69tYyDa0j5hvZRHHOkY6puiv__ocesf
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a59fd57 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=8a1B6c_OcX364HWwAgMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170099

On Thu, Jul 16, 2026 at 06:54:36PM -0500, Bjorn Andersson wrote:
> On Thu, Jul 16, 2026 at 02:18:50PM +0530, Rakesh Kota wrote:
> > On Fri, Jul 03, 2026 at 11:16:59AM +0200, Krzysztof Kozlowski wrote:
> > > On 03/07/2026 11:13, Rakesh Kota wrote:
> > > > On Thu, Jul 02, 2026 at 01:28:35PM +0200, Krzysztof Kozlowski wrote:
> > > >> On 02/07/2026 13:17, Rakesh Kota wrote:
> > > >>> On Tue, Jun 30, 2026 at 04:16:13PM +0200, Konrad Dybcio wrote:
> > > >>>> On 5/22/26 12:56 AM, Bjorn Andersson wrote:
> > > >>>>> On Tue, May 19, 2026 at 12:29:38PM +0530, Rakesh Kota wrote:
> > > >>>>>> On Mon, May 18, 2026 at 04:36:32PM +0200, Konrad Dybcio wrote:
> > > >>>>>>> On 5/18/26 3:49 PM, Rakesh Kota wrote:
> > > >>>>>>>> On batteryless boards powered by 12V DC adapters, registering the
> > > >>>>>>>> power supply as BATTERY causes userspace to incorrectly trigger
> > > >>>>>>>> battery power-saving sequences.
> > > >>>>>>>
> > > >>>>>>> Does battman really offer no way of differentiating whether a battery
> > > >>>>>>> is *actually* present in such cases?
> > > >>>>>>>
> > > >>>>>>> What boards are affected?
> > > >>>>>>>
> > > >>>>>> Currently, batteryless support is only implemented for the
> > > >>>>>> qcs6490-rb3gen2(Kodiak) board.
> > > >>>>>>
> > > >>>>>
> > > >>>>> What do you mean?
> > > >>>>>
> > > >>>>> Are you saying that the pmic_glink firmware in Kodiak has a one-off hack
> > > >>>>> that no other implementation of this firmware has?
> > > >>>>>
> > > >>>>> My Lenovo IdeaCentre (hamoa) doesn't have battery, what should I do now?
> > > >>>>
> > > >>>> I was going through my inbox.
> > > >>>> This remains unanswered, and I don't see the discussion progressing
> > > >>>> without resolving this.
> > > >>>>
> > > >>> To clarify — there is no platform-side hack involved. The Kodiak board
> > > >>> has a batteryless variant, but the pmic_glink firmware provides no way
> > > >>> to distinguish whether a battery is physically present or not. Since
> > > >>> this can't be determined from firmware, we introduced a DT-based
> > > >>> property to describe the hardware configuration explicitly.
> > > >>>
> > > >>> This is not Kodiak-specific — any batteryless board, including hamoa,
> > > >>> can use the same DT property to avoid incorrect BATTERY registration
> > > >>
> > > >> Unfortunately the answer might be: fix your firmware. Since your
> > > >> firmware is the interface and we do not expose battery in DT, then you
> > > >> do not get additional properties. You made conscious design choice of
> > > >> abstracting some things in the firmware, so you do control that part of
> > > >> the software stack. If you make one choice, it might lead to other, like
> > > >> rejecting such properties.
> > > >>
> > > > 
> > > > This is a hardware limitation — both the debug board and batteryless
> > > > platform use the same Batt_ID resistor (10K), so the firmware has no way
> > > > to distinguish between the two at runtime. There is nothing to fix on
> > > > the firmware side.
> > > > 
> > > > Given this, would a new compatible string (e.g.,qcom,pmic-glink-batteryless)
> > > > be preferred over a DT property, or do you have another suggestion?
> > > 
> > > Debug board is not a end device, thus you basically have only one real
> > > use case: battery less. Treat everything that.
> > 
> > 
> > can we have 2 supplies added - (fake) battery and mains?  if we detect 10K bat id?
> > since mobile/production platforms share the same firmware and driver code,
> > the debug board still requires a fake battery registration to keep the common
> > code path functional. In that scenario, should we register both the main power
> > supply (DC adapter) and a fake battery, so the shared code continues to work
> > correctly without requiring platform-specific divergence?
> > 
> 
> My Hamoa-based PC (desktop) currently reports: ac, battery, usb, and
> wireless. I would expect that it reports on AC (or no battmgr
> interfaces?).
> 
> If I understand what you're saying, the pmic-glink firmware is generic
> across all Hamoa targets, so there is no configuration in that firmware
> to differentiate between this and a laptop usecase?
> 
> Similarly, my Hamoa laptop doesn't have wireless charging, but you're
> saying the pmic-glink firmware doesn't know about this - it just don't
> get any input power on those pins?
> 
> 
> I think this is similar to if we had a discrete charger block that we
> describe in DeviceTree, we would somehow have to describe the
> "configuration" of that component.
> 
> But I don't think you considered those other use cases. Perhaps this
> should be an optional qcom,battmgr-interfaces = "ac", "usb" ...; taking
> the list of interfaces that is actually implemented.
>
Thank you for the suggestion, Bjorn!

Yes, qcom,battmgr-interfaces = "ac", "usb"; sounds like the right
approach — it cleanly covers all use cases.

@Krzysztof Kozlowski, could you please share your thoughts on this direction? Would
you be okay with adding this as an optional DT property?

regards
Rakesh Kota

> Regards,
> Bjorn
> 
