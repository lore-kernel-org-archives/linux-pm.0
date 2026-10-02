Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549146DFE5
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932006; cv=none; b=jIskadBC8isuB804jKPE4A1GznYBazwYjje3LtEBN/f6Qs6BmFa8zV2qlVItbvZhINPAfCSdtDL4n0tzmgHdgpY5IerKEwBeSAp0Pmf+OAwWSkUK5LTmnPjT4cGV/ltF7kaW6eAW2TlUGxAFEEgOQU8qmp4atTskgK7jgWspoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932006; c=relaxed/simple;
	bh=kDMZJFIYNLpENyTsWhs6Qg3bWlNKfFJpixhYOyF9GVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee5YLiQqcNXix0SK24SO7e6o+uQaFrPA8JJ0yFwNZRkKpI2fdWgmYZjKESarEsXDDQGUaVyJ1g7+ouIIfV14f+gy0DSao17oXslSlbm7M23NwLUT+odPkWgRp4VJCvRzCcnp+uyOdNNlFAOp9RAViPpOBPU1LaOfA68zPwi9Rw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rn+ZlQ8Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X18a3gem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rn+ZlQ8Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X18a3gem"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925jepD036688
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 09:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m3e22T5Ei+HeBmJThbj0uNqY
	cEf7ihFqents8vMEUus=; b=Rn+ZlQ8QldP1jrxGM5PRYz24yepuy89350RsrrWc
	Q+aRe0f+9wBE9wOepUkA/3d5FOWJpLF7XFVuRlh5bv3ob2BtYM0DjaqNjRYH3lVt
	puvCftbFgiokSzf8xvTx+7nCsxR2VpnwE8d7NAbCyrLRlAAITRBtSIe2EVEaJFuD
	c95xQ38c+5Hpnt2a0koWxSUeJLPd/ipguvFm+7i7KswIQD9q6AC9gOsQbPyrnf6Z
	zZJzgMDC6H3siJKLnHh+keIliYFyhGUsIEI+DZ1ofEAceIxtPfeWztOrI6xECqNM
	JKkhdsbnxx6ZFN05jkR3zw5uuSCdxVMmN0bypEw+aeOurw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tbgbbb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 09:06:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc40759b2so203802285a.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790932003; x=1791536803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m3e22T5Ei+HeBmJThbj0uNqYcEf7ihFqents8vMEUus=;
        b=X18a3gemGfmDU3M9j+Icv/ggKoQ5ynMXw1a4PYZtMvwwmUYFow5n56unXbUdk2wg+f
         WzTYI7GK9w5Eihn3owFPgipa8Y+B2OzIpcrjNdn6uoKmLNwLBWhA2vqRYMPa7rsF1Lfj
         ph79E6KxjA6ku6+3/WueplmSi+QavuGuf3xwWQjtklq0ke7kPvJnKsl/42BB2ukArOrh
         pIhXSanI89Fb2vZkgnMwguWJTc1nsiF11VzAoj+e7qppEN0t/sK5iiA5AT4Zsiy9mIBS
         l6v6R7rQRu+Wse3GSOOKPMPfYHxgqdwxv3OmiknFA0DtC8DaGoHWK11OeMnMnEAMg2dp
         RUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932003; x=1791536803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3e22T5Ei+HeBmJThbj0uNqYcEf7ihFqents8vMEUus=;
        b=I/p5xP9Tt4xDxtXaS+qGK3z4wVd/bIpMWbS3H0IReXWGfiFVI0E67Lp9Hb4bzV9dRp
         LyRkNsJyMOJedmy8pI6Iiuad3aTkrFep2hPAkw1UqI6ljVOXTpBHSNzqhnMmwMfi6qbI
         Gn5Qigd7TRyTlVRHHVy0jaZRw+9OA3dK/zenOHi/xRYPhQBYOFOjIo3zN5Rvs1vZczTs
         DzogTFL8sEtr1oN4qW0Qddhj4rKcxE+e57N4waEMSRqNRy2VMF/Qlue9isRD48uEPAx0
         AUkzbEKj8kD1xSOYD8JoI3xsvSdgU2Wa8BfCThnVY+kEtoW52iBF7+fdlbT5BhHZD09s
         I0tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJAqmJUVtW/19/5lEaw8t6eRDh34w+4jcUrmqd1aoRTpIJbQYvm7LG/O2HaO6/Krz8TEfBPt8ceA==@vger.kernel.org
