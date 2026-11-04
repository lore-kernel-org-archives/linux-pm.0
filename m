Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829345;
	b=rLRsRyvOfm3iFqy8hL9s1TCFPbNZQl3Ae/CiyeFU3j8TpNS79lAgn0GJIwDFFXigoZK4
	 WnN+sok2z9K9aZOdHXuJzndQ0GNojsBcTgp+bstUL7mLKPrNt973KBHSE+dWjKv0+4Z4j
	 JiBDymzkrVuKCpd+ATRttmRmsJmPuObuc/nUoNyO75n21gCgKYWTo2vEIooZ3VuNNPsJy
	 Qtl1jalxJQt/WydMhyRYnDf3A8oHPdAoGadvo306FcfGkRFzj5Aar6Sm3kR1MeZ+jN8sw
	 yHGepP/ttWUrPucShtZ+GBsQNGxdIylpV5rQPVkabpFZWb9/gbaugblNutUX7TD4xKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829345;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=1KM15pS674xkwzoKzXbfoGMlVw+mkKvC51O5xmcBcQ4=;
	b=t0hlo8Su6lomWJQzGd5Nqf93NnCFkZGN/E4qEFYkYo58I5M1xYL/Q0GmuGDY7G/kXQta
	 CMneGgDo2QQn5xGf+UEVPpZ4248MSEhr4/8wn6iOyGyV8MNPgckEOn5mT67SeecdpXZQq
	 BLnondLiFeJKxjVaxRxOA6JIJ4+xuHYTyee7Ar69cAoZna+/7aPudC/yw85sA8NHWI1QV
	 V2cTDK7LazoKN70nLEvnry9peKwrKCS789KT6NjushurHNEcEll0TtDw92/7GV4eq2+5H
	 Pt2RP4LaQ7ffmtHIEf2uithoCC/I/4zR1aH+x05FJ2m2udkKB3rnl5RJ/GTSEUj9mdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=h6Zhmgkl;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E560A5BD2;
	Wed,  4 Nov 2026 21:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3E560A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=h6Zhmgkl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKfQ45tJbzKmTr;
	Wed, 04 Nov 2026 22:55:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793829340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KM15pS674xkwzoKzXbfoGMlVw+mkKvC51O5xmcBcQ4=;
	b=h6ZhmgklkVRwYt1n9X/n8y/F+89/7eFCzwSd2uXk55wsQ90Ro6crnRQRb1W+/3wBdTgGDs
	rCgkbMrz+lPdFeq24VLUNk86fQWkG/Qmp6KRJki29gFw+aDzt0BI8/eGO4DfWF53mgQ00F
	Vvtx/YuT8JfVPVJ335jZeVFTJMhxMS42kLvwZcgTlLMKk0LyIdGepefjq/dY3M4DDG5hHI
	ls+7WPGd5m0yNMYTHmVUO2Wherq54OuGJFTmtAuOPtrmGN2wy+kpaCmxF3cjZ8PU9+jfvm
	S2Z82043mZWjhHxFE2StoOuBkYEgjH39Nnh2b8Y0RWgBlymNfCmoHckwWGJ6/g==
Date: Wed, 4 Nov 2026 22:55:35 +0100
From: Anthony Ruhier <aruhier@mailbox.org>
To: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Amir Vajid <amir.vajid@oss.qualcomm.com>, 
	Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
Subject: Re: [PATCH RFC 07/10] PM / devfreq: Introduce the QCOM SCMI Memlat
 devfreq driver
Message-ID: <auukrIsbbd3q-qh-@tour-anthony.aruhier.fr>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
 <20260724-rfc_v8_scmi_memlat-v1-7-cb732bcff1f4@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-7-cb732bcff1f4@oss.qualcomm.com>
X-MBO-RS-ID: bdc02223a3e50c9f112
X-MBO-RS-META: 5mbzo6rkf8d9aucpqd6mxur6iz7r7xd3

Hi,

On Fri, Jul 24, 2026 at 12:48:12PM +0530, Pragnesh Papaniya wrote:
> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> +	for (i = 0; i < info->memory_cnt; i++) {
> +		struct scmi_qcom_memory_info *memory = info->memory[i];
> +		const struct scmi_qcom_memory_range *range = &memory->cfg->memory_range;
> +		struct devfreq_dev_profile *profile = &memory->profile;
> +
> +		/*
> +		 * CPUCP re-evaluates and re-votes at most once per cpucp_sample_ms,
> +		 * so a new operating point can appear only that often. Polling at half
> +		 * that period guarantees each distinct vote is observed in trans_stat
> +		 * before it can change again.
> +		 */
> +		profile->polling_ms = max(1U, info->cfg_data->cpucp_sample_ms / 2);
> +		profile->get_cur_freq = scmi_qcom_devfreq_get_cur_freq;
> +		profile->initial_freq = range->max_freq_khz > 1 ?
> +					(unsigned long)((u64)range->min_freq_khz * HZ_PER_KHZ) :
> +					range->min_freq_khz;
> +
> +		faux_device_set_drvdata(memory->fdev, memory);
> +
> +		memory->devfreq = devfreq_add_device(&memory->fdev->dev, profile,
> +						     DEVFREQ_GOV_REMOTE, NULL);
> +		if (IS_ERR(memory->devfreq)) {
> +			ret = PTR_ERR(memory->devfreq);
> +			memory->devfreq = NULL;
> +			ops->stop_activity(ph, NULL, 0, MEMLAT_ALGO_STR, MEMLAT_STOP_TIMER);
> +			return dev_err_probe(&sdev->dev, ret, "failed to add devfreq device\n");
> +		}
> +	}

I tried it on Hamoa (Yoga Slim 7x, x1e80100), loaded scmi_qcom_memlat_devfreq,
and I see the apss_cpucp_mbox IRQ firing 3100 times per second. It raised the
power consumption while idle, screen off, from 0.9W to 1.4W.

The polling seems to be the issue, as I didn't see hectic changes of frequency.
Raising the polling from 2ms (default) to 20ms makes the power usage goes back
to around 0.95W, with ~150 interrupts/s from apss_cpucp_mbox. It's still higher
than with memlat off, but it seems to be a better trade-off for now.

Can you check on similar platforms (hamoa, glymor) if you see the same issue?

Thanks,
--
Anthony Ruhier
