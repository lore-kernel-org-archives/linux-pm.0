Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794491184;
	b=yaJ/TIYy/OhTxlluIKEdoI/z46VEvI8meIMZrrCdEgUI05U2l007IdAhE8NBM5CrZpYO
	 ceKgK4tpiwwehm7ewTrOwwHjyoVMqLzAxekNUeM/LKhLZKkVfX78JTCew6se14AACkqfA
	 2E/HuhYalqruu/7Lzlslu+agX4F6GtCKu2JbTOcaGZKPgj9cCsVmq0P3NusF/WuMLQo/l
	 33GDQi8Zvvfo7jPxDC349k1vrwjK1PPL6q6sr9a/Zlevt6gtTrvliSWlRE8z+kWdTty/S
	 wQPdDqshTktu6H65tvh1pba9cf9QhCb4Wh+zXuemrg5bvQ/p3W6l78oO+eRlbeC3jQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491184;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wzlbTcwQcAVau9OZ04IBsPLcMmJU10jDn+7fgZ31ZUs=;
	b=VMlVTSH4iZ5MH7N9qqIBRttnmmBKF7AUVSIUv194I/bjk/bcWsSkeyslJ6iYWsRnbokd
	 kLwOp619WeJ87H/csz/MapLHtgW4m2Viyd6nSNHytBrRUnqwATIHVvOSsWqYokZURn8Xn
	 cH06e1vAklRaKMN/qF5QpaQu1kX3P2WRxdcwFKCrASB540lkRNI4qTBACyvt2LvHG71Ky
	 Z2fT6FQhyhe1cJOT20rVZZpx0+57kTcgrDoQaPe9EcMxjWIfUpKbrwZ3+h4Wgy+cwywVh
	 ImdQkPEoTnR93sw8ucKFw9TBtPO8x9NfZUjgOgsxcev4awxciL1DKhAdeMBVGz/ZqCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JUZDZq4w;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R3tcEsC1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AA606A321
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A87AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JUZDZq4w;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R3tcEsC1
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7oW642818507
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzlbTcwQcAVau9OZ04IBsPLcMmJU10jDn+7fgZ31ZUs=; b=JUZDZq4wPcio41pj
	obsZMATGPBHIGIxAcBSBTuoDE3rWxdJrFgbAcAzhzCpDMh3jZGuHuCejqa4ThX8E
	cj5K6qWRjCI4Cog5b5V/Le6R10fPfr567mKKjiFzeog3vimflcYAtpkUOKvvyWTD
	klGjqKEFCDVF9iBy0Op5OfF8yQlK3q3fqf6rHYMDE24K+lB8d8xXdNgzaIKLkHba
	4UeQLqhMY7oIdL4YgOJ+7xmWccDDZNaiWz/OMyypmcl8Gyryts43GMC80jgsB6Ea
	pr9IXzoX2obW5P5OYooD5od0wGd/lXod2fHnX8pnxVJakB7c2A74B5kNOGuSQpn7
	qvm23A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9e197y5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:46:22 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99063f4065eso1330612241.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 05:46:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794491182; cv=none;
        d=google.com; s=arc-20260327;
        b=kUObzL59u1Rw6W5y9/SjyyJwCe1FL8O8P2zbwSdm7kDmiEBM+ZxwLM/31Yw13fLshc
         Zu94DMy8XmsqEbFvg9ZDtzTYGlVmkqTs1Dx2HSbB7K5cP62dhdR70MxyPonNMmlNtZW3
         OWSe6jKQ9nRJGSVTuMIMdka04euBMUUtsQu7Ceo3lBnQCfEstioWHn8uGP84PrSc/IlC
         DCpyDdNg7m59Sg6WbmVn+XbhFfdVErhEBAUIW2kJXOixNhPvNx2JdaJxofSxZhaXQXqp
         YZ/F8XS/ybaYQT+nRaDdNcRrpRdMUTLs/Q1wB63asSIq84kqXENbQEsDpyma0xTQ5dt5
         uvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wzlbTcwQcAVau9OZ04IBsPLcMmJU10jDn+7fgZ31ZUs=;
        fh=05ay8poMhUZv83JrFFL0Oy1VudGj2nnj+LwBuGhcN6k=;
        b=S7rGlX2/fWGIqfNE354dYLXZuTcYcDjSpMcxalCH00xKmc2+0P1tiij2o+JPnQnEh4
         30okjlUfzYF3iGPZfuHRm0NFqIk+yyQP90cy6zaYBegJ0arA+FtczrBRLf/KnZayOyq7
         ftBPW2WPcrksredqJQM1mIaWIwWzyYmdpc5h5TmlhiYjz4j6KjaP7fKKdtNigFcMuYIA
         YVAjtTIc7/75ozkBgIwxFIQrhWFsP0PPcKYbERjmMiV4b7lRK1VtpVoeVb7gPC8mp8vh
         MB0NeSyJUAWiGoynSiLpduNRqzsh9kyRqef+in9thL+ynS3PV+uTwTJU/PQtk9lalQQH
         JXGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794491182; x=1795095982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wzlbTcwQcAVau9OZ04IBsPLcMmJU10jDn+7fgZ31ZUs=;
        b=R3tcEsC19ckKK/0WzEy8xQUINyh4DiLRUQHXDLB4CJCFKbpb684zARzPnVI3/LAwCm
         PmKGuK1cWyoTTUvnv8tEEJO0SHFWAhX+8kZDhjfK5c1yUyCCR8DtXHvMmQxdpG/7twUd
         EsO3NHMr1zX5EksxSPeHImMWwrOPSwHChwkRnujtjYgIs9HwgpgTr3Dtte8NbIPpX+Et
         DJicJj46yC98Wfz45ickDK1xkULZEClwi+UZ7CVjzjCNFGGvlbE0hTkCya3K4qlhqKJu
         sOuDA515B7+XTKx+ceFLA7jCO6vS+XDylkkrbgofHk0x9UXriIBClx477ektJJX/+CKq
         0/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491182; x=1795095982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wzlbTcwQcAVau9OZ04IBsPLcMmJU10jDn+7fgZ31ZUs=;
        b=JqSVBbf3H4LjHbEOUEXS0kTPtQhwGhEFlx0teFt7wIwQZjYU90izUWK+hBhk2A9uPL
         wVRGgV4v7BPc/0tFJwS70csp7whMVpPQ3kN9/IZOAKY9/IZ4VU7Rce5XA1Sw9EvYX0ql
         t9RBkqRfygERJMKbPeKKyYOPjTWNgRxSpEkRap/usl9lEdiwxDUKs0KU19T5TjS1avi1
         N++fK0hQSkxJeTWHB0z8W0MuEZ4ki/jJ8qdt3PmTTyQQsoZ86jPhqlK2DdCyjITMuB46
         1anjr/3m8DQq98R6ztuecCAMNeo38xRYNSle7p9Wrdb31PPBFeT6MQB4NNNoilIhu4yJ
         MMXw==
