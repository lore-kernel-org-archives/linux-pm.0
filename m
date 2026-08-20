Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91523D47A0
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257880; cv=none; b=Uss/q7LiKZmb2Xcn54MFe7F+wQPTqzL1YwFkcol9neu24JEsxnn0kapjXvmeVQHs34nyZu6c8LFU9pTAzah5W8gBm8oP29Y+/bimZwVmUzFtldCBAyKntP05NF3q5G1Wqk0Y0vJ7VTDdFbYxTHB4FpdAXrHpjVxhku8pKEJ+KDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257880; c=relaxed/simple;
	bh=geKpfvBu3cEpHnrKFhEgqyPlT2yuAfAElTrvAVf6wBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGSpw81eF10u/s+0QnxfyMODI2AHeuUwNxSsh/1DW/IuLbWO0GMi4tuXeKiRUlcbMgDXST2WTyNXaYfagqD2khmktEN7JIAWrKXZdBsvDQgvlqbGMAxKz2Zi/uQ1NokDJb9Agdxm/KW/o+gAF5yfcUVCbWlO8OLwgsLf0ASyoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUnjHfMq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=htDVVU/p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUnjHfMq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htDVVU/p"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK8Hwj269619
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 20:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1EKTu26kV1k/zTZ6yeRd/KPqj8crXBIAA/Z2wVIOlw=; b=hUnjHfMq3wDSxEt3
	LtRZOBrgRnt86KhqqCKBTuLs0AU3Jo7M4pk058vQ2x2sknR4Bao6CmlXGFKgqJ4F
	/9e53aiSdQT8qvmYgAPOtjp/jOSjXHDl5IIZoy3q/eL9O++R0NO/dlbMmS+WXQAH
	KCpobukRIq4XircAAZJ+KZt5nC8n/Kot0TyQu9ar3jRcN5EGe+7dpsSFlCiU0S8k
	D1ZPISwoEo8A5aizh2Ys4awoW9srY1N4mr0LkjHaxQSf26bcDdWnhxI7Yh168DkV
	Ahshl/Osfwh0wlG0wJKaQOCfwCQCM1nvav4Qo9bCu1Ec7Gji6tcly44FoKFF2j/V
	VV+thA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg1av7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 20:31:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e538afe65so31143585a.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787257872; x=1787862672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R1EKTu26kV1k/zTZ6yeRd/KPqj8crXBIAA/Z2wVIOlw=;
        b=htDVVU/pc0Im6aiPjYIlzKQaa7tU7+ZMmrXuOOWLAHMQZnuToptSSYWJ633ojNpd7J
         rZ5prKx49ucgzBWnANGt/vg0XRXZKefnpjFYQi9Kvt/HEeK6EYYmRZ/k783IKt+rHPSv
         831XMmjFwBUqwzqA3H+DBYGGGEM2fn2E9NS0hBgrJ4QRkM0tlSwzsGBHhEuBvbRwqK16
         NRi0zwtH35kclMOfGzL1vn3nVIZI2tMTIHJIuBFCLxMJ4Fmy/PjO0Zy18nBUqq/qibKz
         zTRzTJ8FgPqrxqx7sn++27nIOpXQfIwUVvmyrGmD5Wifr/L+B2EouLsLW+mkzP/Upj00
         nvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787257872; x=1787862672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R1EKTu26kV1k/zTZ6yeRd/KPqj8crXBIAA/Z2wVIOlw=;
        b=mCzZCR7rW2sn3GBc91DMBkIOLZsQP0+oN+kKEWOGSmtfHXKDl9/0BaFNkbobgpN/t+
         401vRH3PTl55bufj43/D5gJykodOp9jtZ2+w09KENbJ0XimwyMYsU+3HHOLWQLmjL5rX
         tLPAijQr4HPAjQ85CFfMXsQ8wU1UYmx2BaGcaxfYEUYiadDdYEQYjgtUrz0pOalJEYnP
         GUE9sYwTGFEBPb14pyPwM/kkrNaoZ5nf2wQsD+Z8SUdMtKI93ki6JRIDGzTozRMNqNVF
         bI9RLdwYPmLWQSN9oJ33f/15aJzuLAFOq1U1mbY6h9aXHdbQB/xTFKCSYutkDOBAM7tj
         tWxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqt2sleJHzSS6m4NqFbhXh+s6BP3G1TFKWvmCI0g6FQg/7EY/9r5FjAiIz8x7lGmHBaADWM2/Dz8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4XG4Q6dTuDwAexSmf8zIGPIHzv50knssy9s1TNQYvJQornnp
	KOpkl2h4s1NNdmGOaxGj1TgIbDSUcwGzIfBrlOpcXchsZMVLp1DylJn/5RWsfaUM9Y4cfVoxCzY
	GToxEL5gkS/9stTYKLBR7qhdUQcIbtd7va5ppZIAMmJunYB4PeprQuX66TxnW5w==
