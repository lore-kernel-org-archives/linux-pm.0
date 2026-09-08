Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C747A892
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861801; cv=none; b=F9+JyU2eu2x21Y3es9p35XA1/gMY2lqyB2Vo261ZOGd6ibSaYm4jSEasezFcoNeRRwk26nP7nLtYs9zaZGgAk/KhxZ66GjymUqKl2lKdw4LD3oH1hAFXAAwJ3RO2ttLfx7llbuhnjtDXKnqEGQBa+jMEamQ+R7FCuu1pbcMbBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861801; c=relaxed/simple;
	bh=gU3el5vBaKIowxWErPSf+Ml57LVgUfxjbCElgrhuRcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHyssHz8Dx0ihJt83JdN7OaavWGJAURHAvGMj8EuO6nJ825tui2fdoCdRPVblz281cuDdjD2Di5bhk6R+yJoF1Vmd4V9UkkKc5b9i3+vHpuw4MZzNgyTxZA2YwyrxVhjEF0I6ecGfIc68+du3Su/ibnFUH6hSXWzf/Ld4v1KAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0tFBxn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TGXnK+Xa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0tFBxn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGXnK+Xa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886M9ro1521661
	for <linux-pm@vger.kernel.org>; Tue, 8 Sep 2026 10:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rfmoRRos15ggGyuCj+3H9fL/
	SgvX7ZnyDI13Z33CBSw=; b=D0tFBxn8ZVxw/JXA7I6wUpKQXpfGKOM3vRPs3IK8
	5CL6MVDqRo1W1YViRBo6aRyRH2jaf+JTkAmAxuVvA683Bs/Tk84laBk7+BAVR9Jj
	XoavlV7SedRkB6iU57sWromNNQkz/BA6uHlE1C56bSCnQqnoBXOGmDobLyoEQejp
	OmSDyPOZNDKgqqHXrz1WKUYW+MIWh9XyIK3RfiUkDW6BrIRskJWU0zDjKMIQarYf
	opqatafYdUE9ZvG4nuyUPIUqWvMavlLiqkTYHtLGG6ta5Hk/PQUnHIZYa9ol/cH7
	fikja42WTLvPLzz+wNBQO946IB/BC3xU2Ci+SPNmEPessA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077k6br-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 10:03:18 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b1b19eab8bso2387346eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788861798; x=1789466598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rfmoRRos15ggGyuCj+3H9fL/SgvX7ZnyDI13Z33CBSw=;
        b=TGXnK+XanRawCsS5ibCnTKGsGyCpp5XZoiXvnVH60ljhQ7yB+TMP1I0kks9oN8nT5i
         U79GjPgg9cHayVshD/ienKCNfclCypCoiM6l0IzbAvYKDqtXDatG7RAowBLUxKBZsjdA
         Uvb7nIFmYcOidRxv7vpgjfgSlF/r85Emb4MkISp+6lord4K6YXmyRECRifFEZoGTp/f6
         /DtvHxI/E+eHkCtYfx5qcLtHIoKMoGWiLMipgORqY+a00+Y8TyHLS3oK+/nZMyJqgRHk
         s4a9Z7gifatE7GVC5VAJPuRMMFytRV5g/szotSUTjD4GiHdrKQgk9SFaNwJ/fqqIiuUj
         0qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861798; x=1789466598;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfmoRRos15ggGyuCj+3H9fL/SgvX7ZnyDI13Z33CBSw=;
        b=n7Q5KbXnI7rIA1WqkTokLQRm6MMa8kQKPgeTo1OpZrlsZ70u8VYPG5zWte4gdYP7AQ
         vhEzx+zuH7tqILPIIHxzPEJiniArTet4wxmP9wGydw50uHAmNw22xcLzDMmpmiIQOKO8
         vCQlIfogChe3OGS96Fr1hSbL+1//QCaWYkqJQ8WA1P+8hGb8GE2SyyIODDeQRIfSvKtY
         F8Ujdjj2JPaS7UNbd811wHw2v899XtcSi+lri++CFuPqMOHJyq/ozUqBph8NK42OTlDG
         +xGhw6y5v7WD3mDnqnKWuSbsu8mKS5XPkX/sdn1C8FSPw/B0zfw/yN1BeY2htg3bZaYs
         r+Ow==
X-Forwarded-Encrypted: i=1; AKwUvBxzrg5nhVAxJMAqfNNxoMQpliD1ldWeBOoD+0YHw+r28Y32OMsnbI8wURBORpy05+Doo77qsATjHA==@vger.kernel.org
X-Gm-Message-State: AFuF++mpiFJf3svO6eEXsfZ71t0Aj+1oG4RGRygwT3XnIuDOB0DwLMzU
	W4t+k/iJkcyQcyjaPSxaRu83inHvcnimkyRwMu9ZNUzgSXNJodJy4fKuHu60GpuxnaMJvroxt7n
	Qo1DIaDeEB6qmmvW8yxALD9C82avqXHpSNVdba3KzOrdoWjsNm7U/uIAQfsHNZA==
