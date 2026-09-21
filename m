Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455344E67D
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986434; cv=none; b=iKQ6zzsbUdMhUSUxbWwGH/FmOmI1CTjjdpinONUUcJLvBGu4gpFLrnY8jlJzWfBJVugLHU6PFHfgI6WewQeBScenul6KbjjjOaNk20OEtTI025bO3Ws+7k5RnAxDlH3zhF2D4Mu8SwK314//BiqX1tGMKllxuLETSp84MrDbPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986434; c=relaxed/simple;
	bh=yxgM3BaImAy+SlUU1mzmEvRZgl6g+xC5GNESqfvIEAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8j2fXesOD73C+KGxagdslkLvcyZ88Qa8dQUPzvHT51FMJ2BshOZQqmhz8oyT4KHcK1bZBhJ0n/hzYPO8HnOui/lQQijb4zn4sDpWkIbmvbfCUg6jlMPXHtLzbk7CBPHjuK7LFvn/dD5CK0UjgtL0/ZIj9rs91Lfn872/4fzgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hy2TRqgb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCp9G/1P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hy2TRqgb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCp9G/1P"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79wX2467228
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5cKCGzxcgnnpJMH784yDGdXF
	UGRhOGR/aMYRfCbC+zQ=; b=hy2TRqgbMCNuIwg7jxkSzW+UOE8OoEAJ3V0lzXzF
	BY6dYDY7CPCEwGpGTmvbpcl/VxsgRJ6MXa0hXStUIoq2aJIDrMgcoXFmSxCCAkGD
	wxjy+3t9pxYG8Y9+uRMfGLei8f2EvaVgSJvRj9PHrB312hv22LkFCZBS/ibK7BPF
	BxpdwIhlM++7EU8hZua2nN0abYfAH9QOKyaBnrkMPBbBJTFd8YcbTIIXRvCjiviz
	p85qVkOSrVY9e1ivvJg5QTWC6uinvRUjMBMwvjL6NpomaataGmKtRmsCWg+CNxYl
	nYINfHrr59nkFT5uQqjrA+ogc98GV5qIAQ7FGBOhtMlthg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8ba5b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:27:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so2820272a12.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789986430; x=1790591230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5cKCGzxcgnnpJMH784yDGdXFUGRhOGR/aMYRfCbC+zQ=;
        b=iCp9G/1PnWwxranxM/lBjrXuKaOXu82Fcl2VVBAdfiGSnV4mGknL+JY6bVt1rdgIbh
         2iObUozw+CA1Dzsgdi3+0kEULx43YXd2anWYADyMfjtV+h2hGtC7gv8MX069X/E6GwH6
         h7O28yIu6viVbg/B6ToJMg5TfTgB39CWnuKKFENn8b3N1f7I0o80wVgfPHwlckyizgTF
         MzxPrGhKF6X+QFdSs5OOegjXQqfLmiI2DN8+SDXBaWRXlkvOrIQRuJYlJ2fYFx85zkCl
         eF+06JWNj8olQwpp0AY0luJw33zG6e+zl5s765MRod+ey/h62Ux+AqswZ4ZoxOpHnrZj
         nPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986430; x=1790591230;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cKCGzxcgnnpJMH784yDGdXFUGRhOGR/aMYRfCbC+zQ=;
        b=xGO4ENViu6azguDU3+oTk7hp872KVQkHfCD6AGOgtlieH7vB/l/aN7CLDgnPMR192P
         1Ch+CekX8kHvnSIbnlCWR9vCCnMPtKwe0CsktNLP/hedjCBYNrW5rcgrlf56DFw2w47k
         VDPZ0zSTQZrwGX91HLA6v5m2Uk5qFhjye8NEt8DCUA3HdEoj77U5jolxCM4Yz//UHRZX
         ydogEmXPYNK0ea3L8/f20yCEssGjrkdUlgY+cvr8veFm2gh3qAu02r7KTr/Z0rl72n62
         paZgK8rZ4sx48/EjCFk9zZel/c8vj74gCYdVgUWRAcl+RKL3TOXiCvfPtdwMADhF9bz7
         9uRg==
X-Forwarded-Encrypted: i=1; AKwUvBymneUmLNNw8xyXzpvlvn7VZUTFw3nHojG6TVjCCv+xaTpz+ZungWxa3fH2Om+G7Ah0i2j/sLZxFA==@vger.kernel.org
X-Gm-Message-State: AFuF++l8U9uKFUYGOSfC53JADbzCKDvGNoFLaQIeB1iu+jORKfZqlZlX
	VzTp3p2McN2l51dq9YX4wQ36skZLNiqGdXuPE3992LzBGg+OlbMcTMmobFYUfbIBRZI8sukpjOM
	KwIN54t0W0wLTY1gf9Eg+VGTMRv+9D0xu82nm44y5O0IwcOv5ezCPnxGaVrnBsA==