X-Gm-Gg: AR+sD13axa+c0sIgGtZQIde6qvME9CXZgO+cjsEqwk8bzZL26jZflnbzU+VV6KQRMhR
	vLN48EQTQgn56zOQlOUgcDyGk+8DF+WjzZ8shHHCokBQ8uHPC8ucER6KxEE+rdgQexMz2DvaVGe
	enIY7ofiFDLCykyLiMcFy+0Vo/iJl54x87IBk+KfwnRiAF+u8byD5rftUttYuFzZRsI5IRKOQsU
	k4gIV4CBalvrLJMNsj5n6rctQzllIkeZhJb66vhAk3d3m1Wm0O7poy1mhrurVSwnTbFLtz4z5WF
	nCpeMC+wNsI3/BH3G78X6QfbWWSPtBtiFnFSrvAzzN4P5oY83SSF9nvJ82/6VbbjhSMw+FqQYxT
	/A/Q4HUmi0eZKUmY=
X-Received: by 2002:a05:620a:17a3:b0:923:7821:dc0d with SMTP id af79cd13be357-9373959d6bcmr80202485a.33.1787257872218;
        Thu, 20 Aug 2026 13:31:12 -0700 (PDT)
X-Received: by 2002:a05:620a:17a3:b0:923:7821:dc0d with SMTP id af79cd13be357-9373959d6bcmr80198085a.33.1787257871697;
        Thu, 20 Aug 2026 13:31:11 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589d98b0sm125834266b.6.2026.08.20.13.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:31:10 -0700 (PDT)
Date: Thu, 20 Aug 2026 23:31:07 +0300
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
Message-ID: <wuunnksblclkor2icjtcgqiran5ryurzgrctm6by2svariwc5b@5p2tr2bdpvw4>
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
 <20260819151457.256959-3-ulf.hansson@oss.qualcomm.com>
 <yuowf7hfnhcizjgxglfypsqbf7oavh3jywbls5mdbuyc5rglmn@ejp2tahonk6r>
 <CAPx+jO8MXQwDh2Bvws4ngO=9LeE3YvFkiv=KDgYupWxS6VePjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO8MXQwDh2Bvws4ngO=9LeE3YvFkiv=KDgYupWxS6VePjw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: -QvGXq8YuSpik6BMjXSUVsUG4EbZejtp
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a876411 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fcjlUs8CjMbDbz1g4Y0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: -QvGXq8YuSpik6BMjXSUVsUG4EbZejtp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MyBTYWx0ZWRfXxq0w97vJG4LC
 dryObZh0On/P8YMGKG3x318/nutdAlzWXUabSQ2npwlaqYKwK5sVQSte+iPHn2UqmUdOfkFD2am
 pEFCjodYLNNlPKwscMwhQJjujnRI87o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MyBTYWx0ZWRfX77qozWZIYqbT
 Bam+SKIV4KE0mWCNBijSXEiJ8VCtprZN6zRSL29xWtkB1HplI1sf7SkI/yJLqBtBZlmqvDpM35U
 Z5V2rUcWL6UIbySVD2f9WpoApJ3JthrAoHlowhE/kiBcXKxyS/Tu/CcM0JpBaE+bECOsl2tnSzA
 4nM3bIylmlxtehR4ESG31ceOh3PlwLHDxu/keYq4RcQtWZZlx154yvm+lHXWV10DPPjwV4Ccgqn
 eD8gpwO33T48nqIiEv/D1IddSmselHiB6jiQRG6rKjozf629xpxAYkRwaofBxCBt2yagfXMbEY4
 GShQDKG65mlruXsjAHySP+KOG9EtyiDcpoG7JOx82O3GdIcghMufkgbq3dl/NRkC8iB1WPcz/x8
 cTz/3lbbWo4uEy7auGae9idr9cA5CKmwFySZhTv8KcfTXljhVZItV9+OKaoS8vQC5rolK4NnQcj
 VVqyy7h4CsIxEz3i3Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200153

