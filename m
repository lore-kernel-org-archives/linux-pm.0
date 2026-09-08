Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F43955FA
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851539; cv=none; b=Pi0gWJwL2XmYzuzGfBTmOPFgj6eK3WIIFGbwwZVu+A4AcmiqZappaiWsPMu7r/Y9YOjhP0u9oSOQLnPa9fbj6dqwlw2TWM8OatPomPCwHoUsEUQWgi445p5+/OhBn2GOMnFcSlUYh7A10nN7Zhi8wVge7Mzb9BYCGP56hREU17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851539; c=relaxed/simple;
	bh=gtxbTgbppj34ZTU+D+eqsM2L4hzAP6mpVxsCSxwIZKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8PZLjAt3xl0OOHiU7WmA7uJu/H5OwBs3MNoLLryPQF/aJQR14aZEuWT6SnJevt9RWLv5t0I1s0CVuTENPQzAyta9IFaUbizndWAhdRad8+Az0IPdaoAXwWf0ej55amcWQPJ3cOhtfXyruSYFsl4pRNP1mqlRz2boWdQQuzsI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XECS56H+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RviU+lGb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XECS56H+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RviU+lGb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886M3PM2072861
	for <linux-pm@vger.kernel.org>; Tue, 8 Sep 2026 07:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=E3zkujL65pMjgKLSlU6wYiUK
	MwvIEv4ajalF5jOdh9c=; b=XECS56H+EXYswaZG73P3GQ+f3tNMZUd71/x+iQ42
	ZfGE9lPVXBcTey5Rwf9Lz5PJfVmkncqWYnaaN/zyz+RkxBLUGorWb11ddV5cH764
	p+kRgmyrjg9VDjDded58M4jS6Zgg0iXs4SEDqEeJazAybOW+4zIIfuHqviOy2gse
	OHSqRt1CguJ/8+rFhdDA/4xH9d7tulGMnQXoB00KbISaRMbtOE/53kTsfPwwwV5y
	o7YqWV+U+nt12AkNWXZA5A+yqO/PVGZ8mHGJBu3jFT1eNlxURFm9ri1OTLyVuhLb
	pijHsUUwi2c+OLh1R+cysQ+o95+KxRI7L3RmU63MbcHupQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfym96k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 07:12:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939c30aa9a0so13499885a.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 00:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788851535; x=1789456335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3zkujL65pMjgKLSlU6wYiUKMwvIEv4ajalF5jOdh9c=;
        b=RviU+lGbjc31gqppG+/OqUHHXtourLwg5+ShdMqK0iT9Ot4T3lykUZif/sMWfWB3mT
         druuV/wSPUECzbgSFnXCnCMoNHHIEeM1ypNGSv608T03+MbklnV+glktE4iYi93nrot5
         G6uylIa1Zk8cpJRoAJIbiKCJwluMKcw9PyGIyWuF49cbToujV4q9HfeWHWsLTD5LbH7z
         KqwAqJJWDesWw3xUT9I6YhHXRkeiHZ/YH+WgIEegb9sXRsQTHJ88qSEWU63S7kLfvkqv
         bVG7Ak9R+SZit9wvLMXH4jsOWGVBAvxg9Gw1BCTTSikEVbi1XtocmG55X3Aj62ZayN+V
         TQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851535; x=1789456335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3zkujL65pMjgKLSlU6wYiUKMwvIEv4ajalF5jOdh9c=;
        b=BM8xDp/cXIr1WiTRxiEMKf4pkey0cqWJZlce0E5sDpiIj23btaNOMoxH2c4IeE/ZF9
         AaMePTBctq/KvH88oiaO57x1BtRj4UWpouo0/ThJy96P5z7VIcTnfh0JlEmlz+U4YrXC
         RP9Wk5HcIh61NdsT8F862ju/PpFfrZL9l1jMi0RXo+yppgSKoUU06VS/0wm/Cz+6r/N+
         fsGU8GHQ5BvYTwkzWfKVvGaii9bGcn2nIctSonrk4oORTaL0TuOANJIqBiJAXhqkQ/bc
         oWRsoVjajnbpFEkENhRO/uuYGSN3shoFkwoiSaOjSddUYoWDHFCf0NNLtSFOk2HEG9+o
         dSNA==
X-Forwarded-Encrypted: i=1; AKwUvBxSUjMNARAN0lY9QSd7o9290zRkXqiQaFlb4O4q4Aq+MvbmdCJhZg040baGqF0eDE7WOICxaOpxoA==@vger.kernel.org
X-Gm-Message-State: AFuF++mMgIlnJsdrBSJKCk/HROsSq3nMUqPSOQKfOvXsj/tE+DNhN1NJ
	eWjrk9+5XhQ0NpECAULNIcTMoz+OuubVsOARHNkcinhyZCwzVtMgBZwiFDlAzi0sqso3mUGaCEI
	ry1yEjFErpSWDbPyWi8mCOM5VXXHrgk/tAYOSvjA1Md8CzP/UuV2Y8DtkMbTnPw==
