Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DB40C5CF
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680153; cv=none; b=svBM9sBOxnWGAViP1xpcm2Uh3uxsHTE89TF4nTaiTXR9ch5pvufFtrOj+A1QxExzCbeOxvq02AKJ4FwezkN/cn/K1z8ArAtMu5FidRZpIEPDCZhb2a32s4JDpqrXApL7yui7cS0Jh2e+Xz4jE/LwWewKLWRzZW3r4zbS4K1Sq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680153; c=relaxed/simple;
	bh=ThH+1fvwr0fKTcO6a7KsatsJI8sj4l9QUj8rdS8pUKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvjS1yVBj3TeD/nB4ur3QkKom73gm1c0SKa3AyDZeD45ahmKwDqCIVGtm0KfIKC8jwxdPn7WlmHT8JpCyBW5IXcU9VbN8IljVmWY2fhgNZzcBho+EtGLJ6p5UDQFl7fWfjr6DqrmLewK716K+sV6qFRwuYEMfm8QAVV6eLZVQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmonNfKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmonNfKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36DD1F00A3E
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680151;
	bh=6mXYoGljL4glCAb32pdfjdC0FVD85sDkej7+/p4xLXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DmonNfKdNgsD9/KmdaS4KxP2sh4owbptoEpZ4V1Cklu+saysNZ6+IcbfwFAKXqUaN
	 ngVaVnQG4tbWHthvHKGX+Rm+NG+99pRl/GfxsmGwkgFtFLBjrHOXYWNj83ajMO7FuW
	 mFZiLdjucRhBlHpClBw23Za9cOuyRW2pFMh2pMo4A1xe2z4D1OhnLuU3DkI+fOF9Yu
	 lyh0l4nF5ENf8IQI2eQyUIp1c5prSf6Wlg0Ru34SpZ1qClaEKT5sT6MWRrexUjnMgV
	 nUPSOKYpj3+xqYdKN5FVWb8QIxZvL0e+p3jxT8QMYRNHGnRXhMAALIOzveh7NKI+1c
	 NLwBJkwcNX7Ng==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b00d083818so1658152e87.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 03:42:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZI1hw2PHNSbX8zfDHPCL3e/Ka90oINkk6Jv5zrl2Nznnkpanwtxl8zzHbB7Qw4kDFpUvQl/1zrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnqH6Ud2SCjLjK98yDbScy/B/qiZ+xiTmfb+Aal+OeXWI7DfK
	LrPDZKvNrXnJ1a4q6qvH4TCi41gyzEI3oAA7R2rjVURR0Bw8mU2x5Bqg9EYKGEcKG1u3NAJKhBg
	nAWN6NVinivxQ8ujLQBqZgur/W4ZRsSA=
X-Received: by 2002:a05:6512:340b:b0:5ae:a500:e368 with SMTP id
 2adb3069b0e04-5b01c606265mr634149e87.3.1783680150375; Fri, 10 Jul 2026
 03:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
 <20260611-topic-lpm-pmdomain-device-constraints-v3-2-75d69438518b@baylibre.com>
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-2-75d69438518b@baylibre.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 10 Jul 2026 12:42:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h15XmucddczVn8b4=T1axydUPB6J20uiOLEk794mjsiw@mail.gmail.com>
X-Gm-Features: AUfX_mwkCv23HCzcyZ5VMFNMGeRxGkYRWKNWFBn6d9BcWv_zW25QkmHOvnjEUQk
Message-ID: <CAJZ5v0h15XmucddczVn8b4=T1axydUPB6J20uiOLEk794mjsiw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] PM / QoS: add lockless read for flags
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 9:59=E2=80=AFPM Kevin Hilman (TI) <khilman@baylibre=
.com> wrote:
>
> Add a lockless read for QoS flags similar to the lockless read for
> resume latency (dev_pm_qos_raw_resume_latency) which may be called
> from atomic context (e.g. genpd governors running under a raw spinlock
> or in the syscore suspend path), where taking that sleeping lock would
> be invalid on PREEMPT_RT.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  include/linux/pm_qos.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index aededda52b6b..439a9e779d81 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -219,6 +219,12 @@ static inline s32 dev_pm_qos_raw_resume_latency(stru=
ct device *dev)
>                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>                 pm_qos_read_value(&dev->power.qos->resume_latency);
>  }
> +
> +static inline s32 dev_pm_qos_raw_flags(struct device *dev)
> +{
> +       return IS_ERR_OR_NULL(dev->power.qos) ?
> +               0 : READ_ONCE(dev->power.qos->flags.effective_flags);

So if you add READ_ONCE() on the reader side, all updates of it need
to go under WRITE_ONCE(), or the READ_ONCE() may still not be
effective.

I don't think they are under WRITE_ONCE() ATM.

> +}
>  #else
>  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device =
*dev,
>                                                           s32 mask)
> @@ -300,6 +306,7 @@ static inline s32 dev_pm_qos_raw_resume_latency(struc=
t device *dev)
>  {
>         return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
> +static inline s32 dev_pm_qos_raw_flags(struct device *dev) { return 0; }
>  #endif
>
>  static inline int freq_qos_request_active(struct freq_qos_request *req)
>
> --
