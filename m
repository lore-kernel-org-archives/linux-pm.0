Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B99368D5E
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161261; cv=none; b=CNFr+zropUBtXSZfQj2RFC7dGD3gesLuW75kYRhNEXmBe6mvl+m5QVAWMgjCDbu1lGitAh9BXvF56065s8ChW7VHsTb5FyOCgWRhVAgFLGUyP3hCwXrKPjx5fRenj99Vy6v9j/J5RFSCjfSugbzyMtSJDkYtdaPlg0Q8peI0vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161261; c=relaxed/simple;
	bh=kcqmn+1kYmzufkXPlsyDyYdn54BkiiQbbbg8lg5BUjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGLpQ9wv6sYHGnc1prlTT0q614SzpribOSyJha7p+xUQ+PA08aXs1uGD/1Jx4V0vejUC2fquygvE5dgDztmMSRLDBHOUA48JeO1zcexeBmem986YxYzoFz5WuneQra8hOhTWlwxvt1WpMW0UQj+4oY+d2kIARouIOIN9Zdru81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ag9/GdtP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDSYyrEh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ag9/GdtP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDSYyrEh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF2EAG190698
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SxyixotCUqnv8fTWw5PhKOZA
	9Gio5rw0RkkCoxm8lBY=; b=ag9/GdtPoSs274iEWAv6M8JsDOct2DyiA7f4DNXv
	h6JlJL8F5RxQR3X3pvvm7voi5Yav7ss68/gpyjSZ2hcQMxRg++2D5ACQ4QMITxrR
	j/zf+hf4llSTN8E38yxYDIyziF2VMAgQ6lDydHbBLhXS0EvB/eZBn1RX+AyRj5pO
	UffQmYPllrzp/2FEfJ3Z+6OAQZSQbOAESp2uar+6zjyMLPwZOTsuKgqtOk7l3DAh
	Gd96niK24DIWTStRkW3+0A+HbK1756VLVYBfbCFatrnXD3H3Ce0JB8lHlZ+AwrHR
	DSz8y9cBoC/1idCe5+DF+qsnqDHIpcps/tutB4JcsHx9LQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esc0u8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:40:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-933023a5980so211978585a.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787161257; x=1787766057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SxyixotCUqnv8fTWw5PhKOZA9Gio5rw0RkkCoxm8lBY=;
        b=JDSYyrEhaJfe96dKArueCZ2h3ABiMVJiypq0t4QBJMO3DqSai66+sjFeqO25NpKnCC
         U60MKir+B4g881GPzD7S0X4zXibW0Bo7+rMHQfu/ybF22aF7FpZurj5vZ1YXpV3D/pUV
         6eyUfPIyuSE6YJPMaH7xUS2EAfpNuOILjHG6J6fhv9S0LoParFF1rFY1fcnKoug5eZPZ
         FsuR079zzlG4v2i3+34fwHrhLHxeIpH0FPxaGBhPBRqJzmV0BhOvOyoLSjDiN1jacEce
         fEF/W1XYc4PQxI+j/KQxaftt4x/qZ+oNnFXfzrQKKHi6n0cMQGLwD7exoN0+bWabc7C3
         HapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161257; x=1787766057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxyixotCUqnv8fTWw5PhKOZA9Gio5rw0RkkCoxm8lBY=;
        b=FrJg9F7uNh1sjGh7yqS/GVDd3xmQXCoUYvgekZpvkWquDTglpMK6sacHdRyivL2DXR
         ugRQSjYBDxgBKt9twajJNFS0iRwAefISM34AihjLqE1WFEOi8TriyBtztW/Y1MOXZp/w
         XdSKug2uL5JQN9/4k4XInFs6jNCfrCpwH+6z6vNws4ZARKTFLS730VSveGAlnF/zZ6xU
         bA0XSUakFiXgMfzIQs8CgLxZt5Z8V+AjslFsJDSq1qV/xFCO/HXZqe7DcoG3B8jKUPXr
         busOeNFbzWN5ti3YwBwJA0kiJBVTozgNZEnFKdVPgYM6yFpTtbqdQbNMZdWxwnQTKlHh
         KL/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpI6bQb0ap0vQbOxXIRrWNBvTllTiL90WRpETX8T40tsfa/J1sxSCTDlUwVXX/bk3dbn+gU7iFAvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6KIPLNYOFYLrD/ixQUgkYeigOEyMIyyountomIjEYqpqBw7n
	mLVsSTyz6993kIwWFYc+JXnr7Qw141M/QZ9cbZXbjPdeYEFf7PAuFqZ90yrzcZXP+9e/zIegbQD
	1ZD+qdGEHuegRkGywlDccuPsqb+NvPyqbyRRo8KRpz595WZcaP308n+J+9WGL/Q==
