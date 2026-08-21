Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C503559C9
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282696; cv=none; b=OCbzgVRwWhenMKknEm3oLuHIgYfzWTkCALe5rFu480vdAZKL46FiAbGIDwCPO8MvRsuW2ljI/JtwAcrvb4yFA352oB4MZiZKIwNpmteIWPbQLXCdh+bPv8ZU2Jhv+u8bwV8c8SXXsidDeIh7TVnnegPqVxTAWT1Stl5sGmHf+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282696; c=relaxed/simple;
	bh=r/+VpJ85Yz70wWRxT5yl6As9ddZBD9nhzoahm+SFZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPXldo1EECUTaz6Iz0kHmJ0uTuNRCL2Xgw/Rr/S4X9DUvD+BWdIrjDCHEI7weCaDM6+Zt6UF0RmKhm8mAWmzA/cWH8FU3ckVe5471GTVtEebMryYIT4Uy8Kb8aLF/u6N6koITypHPxl7jmK8e/VDIQWQLErIhuP0MYQDqtTLPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=md/KYDa0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HIv8GtJ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="md/KYDa0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIv8GtJ7"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L21YD11024112
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SlIkn/kUR+9KoU2/9RIyh2hg
	yJrbFpNU877EzuaIyr8=; b=md/KYDa0qD4cvRqRYnTNM2muFiVqfmFH2z+0+YAM
	ok9vtvBEKPVUDwRWGAO6qiYn9mbuFNTP8dYCv4w9DZvawNWVU4XZ+cStkRugQnZw
	/PhGBzeD2imvfQLEKi+MqMeBG7Pg/g7CuArF5RWVhz95Kze7WxYDiL1HUdEZpUVw
	kaAXXYDCrrmx8m8ABTVtYrfWr9kEZD9KHh06zYc+RRQmbIkX4R0FeFaE8uOz9ihw
	FIWY/4JahYOMeu/ISMxK0GQUGtDGz7FkrARJf0B7/7Av3mzXXQW8eF1KFExAWis7
	3GlAVlZX6E9Vhy6eivs2hJEZCXLydOwoPIrsAyYLF9oqRw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg1c1qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 03:24:53 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-744e7c36621so173063137.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787282693; x=1787887493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SlIkn/kUR+9KoU2/9RIyh2hgyJrbFpNU877EzuaIyr8=;
        b=HIv8GtJ7numVcjnuEag3LJyoq4qyvh3J8SKz3/xTcyzxeEf4aOrTGtff4xXgCE9kIS
         UkyNSTd2xx7AInJ73dzmU/TpYcConuVLJXjf58Tb83yWaQ0cFvfFbyK/DEEYFL033KXM
         sQAq+lXbmJzey5hbra5kd69qsiHTNDb1rNNW1iHMl9opkcKz12y/ecfCFZgs3Yy458Pf
         aOgU0PwiD8X8HxndYfhf0UsD7Gxbxx7hNpu+ZQkN6REpoeXxXbOUvuLaWaKqEPIkgS8q
         mgzuQdVIvT090qMNvqvgm7fRFGOzubnjF33aj29/uBA56nshkMZ0sDVTXOmXrJruXSiX
         i1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282693; x=1787887493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SlIkn/kUR+9KoU2/9RIyh2hgyJrbFpNU877EzuaIyr8=;
        b=HsxGuSKTtJcGrjEmkimPiXz8auhS54N+PMqAn5A1NQKmxe5F/M37W7m4j0N6vk4M1A
         iD5XpbvDYHLPSnC9HfZ0Q36c20og9dw447yIqwpTgS5FamyFCM063Mzq4c5J3pxQ3/ZZ
         bU8bdmekgMqsf5hm5axC48OfVXMXKk908T+wL2H5wJYYmhvWvQ3IfOeSnrZEl9kpAlmK
         hJKkhTT6wW9ibG+B1gPL4DC/XcWeFSk+mh3cyZV6NUj2T67bc6kbi03dR2XZMQ43JHod
         GQX3WDTOJ6nj06WHeqWlUtf5tK3kv0KDBeckdafeQGZLc+aKdSei0IV1q/zks49LO5s5
         puMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrK7Vm76p7wRNGCzZy33NtEHuUamU7p2JRYNy2m99BJRqVYFnYhNY7T9bUrZUrb2pqSQP7TNS5nrw==@vger.kernel.org
X-Gm-Message-State: AFuF++nCJem8ZmgK/A8pOXQ8aLToAuptimBtB/t3GBWhtVZ9Pz8pLQFh
	OMREHMOtylWHyxYxNhwEqu7T/0pUf0RskLr3gLLAslUfygtgNo008sEGpPywD+Gs383S/vHnXJQ
	Mr2IlhSo6KaY1VOGH9FivafRtt0Y7ej4AIYf01iju9rhOd+JIx2Q/1KNOnnXnEA==