X-Gm-Gg: AYBFou3+pgP1HayfC92UXMop09//3V2/0rDZMtphkc4POGcOeR6UoxfimyPwNctEJtc
	a404YyBWyrjtvYr5WHi4G+z9rW9sNEyJcODe0CL2Fw0EgWeh8f6TzetAI5nEa+NuNuhimNEnAxV
	C4BA3czIbl8pjVCfI+L1evK4PUiELWoio+br+GywmA1h3XgU2XFc/nb/I9t+kbkkunhqkyYk2/v
	9yzfgj85HrJW5I3UqgRZuONJ8B6qxGW+cgZqnXpHs8aoRdjfFvyCnX2XOCG75Ad3whqz7QaVoZ6
	RAC0kwHp66hBU9aA1dAXLktQib2xg4px991aZqEcBLmL0vuAN2Mc/AipfOUQgjRxxYjH/9JhMVK
	mNaoWQpqKRWA1p98l7DRT+JaPYK/CkV/RKVw0BO3nSaHonRAUi9kx2mFLqoPZPEfEjYKJp7MSHO
	X7ojJPzGtWOASaYA==
X-Received: by 2002:a05:6a20:6a0e:b0:3dd:a00a:7ac7 with SMTP id adf61e73a8af0-3dda00a9e84mr10508072637.52.1789986430024;
        Mon, 21 Sep 2026 03:27:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0e:b0:3dd:a00a:7ac7 with SMTP id adf61e73a8af0-3dda00a9e84mr10508058637.52.1789986429627;
        Mon, 21 Sep 2026 03:27:09 -0700 (PDT)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32da4960sm22293447eec.0.2026.09.21.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:27:09 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:57:03 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arch_topology: seed capacity_freq_ref with
 boost-aware max freq
Message-ID: <arEGdyvIEXAgltRm@hu-anancv-blr.qualcomm.com>
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-1-25312a713699@oss.qualcomm.com>
 <CAJZ5v0jbYHcEWqqO3YSbwyeHBLkYCFn+_nQ9Ktt3yYPPcNH6LQ@mail.gmail.com>
 <CAKfTPtBkv2yG6ne2FG5NUY9QfeY2XTYg=GKnyzoFawkweK-EYA@mail.gmail.com>
 <CAJZ5v0h+ibqtvTyOqG+iy2vOLCXx9WwfHSoUu1URDCvzBYU_sA@mail.gmail.com>
 <CAKfTPtATz-aToAVh4sGsTRKM+0sOoVW4AC6gjufAjrFyZg1zFA@mail.gmail.com>
 <CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i_QYa-LcrK1U1VZjZZiJ3d-9hPbMdBbaGoqMds0BAU6w@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1MCBTYWx0ZWRfX4rgfuRJYdbEg
 pb7h0d02cuQqMtLF7tbMur1ARxv6l4OC5jwktaY/Z/iVpP3v+KqCSeIe/AcyFxWlpdYsAiprT8U
 tvpBMrxFXP1+MNwTlfARoYIaaKinaINkIiQwaxmSWlmwo390dLT5Gfm2vvSG0qdfPt06uw/59TZ
 yH6tFc9EuOcMok3ObYeC+OayaNNgOmvMwNxz7aJUBHCo9jib+2Ax6Lf4iVl9hXkxy3JdTODJKqE
 ZYK5hVU1Y4xEfGlcEznLM4p9lvSMqJ/aJ77rq/LhBl3vK1nU83XrhuoMfyqWm1GTFwDM+kIiNlC
 fNThppva/0QSEePhyxpHkkP7GHx1WLmVgy8t1C5lNJVBQKwlNkwQNTEjnBQ39VFvSTqcOS7+AyZ
 pNjgFGokewhs8/rNxBGdwEvrq/mUjESftQXIO51onOVMAD3aqDLw1fu5fIzDZIM1VFv7XqwwpjH
 jp6MhF3hnIUfIDeyGFA==
X-Proofpoint-GUID: 7eGDjjSAZRNuMEM2JfMjkMDsO0LIxBed
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab1067e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6V1s5AGd0rRNUVeZ8sUA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 7eGDjjSAZRNuMEM2JfMjkMDsO0LIxBed
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1MCBTYWx0ZWRfX8qewdd1/l51e
 Bammt0F3SqD0A4WPYBgOjE+pb4i4fdAyYw6+zWB57aIdPdDKcdh4fR+kxGy2vObKi3CJZCkhAgz
 DrNoqE20KxDeOOUXxUmzePIldD/luNc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210150

Hi Rafael and Vincent,

On Fri, Sep 18, 2026 at 03:32:50PM +0200, Rafael J. Wysocki (Intel) wrote:
> > We keep taking the max between freq table and cpuinfo.max_freq fo the
> > case where the boost freq is not listed is the freq table or there
> > isno freq table. Or there is another way to get teh boost freq in thsi
> > later case ?
> 
> No, I think it's the only way.
> 
> So init_cpu_capacity_callback() should find the highest frequency in
> the table (regardless of whether or not the "boost" flag is set) and
> set capacity_freq_ref to that one for each CPU UUIC.
> 
> That's roughly what the patch does, but it can get away without adding
> a new field to struct cpufreq_policy.
> 
> And the changelog needs to be rewritten to tell the true story.

Thanks for the review. I'll take the suggestions into account and spin up
another revision. The second patch also adds a max_base_freq field, so it
would be nice to know if there are comments on that.

Best,
Ananthu