X-Gm-Gg: AR+sD12bf1rtTfqfqHPhlTcjtLL5buFmgsqi5IsllRXy50WxREX77wJ591Qkng4+Um4
	naRtxmoccvnw39ko5dWz7KDHtWdhQvP/kmM3Km1egW2Ya1SH4oePTvfyX2saeqNMAY3FJME5CEz
	iwjeprPe9V9V+Zq7YPhCqOcPCJATJ/HAwvTKCaM1j+weTEu6rQ1Xdt3YKW+i3MFXSPyJ6bezjCt
	YJY0oeXyxUMCkrHwBotvdUjriihJWQLR/2Zqg7APf3IU0vlc1mdxDPeriv0StIzhpW9mjb8jb+7
	tn+HRut3gG97ukj9tJxgRAWH+xyKbp4wAF/AXvUKQ7ypCp74oXi5eAzZHJFpud3UPqyWMCRZQIc
	JatVurEc2I3UwxVI=
X-Received: by 2002:a05:620a:6884:b0:92e:b289:8cca with SMTP id af79cd13be357-9371e637291mr695804285a.44.1787161257080;
        Wed, 19 Aug 2026 10:40:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6884:b0:92e:b289:8cca with SMTP id af79cd13be357-9371e637291mr695795685a.44.1787161256406;
        Wed, 19 Aug 2026 10:40:56 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441748sm7196819f8f.8.2026.08.19.10.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:40:55 -0700 (PDT)
Date: Wed, 19 Aug 2026 20:40:53 +0300
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
Subject: Re: [RFC PATCH 2/3] pmdomain: core: Add a genpd config to support
 unknown initial status
Message-ID: <yuowf7hfnhcizjgxglfypsqbf7oavh3jywbls5mdbuyc5rglmn@ejp2tahonk6r>
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
 <20260819151457.256959-3-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819151457.256959-3-ulf.hansson@oss.qualcomm.com>
X-Proofpoint-GUID: 5OeMV3kQjZ_M0HDBzls5y72-lgcgmfx9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX3dvnEmFgbQ14
 iIiHwHzjzFKGgwa/qvrOK1Co7TV7wrGXa9wNqqPVz6pc+nkjsV4w3tx/aSyMUA1mZZQwZtNDT3m
 2bGv34G2hQRutnkakGL0ZECSbaxyh2c=