On 26-08-20 11:56:40, Ulf Hansson wrote:
> On Wed, Aug 19, 2026 at 7:40 PM Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > On 26-08-19 17:14:52, Ulf Hansson wrote:
> > > From: Ulf Hansson <ulfh@kernel.org>
> > >
> > > It's not always possible for a genpd provider to know the initial status
> > > for its corresponding PM domain(s). To register the PM domain in a safe
> > > state, the genpd provider driver may therefore have to initialize the
> > > genpd's status to be powered off, as a way to prevent the PM domain from
> > > being used when it actually could be powered off.
> > >
> > > In these cases we may end up to power on a PM domain through the genpd
> > > subsystem, while from the HW point of view it may already be powered on.
> > > Under these circumstances, it may also be required to keep the PM domain
> > > powered on until all the consumer devices have been probed. In other words,
> > > until the ->sync_state() callback for the genpd provider in question have
> > > been called.
> > >
> > > To support this behaviour for a genpd provider, let's introduce a new genpd
> > > configuration, GENPD_FLAG_OFF_STAY_ON.
> > >
> > > Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> > > Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
> > > Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> > > ---
> > >  drivers/pmdomain/core.c   | 6 +++++-
> > >  include/linux/pm_domain.h | 9 +++++++++
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > index 7345c06f1d55..be4fff2f4664 100644
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
> > >  #define genpd_is_dev_name_fw(genpd)  (genpd->flags & GENPD_FLAG_DEV_NAME_FW)
> > >  #define genpd_is_no_sync_state(genpd)        (genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
> > >  #define genpd_is_no_stay_on(genpd)   (genpd->flags & GENPD_FLAG_NO_STAY_ON)
> > > +#define genpd_is_off_stay_on(genpd)  (genpd->flags & GENPD_FLAG_OFF_STAY_ON)
> >
> > Maybe genpd_is_state_unknown ?
> >
> > >
> > >  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
> > >               const struct generic_pm_domain *genpd)
> > > @@ -2445,7 +2446,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
> > >  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> > >  static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
> > >  {
> > > -     genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
> > > +     if (genpd_is_off_stay_on(genpd))
> > > +             genpd->stay_on = is_off;
> > > +     else
> > > +             genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
> > >  }
> > >  #else
> > >  static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
> > > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > > index f925614aebdb..9929347e1d7f 100644
> > > --- a/include/linux/pm_domain.h
> > > +++ b/include/linux/pm_domain.h
> > > @@ -121,6 +121,14 @@ struct dev_pm_domain_list {
> > >   *                           powered-off until the ->sync_state() callback is
> > >   *                           invoked. This flag informs genpd to allow a
> > >   *                           power-off without waiting for ->sync_state().
> > > + *
> > > + * GENPD_FLAG_OFF_STAY_ON:   Use this flag to inform genpd that its initial
> > > + *                           status for the PM domain is set to powered off,
> > > + *                           which may not correctly reflect the state of the
> > > + *                           HW, as it's unknown. If the PM domain becomes
> > > + *                           powered on during boot, genpd will prevent it
> > > + *                           from being powered off until the ->sync_state
> > > + *                           callback is invoked for it.
> >
> > Maybe GENPD_FLAG_STATE_UNKNOWN ?
> 
> Hmm, I understand your idea to clarify this and it sounds reasonable to me.
> 
> However, "STATE" sounds a bit vague, what do you think of
> "GENPD_FLAG_POWER_UNKNOWN"?

I guess that could work too. I was suggesting "STATE" because the
gpd_status holds STATE_ON and STATE_OFF. So it would be the flag that
says the state is unknown.

> 
> >
> > Or probably it would be better to just add a new state to the gpd_status
> > enum, like GENPD_STATE_UNKNOWN.
> 
> Well, the problem with that is how it should be treated by genpd
> internals, when there are child/parent domains. Having an in-between
> status sounds unnecessarily complicated to me, at least for the
> purpose of $subject patch.

As for it being unnecesarily complicated, it would actually be the
true description of such PD. Otherwise we might end up with cases
where it is inconsistent with the actual hardware state.

But I agree, it isn't something that should be part of this patch.

Either way, I think the patch looks good:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