X-Gm-Gg: AR+sD12eZTugvG6uaA/z8ABYlwHRRmON0/iqsEH6o36rteaL6UvMZIR64t4xEeNAprI
	ljcyB4KHcWPZMJphtlI5kGJl5MVOOPjGRub/qM59P2LQVFVw8/WAASPSjOjtMccgrFWgzN8T3aH
	P9JHGFXICdtjdXkZwvCPr9v1ZaM/T/ValGxMvC2gH4fiAap6SpM4GMcFrrwFfetqhq/J87XpG59
	lJ7n9o+x2Dy2FPSdgjAOHpfQRVEUy8xgs1KajcRwK39weRigbxamqd9yA6f097EmmhHIjgquc5b
	nVu7cv9GMsMNuYDmWvSs0kUvyWa9Wzygz2ivGPbUo6P0xmmAsz11TSrh49zJro8AbDvt/rEOFJo
	poCUAyI9Amt+huds=
X-Received: by 2002:a05:6102:580d:b0:779:dc0d:2b2d with SMTP id ada2fe7eead31-77a63642798mr1213006137.8.1787282692929;
        Thu, 20 Aug 2026 20:24:52 -0700 (PDT)
X-Received: by 2002:a05:6102:580d:b0:779:dc0d:2b2d with SMTP id ada2fe7eead31-77a63642798mr1212984137.8.1787282692340;
        Thu, 20 Aug 2026 20:24:52 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9e2esm4138134a12.5.2026.08.20.20.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:24:50 -0700 (PDT)
Date: Fri, 21 Aug 2026 06:24:48 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Subject: Re: [RFC PATCH 3/3] cpuidle: psci: Initialize the PM domains in
 powered off state for OSI
Message-ID: <3s2qeh2teckoalwqaekcs6zk4bpsrdi5ackkn5uu4qyygvawmu@k3lvlpm4fipg>
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
 <20260819151457.256959-4-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819151457.256959-4-ulf.hansson@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: lHIIkiGM31PFEXTANRCxM0wKjlBr6Nbc
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a87c505 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=elYLTxGRisG19N56oD0A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: lHIIkiGM31PFEXTANRCxM0wKjlBr6Nbc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAyMiBTYWx0ZWRfX14PKd/HeIdh0
 oWxDljVTWixmycYAzaLF19wKTaZy6inT6fSAE6AoIhRrfV2cxGQxK4WYIndTGykllCa68Adv+rK
 rwVMaXZITldNmfgzz9qBjK40pQNO3Bs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAyMiBTYWx0ZWRfX87OAaoIJ0RGU
 iWdJIdKyVUyc+WOBldlBbXsRbh0k80QOt6ekwB62kkmjdcPmdo/gRGZkK6gmHvAbx64WAv/lcFs
 g9fZ5Q3HGUavboAAMn7VOaQTTafd88d3aqtlaTjsJ1kq1ULFyDvqgqPv0Gk7rhgEm22R0/tzfOR
 dCgwv0Zs7rq7fNqXeD4KujTQvg10cVis+X9xYbdlboWURBlAUKPJpeFBk6+gRfjlf72MY0XzPpK
 bPuxIu30+q1hqA80t8oYwZFOiBWBWK9nYtmTnMapkWsnDP+xF8jrM/K6dronjo96foOPwEqMf/H
 NACN07Px8cvp5XgxQ1pMgPnvBv0LqEzzkWFAKsjy94WDVR4R8q9YgTPnTK9LBbcDVqqYhoe6n6Z
 emLWYh95RFZgabqssjbWPMMugpPgE5txHd3AMUE+DZWv9LkSjQXBVkuRMuv6MiFBQFiDzp51aid
 SK0TDIkndQQjDrtJjrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210022

On 26-08-19 17:14:53, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> At the point when the PM domain and the topology are registered through the
> genpd subsystem, it's not really known whether corresponding CPUs are
> online and thus if the PM domain should be initialized as powered on or
> not. Instead this information becomes available when the CPU devices gets
> attached to their respective PM domain through dt_idle_attach_cpu().
> 
> This is a problem when using PSCI OS-initiated mode, as we may end up with
> a PM domain that has the genpd's status indicating it to be powered on,
> while it in fact may not be the case. In the less severe scenario, this
> leads to selecting a shallower domain idle state for the PM domain than
> necessary. A more critical problem is when a non-CPU device shares the PM
> domain, leading to their corresponding drivers not being able to trust the
> status of it.

Exactly why a third state like GENPD_STATE_UNKNOWN would be more
fitting, IMO. Maybe something we can do at some point.

This solution works for now as well.

> 
> Let's fix these problems by initializing the state for the genpd's to be
> powered off and in the deepest possible domain idle state, when using
> OS-initiated mode. The support for ->sync_state() is maintained by setting
> the GENPD_FLAG_OFF_STAY_ON for the genpds in question.
> 
> Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