X-Gm-Gg: AYBFou3r9afBI2PmadS5VfVC3NabhhnQkG4XIpONxAC5UMRX2bcYJT3saVwdHtCGQRR
	b8ANqA/MpAFZ1DycORGKiDTIKTYXEdMQYSglZpizw3qoTge9x2nVuUHyqEThsMuXSG4XPosmG5e
	4inmOwTu6U/bBwkHCPPneiMNhhlPC8tY/irl2MTXFWeHwnmffxDwPqSE7EP4h00lYUtV0PKBw+M
	JIDxdvfFr5yEKWPe0Vr94H+38GBd1kVQ0F70dTkzIVBt5sNVmoUlCgVxYfHwWRCUQTMIsNHQz9N
	MQQzvgGeGaQTlk/NdK8dtf50fl4T6Zo6S90a7mvDExF/KsTWTPCcLCrnftMWcDMQEsS7t+FeL3Z
	POPX5U/gEV9TVqeA0fYQJ6E2je0gf+k1TkEZfWhZtiVgXMXSbEfCDfjvSa9OS4wzSJN/CyPhTJ7
	a6l8jx+nTHQyrKnXU=
X-Received: by 2002:a05:6820:988:b0:6b0:19bc:fd14 with SMTP id 006d021491bc7-6b6fe59c264mr15048381eaf.32.1788861798131;
        Tue, 08 Sep 2026 03:03:18 -0700 (PDT)
X-Received: by 2002:a05:6820:988:b0:6b0:19bc:fd14 with SMTP id 006d021491bc7-6b6fe59c264mr15048341eaf.32.1788861797698;
        Tue, 08 Sep 2026 03:03:17 -0700 (PDT)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm31124434c88.0.2026.09.08.03.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:03:17 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:33:12 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] sched/cpufreq: fix schedutil's boost frequency
 handling
Message-ID: <ap_a2uVHgjiNtL3I@hu-anancv-blr.qualcomm.com>
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfX5NYjbQEXbwSp
 TX86OfPNoJST093gI1n0VbMgKMhmrFd6YTILZPAxX1zfKos/BLsaDzpZC98bA9RCRqFTddoP9SU
 CPLgXLUr7vp/Fp9WITHIfqcORswO7FMNKFNzTnPbiOz7bh6KO8X+XogLjVWSyBkKokI00Xzee0o
 tgK3n954t4EyT4biCUoaQbTlFodaa+ULEfayNxuiBtSIZ66rF6Zad1kFu7OO5N5ZiN9qI+9kq3/
 ZgKOokueIvvt9C7IlUABU0bZEdI+06AyohbJoy86lJ70VnGmdE3JOSWASV1zzi++IXmBIyYllQN
 QW9KSND9r/O3875pUJ/4qa3Y0Im1+nsDBC9phLlyq//LZZe5lbKWk2itOnP6m0I0AJ+sr3WsvZh
 NYlbUNYZOQ7dCspJM8Q2xOJD75tiBU1koPa/kqrorIdCKpmujnwQO00JOE4Qaq7pyHiy1L9l1VR
 gurczwxuxFIL3UEWrEw==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9fdd66 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fTh2YsA6urFVvDZ4lSoA:9 a=CjuIK1q_8ugA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: u6K53LWJsgL2JTT7NOyqvFbnbGeYIVsK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfXzNVFUld+Umcg
 6W5mUr/7hUsQ3txIhpZOsb2EC1i4SAlNKsUpw56auYDa+3g/P3LJ6bp6XC+3MH5f/zzyC6GaCEi
 Yz47Q+uPm0zs9OL8zRitNlIJMwf29FI=
X-Proofpoint-GUID: u6K53LWJsgL2JTT7NOyqvFbnbGeYIVsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080106

It seems some mangling was done and all lines starting with hashes
were considered comments and ignored, malforming the logs. Apologies
for that, this is how it's supposed to look :)

Before fix
----------
# cd /sys/devices/system/cpu/cpufreq/
# ls
boost  policy0  policy12  policy6
# cat boost
0
# cat policy6/scaling_max_freq
4454400
# echo 1 > boost
# cat policy6/scaling_max_freq
4723200
# echo 0 > boost
# cat policy6/scaling_max_freq
4723200
4723200

# echo 1 > boost
# cat policy6/stats/time_in_state
355200 36958
4454400 650
4588800 0
4723200 0

After fix
---------
# cd /sys/devices/system/cpu/cpufreq/
# ls
boost  policy0  policy12  policy6
# cat boost
0
# cat policy6/scaling_max_freq
4454400
# echo 1 > boost
# cat policy6/scaling_max_freq
4723200
# echo 0 > policy6/boost
# cat policy6/scaling_max_freq
4454400

# cat policy6/boost
0
# cat policy6/stats/time_in_state
355200 40147
4454400 79
4588800 0
4723200 0
# echo 1 > policy6/boost
# cat policy6/stats/time_in_state
355200 44834
4454400 93
4588800 25
4723200 569

Best,
Ananthu