X-Gm-Gg: AYBFou3wRcsIKUleVPaOlQ036Euezgf1bCK+HlkPLq2W4ZBO6vm1wn8m+xk1mQl6RVn
	eXSgbCXCmA9PmEn9sH1LOSPNOkEtECD2BFq+fcdDKoI3V0FS702QXdaxq8R4XGxG2iLRhcH3ZC9
	syiiBYDlPxoVx4JtJFfQq1Je0SkgEiQ0sHZhEQftwbh594/nPVIUOaFhk92G+8qCMsHKK4ir7KF
	TaeKvfj9Ymsu0uLLYxhczvAh4RzwOcgEfUMd34lYM+cuTPDrpwSSSAE8OPo7nFtoFJq91dCVqSp
	ZZGa5jm/1l1mZhxtcjA53vRmWJHEIUlX1qDdYRgPAwNZoPUwoBXqD7b8/t4WmOn3yrRA62HsE89
	0s75zqaQ4qWc=
X-Received: by 2002:a05:620a:414d:b0:939:5c30:fcb8 with SMTP id af79cd13be357-939803ae0f5mr2973020785a.6.1788851535405;
        Tue, 08 Sep 2026 00:12:15 -0700 (PDT)
X-Received: by 2002:a05:620a:414d:b0:939:5c30:fcb8 with SMTP id af79cd13be357-939803ae0f5mr2973015885a.6.1788851534813;
        Tue, 08 Sep 2026 00:12:14 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bc74298sm30591012f8f.6.2026.09.08.00.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:12:13 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:12:12 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: renesas: r8a78000: Fix lockdep false positive
Message-ID: <cdtn7tdiuum5fzd7tt2idkrm4ioybmoqdlyqmh64ouyub6tkel@b3qmu7igqya2>
References: <86da16a61c58eb08419f7528237c124e519f0a72.1788791506.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86da16a61c58eb08419f7528237c124e519f0a72.1788791506.git.geert+renesas@glider.be>
X-Proofpoint-ORIG-GUID: _fLIF5iiTqdLMPjvWyZ5A5Ae5KvIv76S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX9vCoYKYUQ0+b
 NitPq+0L9uItNCK0U+EoB2xSuR2FO7w8bIyYZ/E6895CkMUY1owarlFdZ04FkpMej4J7MEalFXl
 KC0GWRX9iEy2038kPS5U2He030OBsDQ3TDXYOPHTY8cH8hyX5q726dqFmcJrUiLGWlg8jCVaMh/
 ytf4HJHwkuPqG7uWXdoI5mayAWZVqEL0Q54Io3a0RkBttBMRfdcL39Cx1KwIqwU0iHEZY9HU8HA
 PP1Cg3IXJjEm61VrMYR5Hff253NllsoI+aLuhA3qeM8smB5l1JJSCMQK2CotJDlxXbc8HNPHZ8F
 XednpeHJPYdYnREw4oAryoHIuWdPhDuC742diyzHX5k0gjgQu38tYEMJO/HRGEY3NkKRWBs/VQm
 SS0mgYoTp//Dch94ux3loNU7kKsUz7MxVJ6r2AUD76efiFc+mDydAcOF+HqBmGRmHpKduvTyR4e
 N6U/2rlq/nXu6sKNboQ==
X-Proofpoint-GUID: _fLIF5iiTqdLMPjvWyZ5A5Ae5KvIv76S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfXwJZKxOM1RzQL
 oKKiefav1Wh/zN+l3qcoxm5d/fvYu/K9rZK2mI2bcCa2VbRk3+DXVVGhEyJ1j1chNd/wf6tEhGs
 ngWdW+4ICOd5Ad8VzKgRaZOQQuefei0=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9fb550 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KcPQinvyHwY3qny0q90A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072

On 26-09-07 16:32:01, Geert Uytterhoeven wrote:
> Lockdep reports a possible circular locking dependency when attaching
> devices to an MDLC PM domain:
> 
>   - During creation of the singleton PM domain:
>       A. r8a78000_genpd_always_on_singleton() takes r8a78000_mdlc_lock,
>       B. pm_genpd_init() takes gpd_list_lock.
> 
>   - During attachment of devices to PM domains:
>       A. pm_genpd_add_device() takes gpd_list_lock,
>       B. r8a78000_mdlc_attach_dev() takes r8a78000_mdlc_lock.
> 
> As the former is done only once, before any devices are attached, such a
> AB-BA deadlock cannot really happen.  Fix this false positive by
> introducing a separate lock to protect the creation of the singleton
> domain.
> 
> Fixes: 89e6a71b35703f10 ("pmdomain: renesas: Add R-Car X5H MDLC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks OK to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