X-Gm-Message-State: AFuF++lYkuHFtuiMK+rzRbiDkgkPvNlDk7+U90As/sD6XYZ/J5vnIGEx
	DCJXVG0bSRguPGwi3HVBePlAkjm4MItnaEZ9SapbtkG6yGuc6lQv1YohmnujwJWmwWloI5ctYB+
	dVoCwOufq2gYNlgqSuSqF3sIprWBx8RGws/oPjwapBt0NMLgDlq2EUmMlDEfLkw==
X-Gm-Gg: AYBFou3i+b/PVO6F18Qtaco4HalPGcEO5JJCUdZw0+9Z37JmkWX+r/8mFFyRZJNUNZC
	5VyJ+9gZGv33p9KX5g728WCztg1e5cBq5K/VefVNMiRB+a2O8xaxZoIoLMCKVV7Ef+OGrgFuvpr
	zVEJFwIXE7gylR3P+hvdAtKfLRWLbh2W8LVUGjIF8tPpXYupRnfZlf5OY4dHnJjw+q3EwveCNt3
	IKT3oKtKdW7kfuARqmJhOmj1gWicCLxO1AnAYGUz7P/UflCgDgfkmpQg/RVNN4sxa9t3LonvAPM
	kpxXPDDUK8NfKvxcG1vjOMgU1EPEd81J0JtcvWfk9iWAhH9gERU9N76Zbr5enliksBrS1+/nTOT
	nGQL4dp7kWCxQ70zgE/dC
X-Received: by 2002:a05:620a:8804:b0:93c:612e:9b51 with SMTP id af79cd13be357-93cf18a7807mr337157885a.55.1790932002644;
        Fri, 02 Oct 2026 02:06:42 -0700 (PDT)
X-Received: by 2002:a05:620a:8804:b0:93c:612e:9b51 with SMTP id af79cd13be357-93cf18a7807mr337153385a.55.1790932002076;
        Fri, 02 Oct 2026 02:06:42 -0700 (PDT)
Received: from mai.linaro.org ([2a05:6e02:1041:c10:f14c:b716:c104:4712])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03950375dsm22387125e9.1.2026.10.02.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:06:41 -0700 (PDT)
Date: Fri, 2 Oct 2026 11:06:34 +0200
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Francesco Valla <francesco@valla.it>
Subject: Re: [PATCH v15 5/6] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <ar90GoaxTV8pjonY@mai.linaro.org>
References: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
 <20260924-pscrr-framework-v15-5-7af87107e0d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-pscrr-framework-v15-5-7af87107e0d3@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNiBTYWx0ZWRfX1hZsr/sE0Nkn
 FgUf/H8z84RsAwyqdCla1fimHx1o3wDSDY3AEUkM0z3l8/gW+BYIga14au/QiDfTX83fLM8gTCW
 8mMU7qqe4BYDw17zNquq/1Qpak0n3lM=
X-Authority-Analysis: v=2.4 cv=QY7zLcbv c=1 sm=1 tr=0 ts=6abf7424 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=wJk3McD_gWb6CrzzaM8A:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNiBTYWx0ZWRfXxTUAwqb1tWTo
 0D1MEDif6jCkDsR+ety7pYNYPw30pFWrn8Ol9T7nYx1KmPvHczGtX2TliEqY8mXgSBGuDEgScQc
 tt8CXxvkG+xghTeIJowSLO4DEwBAHLieTfgCNPe5MPpAJRFpv0J5NdKe54b4XFXQByXhEYHrkyG
 UM93kkilMy0KCejQ9YQaTp7C4qGB/vcGAdC+syImUepbWIFIDAgMGObGpp/W2x8u2g8rRA29Fz2
 5hVezrJtuTyKcsF65NPNnJskaj5DX7LRBeLHVJVmwvuxxio/qkPKVBgJ6uj7FQqN5Peab21696D
 sQpupRZFjxELtYewjolVMrW+KXvKizltoFdhHmjqFLp/fDUpA0H4OL01jskBHmP/hLWaugTtFvC
 c5ZH7eo0adce1vWCCniNxbOBpfJ/svVTk4miea1/gpdebCoh4sqrtn6pOOhmjaSJvdB3+obAD5B
 GlMD5nf+qEryxBI0cEQ==
