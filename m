Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2E43934D;
	Thu, 30 Jul 2026 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419067; cv=none; b=TS8PTVSrlcs0LHwS2VA6WSQEko0zlAVm9G0gdbuv2bApMHT/Trd0cC4EhpOAkyOgESFeEohigMAcqGswytKnYiv4qVM6q2YRLYk24M8MwqIyp0B5cgh4SLzG2M1u7s6SAoPrSiIqbhzP6aCgxnZgnf8AVuJ2gvo5Dd6MrNeNHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419067; c=relaxed/simple;
	bh=bQg1CV/cl1NwBFdpNzutcN/vhqRlpTzWwz93LULblz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moi8BmABMbJyz34gAssTcU66HVHxDdoqmy8Pj8XNbwwDOEb51IKGIPQoSnBjvHvrvfRAzb196pjQFB6hd3gh7nHzkDdQckPH1F2Tu49Lm9Y2g9PUQMnYDwCJijpoV6sN7zb55/4iCrk3cSsXsHq98ys4C8FTdckQIuWvrnj5bHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2v2VppS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2v2VppS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDDIBX841981;
	Thu, 30 Jul 2026 13:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wiSak0RHAiRJ/jqz8HoC55zt
	gtTNeufco1hRS6lvUMU=; b=W2v2VppSnmkhvlbuXD2oMOHbO9pX4qSPRdF3roxv
	PKRG06I+o9HatTEQXhzZOgzjlTktt1G/uQJtJymhetJZIwE60xe3ZfGAxs5rEl8a
	+z5eL43HW8pnDBUaeBiSbNNWzfRgnd4bfJq13/Lg86IICeZrjdNILqlkKMIHJdgl
	WCdAT1gIDR9xZsM7bRd0rB34WhZ8kmE3nmr2Sxzoyca+RTDevWtL0Gk/qgMzEFW3
	xlN4a8EGP2ClIegvje3ykgyXdwDg/TWnn4ssv3ZLZq2khtNfq7oLbmBHQze0GGOD
	Ndz8dj8gzmizqChrXXtGfoWvij6Epg+wskxz2fjtkXNU+Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6wmg8pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:44:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDiKxr026768;
	Thu, 30 Jul 2026 13:44:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fmp7k6bf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:44:20 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66UDiKw1026757;
	Thu, 30 Jul 2026 13:44:20 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66UDiKOx026755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:44:20 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 83BA1B31; Thu, 30 Jul 2026 19:14:19 +0530 (+0530)
Date: Thu, 30 Jul 2026 19:14:19 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jishnu.prakash@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
Message-ID: <20260730134419.tq2nxrp3n5ghx3xe@hu-kotarake-hyd.qualcomm.com>
References: <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
 <ag-NLvh4ROgTCs_L@baldur>
 <d4001407-cdb0-48ee-a138-87c94b5dab01@oss.qualcomm.com>
 <20260702111737.2qtjcfskulav4usd@hu-kotarake-hyd.qualcomm.com>
 <5d5c693b-bd07-40a4-aea5-d9e1884aac50@kernel.org>
 <20260703091319.5kcsqjtx4e4rshsy@hu-kotarake-hyd.qualcomm.com>
 <7c7ab43f-45c0-48bc-921a-8820408c88c9@kernel.org>
 <20260716084850.gssw67izy6vq36tg@hu-kotarake-hyd.qualcomm.com>
 <alltBcYWULOv7nEv@baldur>
 <aimahyy7gnnw44pdedtt5xovq7nqw236fb6hwsm2fqjzagmcm2@7767eiubcdz2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimahyy7gnnw44pdedtt5xovq7nqw236fb6hwsm2fqjzagmcm2@7767eiubcdz2>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNCBTYWx0ZWRfXy8OO4ovosz/W
 5U45TVSQQWqbJfoRhB2huhFb3ng5/MySnz8nYqPeu6AV+vNRa5xqNfVgTphNPtikuHmo4yVCenS
 +IybENQxUu8ixQBW5srfuBsYgtKaOvs=
X-Proofpoint-GUID: Ts-kM3T11W3z5ajMe3shi_F8hvk-e-Sn
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a6b5538 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=oBn097-8SNn81nznA08A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Ts-kM3T11W3z5ajMe3shi_F8hvk-e-Sn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNCBTYWx0ZWRfX6thqYOR1I9qP
 8aIqs3urLJw+fGZV8//iin4cBMlARSFnwlYYENJdam6M3t0n8T5MsvaDyOSjcPmg9huDc56yjyL
 l59n0vFD8AL4WiyiLK6IxItEnJEjdRkE2hCc7woh1CGuqMmQDXkjpWF7AjLySLmkXDhrCdEgFLn
 AoF12m+tt2rhSAJtgniE3diaOQqarr573BqtzWHB3BQV9R27IPg9bSfZb8jboz9QOAOW+TF4Qdk
 xyatJz608rksRe9N/Xn5DN6lVVMMImzcOr7mUI8djVEQ+NKk1qm02abVT6lPqvQCMo6ebTtpUDe
 cDtFgP9XZI4LXThmJfghDt/cNKgXOJbU59w6aKGnb5PozRVgYjLoBvB5MAkHQo/gKlp9zGwek/5
 CJs845bLVasfUG+NFaH8MI2oD/p7usIYbYRyYNfXxuVml5Ma3bneVsl3Wzvie8Y65h2wS+rOKdo
 yEaPSr2rPt2T6aaxqgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300104

On Wed, Jul 22, 2026 at 05:04:00PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 16, 2026 at 06:54:36PM -0500, Bjorn Andersson wrote:
> > On Thu, Jul 16, 2026 at 02:18:50PM +0530, Rakesh Kota wrote:
> > 
> > I think this is similar to if we had a discrete charger block that we
> > describe in DeviceTree, we would somehow have to describe the
> > "configuration" of that component.
> > 
> > But I don't think you considered those other use cases. Perhaps this
> > should be an optional qcom,battmgr-interfaces = "ac", "usb" ...; taking
> > the list of interfaces that is actually implemented.
> 
> I like this idea.
>

Thanks, Dmitry and Bjorn.

Krzysztof, could you please share your suggestion on adding this as a
new optional DT property (qcom,battmgr-interfaces = "ac", "usb",...;)
listing the interfaces actually implemented on a given platform?

regards
Rakesh Kota

> -- 
> With best wishes
> Dmitry