X-Proofpoint-ORIG-GUID: 5OeMV3kQjZ_M0HDBzls5y72-lgcgmfx9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNiBTYWx0ZWRfX3MO32lRlNe3J
 aPfWlUZcvf+JggThcVrj+3AwMKKPAqfKay8BhKKDJ2cedogX7CmrwYB0OhNqfHVtEvAanZ17NSf
 vmDgUrI2bqUNtsCxtJCnUpihgAbr5wEVQMOojwb4tKiZj7WBjuqZDZ+gMT5xcuYI1LFJidIZum6
 B0aaHWRBcSzcLX5RY9RoNVNw6zJRxI1kvYY1pSSc9PntaozNPVzmfLFamBsg9/IsadPi1CXuLkq
 EgNrl48Mgv8J50jWILiafj+8+/GPVeGiyiKXwW206jlgyWiHsTAOKAtJz5jZ/cRC95VmCuuaQwc
 8J1PhXdfYFG7rg1CVp2dqcuzvdhL8QtAExbpF1jeFNs1gAfSuu4luB1449ZY2YPl2YRIcy4TXgq
 i+a/k0IKslgooItdovbHo/tsgeLSs1TSOBzx9Vu3+1zhJ7sZFSd1Pjb8vSIcPED/Xx+B5G7nM47
 J9cxdu2Lm0SzA/TOPVw==
X-Authority-Analysis: v=2.4 cv=b6uCJNGx c=1 sm=1 tr=0 ts=6a85eaaa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Cb7zu-ASHT091ChWOAwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190136

On 26-08-19 17:14:52, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> It's not always possible for a genpd provider to know the initial status
> for its corresponding PM domain(s). To register the PM domain in a safe
> state, the genpd provider driver may therefore have to initialize the
> genpd's status to be powered off, as a way to prevent the PM domain from
> being used when it actually could be powered off.
> 
> In these cases we may end up to power on a PM domain through the genpd
> subsystem, while from the HW point of view it may already be powered on.
> Under these circumstances, it may also be required to keep the PM domain
> powered on until all the consumer devices have been probed. In other words,
> until the ->sync_state() callback for the genpd provider in question have
> been called.
> 
> To support this behaviour for a genpd provider, let's introduce a new genpd
> configuration, GENPD_FLAG_OFF_STAY_ON.
> 
> Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> ---
>  drivers/pmdomain/core.c   | 6 +++++-
>  include/linux/pm_domain.h | 9 +++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 7345c06f1d55..be4fff2f4664 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
>  #define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
>  #define genpd_is_no_sync_state(genpd)	(genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
>  #define genpd_is_no_stay_on(genpd)	(genpd->flags & GENPD_FLAG_NO_STAY_ON)
> +#define genpd_is_off_stay_on(genpd)	(genpd->flags & GENPD_FLAG_OFF_STAY_ON)

Maybe genpd_is_state_unknown ?

>  
>  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
>  		const struct generic_pm_domain *genpd)
> @@ -2445,7 +2446,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
>  {
> -	genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
> +	if (genpd_is_off_stay_on(genpd))
> +		genpd->stay_on = is_off;
> +	else
> +		genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
>  }
>  #else
>  static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f925614aebdb..9929347e1d7f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -121,6 +121,14 @@ struct dev_pm_domain_list {
>   *				powered-off until the ->sync_state() callback is
>   *				invoked. This flag informs genpd to allow a
>   *				power-off without waiting for ->sync_state().
> + *
> + * GENPD_FLAG_OFF_STAY_ON:	Use this flag to inform	genpd that its initial
> + *				status for the PM domain is set to powered off,
> + *				which may not correctly reflect the state of the
> + *				HW, as it's unknown. If the PM domain becomes
> + *				powered on during boot, genpd will prevent it
> + *				from being powered off until the ->sync_state
> + *				callback is invoked for it.

Maybe GENPD_FLAG_STATE_UNKNOWN ?

Or probably it would be better to just add a new state to the gpd_status
enum, like GENPD_STATE_UNKNOWN.

>   */
>  #define GENPD_FLAG_PM_CLK	 (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
> @@ -133,6 +141,7 @@ struct dev_pm_domain_list {
>  #define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
>  #define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
>  #define GENPD_FLAG_NO_STAY_ON	 (1U << 10)
> +#define GENPD_FLAG_OFF_STAY_ON	 (1U << 11)
>  
>  enum gpd_status {
>  	GENPD_STATE_ON = 0,	/* PM domain is on */
> -- 
> 2.43.0
> 
