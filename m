Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2033C1413
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624931; cv=none; b=Ec162cDnyuemvYZtl+PXcIg3FW7qMsFm3cRyJ8bEI7VBuiqQXZBW54WXVByTFfj+CuErZRsWCwxVgMyajycEVcTZ6hj5/ZTh8Wvg17m2rn05+GSi1XznSXeZYkTGauEXN+p4FT+WJcgQLd+g8xIQ8YvmevRAnCnrdU3W3/Gee5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624931; c=relaxed/simple;
	bh=LWQhAMESFWDYUhOqi0N4NltBuuvLqrOk9w5ZbaPhgTs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRaxfq51IsWrNIt+Nag+Emyi8uLFdzoco9vIONJHQ07UPp1hvGM7QPSrunr1GFZBY85QaBuh3yhuht4MqVwY6KeXJ7vAUz++43aaU2qFp5oLMi8ELX5cq5mYGlSQv16vWPBStCcvufT2HtWdffKBY5P+q0BHbARY2g2wwXZkAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2rKA2Qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2rKA2Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121081F0155B
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624930;
	bh=3xqu6DOCRis3ts8JU1eK1hQauNPqKuaV4g+S3+L3WS0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=e2rKA2QoRAl6qUhMs9hQ1Eem9usUIBCUP4Q+OaZ3u0if2/XZI9Lioxy0NBFyDPryy
	 S8S5SeBLBgooqyplAkD00YNDXDjVV+kqgYF2g6JJ+ha+i2RCLuhpwfV3XAeBSd1O4s
	 Wj69Gm1/Wspw95I89hylmpns/qCqzELkR7ali+NjMd9pFZVuih/FtDIx7FM8NSfDNx
	 CvCxQDoIXGcegrKfYENKCPGlVIVdYtx6oNm2uYMuQ1r19juAwtZMVopvj1P7F3aZB5
	 hvGRxrcmxIt7Lf8kVkizYLhw+9XVTVP0ATFPuzHD+p6CxSpaXideDHYmVvzmyrzD/W
	 dDjs7PUlOlGAg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aea0fff535so8786295e87.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozXGEzOWxT8vQjWPeAOzib9b2yrqgTYVXFyyVdod6zu+NW60BAL0QGwgD3Hu3OP/wZSn8eIUgWLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxK0P40kLYO18Ok1DG8kDckY1uCzwZNLZlUcFGqYioJ0lQ0hMA
	E66qpfDcQ1vlfM3dFssHd9LqZVCG0kaTqkZDZS59HWGRDYnbpXs9zaqU3dXvZnNxkopKd/3U3cU
	U4L24w5F/Py1pMZPyrsOABN9TYalnjlU9COigvd8W2Q==
X-Received: by 2002:a05:6512:239e:b0:5ad:58c8:5de8 with SMTP id
 2adb3069b0e04-5b28f854e5amr3537391e87.1.1784624928719; Tue, 21 Jul 2026
 02:08:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:08:45 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:08:45 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260721065413.2306137-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-4-wenst@chromium.org>
Date: Tue, 21 Jul 2026 09:08:45 +0000
X-Gmail-Original-Message-ID: <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com>
X-Gm-Features: AUfX_mzwzLN239CObNW1gLp59KRlXCiikBTT40SGbitpk5WIVatni_t3viiU0PQ
Message-ID: <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com>
Subject: Re: [PATCH v6 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 08:53:58 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The power sequencing consumer API already does power on state tracking
> internally. Expose the state to consumers through pwrseq_power_is_on()
> so that they don't have to reimplement it locally.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v5:
> - Reverted back to returning -EINVAL if descriptor is NULL
>
> Changes since v4:
> - Make pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
>   the descriptor is optional, matching the other pwrseq consumer APIs
>
> Changes since v3:
> - Added missing stub function for !POWER_SEQUENCING
>
> Changes since v2:
> - New patch
>
> Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
> as it is a build time dependency. Bartosz wants the change on an
> immutable branch to pull into the pwrseq tree.
> ---
>  drivers/power/sequencing/core.c | 18 ++++++++++++++++++
>  include/linux/pwrseq/consumer.h |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
> index 02f42da91598..72b96d36920e 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -968,6 +968,24 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(pwrseq_power_off);
>
> +/**
> + * pwrseq_power_is_on() - Queries the last requested state of the power sequencer.
> + * @desc: Descriptor referencing the power sequencer.
> + *
> + * This returns the last requested state of the power sequencer.
> + *
> + * Returns:
> + * On success, 1 for on and 0 for off; negative error number on failure.
> + */
> +int pwrseq_power_is_on(struct pwrseq_desc *desc)
> +{
> +	if (!desc)
> +		return -EINVAL;
> +
> +	return desc->powered_on;
> +}
> +EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
> +

Didn't we agree on introducing an enum to make it future-proof for when we
also pull in pwrseq_is_controllable() from Loic?

I think this should work like so:

enum {
	PWRSEQ_STATE_UNKNOWN,
	PWRSEQ_STATE_ON,
	PWRSEQ_STATE_OFF,
};

int pwrseq_get_state(struct pwrseq_desc *desc)
{
	/* Only once this is upstream. */
	if (!pwrseq_is_controllable(desc))
		return PWRSEQ_STATE_UNKNOWN;

	return desc->powred_on ? PWRSEQ_STATE_ON : PWRSEQ_STATE_OFF;
}

Bart