X-Forwarded-Encrypted: i=1; AL+hErG9rF9RDXqbK6I5/CjLCXdUpa95jqN5w7PLAhrI9qkPIGDP27dZJs60nF0+w5ilVGmikk0RKbID1w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9mySdVxKKplbPnpUFhzCEg04ha7y3Vd2xubqzWLqkhP1PtqrwN
	Lsh0qC/q1gT1Y4W+B853JA9SUPJDqBqkB5tJ2avYOnZbpitAUhU4CcHw1zuIrN3izA3sazi8BDA
	peO4rmMVzj11aG2cM8OlAwlImFxW0bJ46JWfknQli9ifSsMIH2PUVvkbAiwG10F5r120/AsLtDp
	JzydrbIb7DOhl0VAlvCySEwoeRAxHpiKRV+tXJ
X-Gm-Gg: AYBFou3wNgvlX6xr+aTwBTuwOxiYNNKUH+JxpjX2zEtG+zz4pW4xC/A5P7rT1AspTLw
	20lBthDAJ0br7Rpcq6JzpRjfIdYIRZa3YRu2hXx0AWONvPjqvtuta5Hl4nEQ3IEUbU1WhGXX3tg
	ZxhW4FH7NymQ11CGHtYY3WTCdJj7rHrK+8o3bFNizizCIzWoHBWEWIFa+Z+w==
X-Received: by 2002:a05:6102:5125:b0:7cc:b246:31e2 with SMTP id ada2fe7eead31-7d4fb2c9173mr1852010137.22.1794491181866;
        Thu, 12 Nov 2026 05:46:21 -0800 (PST)
X-Received: by 2002:a05:6102:5125:b0:7cc:b246:31e2 with SMTP id
 ada2fe7eead31-7d4fb2c9173mr1851995137.22.1794491181313; Thu, 12 Nov 2026
 05:46:21 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-b4-pm-sleep-hibernation-fixes-v1-0-51fac96d080d@oss.qualcomm.com>
 <20261102-b4-pm-sleep-hibernation-fixes-v1-2-51fac96d080d@oss.qualcomm.com>