X-Proofpoint-ORIG-GUID: YvXmG5CLFqk0uZ_Qsd_-E8qG57mh0fdC
X-Proofpoint-GUID: YvXmG5CLFqk0uZ_Qsd_-E8qG57mh0fdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020036

On Thu, Sep 24, 2026 at 12:38:46PM +0530, Faruque Ansari wrote:
> Introduce the Power State Change Reasons Recording (PSCRR) framework: a
> generic mechanism to record why the last power state change (shutdown or
> reboot) happened - under-voltage, thermal, watchdog, software-triggered,
> etc. - so a postmortem reason survives a reboot or an abrupt power loss.
> 
> PSCRR is built around providers. A provider is either a hardware reason
> source (a PMIC, SoC reset controller or watchdog exposing a reset cause)
> or a recorder that persists the reason across a power cycle (an NVMEM or
> RTC scratch cell). Each provider gets a directory under
> /sys/kernel/pscrr/providerN/ exposing its name, backing device, the set
> of observed reasons (as tokens), its capabilities, the reasons it
> supports and - for recorders - a record policy. The reason set is
> deliberately not collapsed to a single winning cause, since resets are
> often multi-causal.
> 
> Reasons are the numeric enum psc_reason values from reboot.h, shared with
> the POWER_ON_REASON_* vocabulary, so they store compactly in small
> battery-backed cells. The current reason (get/set_psc_reason(), set by
> the thermal/regulator/hw_protection paths) is written to every recorder
> from the reboot notifier.

[ ... ]

> +menuconfig PSCRR
> +	bool "Power State Change Reasons Recording (PSCRR) Framework"
> +	depends on POWER_RESET
> +	help
> +	  Enables the Power State Change Reasons Recording (PSCRR) framework.
> +
> +	  PSCRR records why the system last shut down or rebooted into
> +	  non-volatile storage, so the reason survives the reset and can be
> +	  read by the bootloader or early user space on the next boot. Reasons
> +	  come from software (thermal or regulator hardware-protection events,
> +	  a watchdog pretimeout, a kernel panic, a controlled reboot) or from
> +	  hardware reset-cause registers (PMIC, SoC reset controller, watchdog).

[ ... ]

> +static int pscrr_reboot_notifier(struct notifier_block *nb,
> +				 unsigned long action, void *unused)
> +{
> +	guard(mutex)(&pscrr_lock);
> +
> +	/*
> +	 * A reboot, halt or power-off that reaches here with no more specific
> +	 * reason is software-initiated by definition. Record it as such rather
> +	 * than leaving it unattributed; a real cause set earlier (thermal,
> +	 * under-voltage, ...) is already latched and left untouched.
> +	 */
> +	if (get_psc_reason() == PSCR_UNKNOWN)
> +		set_psc_reason(PSCR_SOFTWARE);
> +
> +	pscrr_record_current();
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pscrr_reboot_nb = {
> +	.notifier_call = pscrr_reboot_notifier,
> +};

I'm worried about the mechanism. The call to set_psc_reason() sets a
global variable and pscrr_record_current() write its value to the
NVMEM backend.

That is done from the reboot notifier.

Is this notifier called in all cases, eg. watchdog reset or emergency
reboot ? It sounds possible the reason is set but then the notifier is
not called thus not written in the non-volatile medium, no ?

[ ... ]