In-Reply-To: <20261102-b4-pm-sleep-hibernation-fixes-v1-2-51fac96d080d@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:46:09 +0100
X-Gm-Features: AclHuK9v-Z2mRtAMjRJcbnHzQlkhFHOVGuw0nJq8MItVFsL3rwXN4A5fUjGnABI
Message-ID: <CAPx+jO86pgUXuHMPKAMKN6Tq9unxnpd9kB8eE9byZw_B=0xxyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Do not arm wakeup IRQs for hibernation
 freeze and quiesce
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX1d7FfMX7D1M0
 L6VLYKDmEUhV7CCySNp4v3rIFvjLfDma6gTolb8VMh+H1T88WaIcM8mRHD53W4JjZ8xJmcBw4Ao
 i499IB6izqKpl+pJBRymGiIiSduqQB42jnYYRsePBiYUmqMo4Kg+ZpZxkHBuNv+mnAewtlpMGgH
 +H0MvTC8MMaToJcSJF45JLdg/xTFX05L3yQeU32tsY+rBoF+FmStaNBrD4qbsLCxZRQ/mBsrz/9
 CGMD+TkqZwSll/rP6NEmf2DHUaeO/YmbmIDSUQ7kRmnvCYNqY3LG4gStu+PQQEVcfL/OC6IhOFq
 vklYk9itQwIWf+gD5JPnMMKbGbbA3gE0hmoswhuf9w1B2ozC7VER3juihy18yfxLiTAOMnGSKtF
 xy6ulV0oHU87R4yBjpFD8l5I5xDSs5pCDGYwsTaB4WUth/Dlu6cdlQJ3xoT8fCdUgY5pCxr5NRD
 0CkHQmfOe5R5NQwlGzg==
X-Proofpoint-GUID: pZxWe3P5wnjsgZaWQsjDzD-84TXoLFX4
X-Proofpoint-ORIG-GUID: pZxWe3P5wnjsgZaWQsjDzD-84TXoLFX4
X-Authority-Analysis: v=2.4 cv=F6fC5ahN c=1 sm=1 tr=0 ts=6af5c32e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=khUPejFFGLYla_ha6IwA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX39G5tIH8gsoW
 tYvA7adrKo6B67Ql5jQEc9Px+mSkrv+4G3ZsVIbydVz+qqeixEDjqmYoVynpDgOAqFTzMCVF+91
 eBIlNxFxV6AxEgGKQCUpvpV330WlgIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054

On Mon, Nov 2, 2026 at 3:47=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> Freezing devices to take a hibernation image and quiescing them before
> jumping into one go through the regular noirq suspend path, which arms
> the wakeup IRQs of all devices that may wake up the system. A wakeup
> IRQ firing then aborts the hibernation or the restore:
>
>   PM: Triggering wakeup from IRQ 180
>   Wakeup pending. Abort CPU freeze
>   PM: hibernation: Failed to load image, recovering.
>
> On a Qualcomm Glymur CRD this happens on every hibernation and every
> restore. The WWAN modem keeps asserting WAKE# once its root port goes
> down, after its driver has shut it down for the freeze, and the WAKE#
> GPIO of a PCIe port is a dedicated wakeup IRQ with wakeup enabled by
> default.
>
> Neither transition is one the system can be woken up from, as nothing
> goes to sleep, and Documentation/driver-api/pm/devices.rst already says
> that in the freeze_late and freeze_noirq phases a device "should not be
> allowed to generate wakeup events". Do not arm the wakeup IRQs for
> them, and only disarm them in the noirq resume path if they have been
> armed. Wakeup IRQs are still armed for the final transition to sleep,
> PM_EVENT_HIBERNATE, and for suspend.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

This seems reasonable to me, but I can't judge from a reasonably brief
review if this is the proper place to fix this. Rafael, what do you
think?

Nevertheless, please add:

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 16a1f017051e..34ba0e5941a3 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -949,6 +949,9 @@ static void dpm_noirq_resume_devices(pm_message_t sta=
te)
>         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false)=
;
>  }
>
> +/* Whether dpm_suspend_noirq() has armed the wakeup IRQs of devices */
> +static bool dpm_wake_irqs_armed;
> +
>  /**
>   * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
>   * @state: PM transition of the system being carried out.
> @@ -961,7 +964,11 @@ void dpm_resume_noirq(pm_message_t state)
>         dpm_noirq_resume_devices(state);
>
>         resume_device_irqs();
> -       device_wakeup_disarm_wake_irqs();
> +
> +       if (dpm_wake_irqs_armed) {
> +               device_wakeup_disarm_wake_irqs();
> +               dpm_wake_irqs_armed =3D false;
> +       }
>  }
>
>  static void async_resume_early(void *data, async_cookie_t cookie);
> @@ -1685,7 +1692,17 @@ int dpm_suspend_noirq(pm_message_t state)
>  {
>         int ret;
>
> -       device_wakeup_arm_wake_irqs();
> +       /*
> +        * Freezing devices to take a hibernation image, and quiescing th=
em
> +        * before jumping into one, are not transitions the system can be=
 woken
> +        * up from, as nothing goes to sleep. A wakeup IRQ of a device th=
at
> +        * signals for attention once its link goes down, like a PCIe end=
point
> +        * asserting WAKE#, would only abort the hibernation or the resto=
re.
> +        */
> +       if (state.event !=3D PM_EVENT_FREEZE && state.event !=3D PM_EVENT=
_QUIESCE) {
> +               device_wakeup_arm_wake_irqs();
> +               dpm_wake_irqs_armed =3D true;
> +       }
>         suspend_device_irqs();
>
>         ret =3D dpm_noirq_suspend_devices(state);
>
> --
> 2.54.0
>
