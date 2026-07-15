Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69A3218BA
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117431; cv=none; b=aM/SbbnDyc4d4DctukpVJokSSFZxyAgfNc10SAsKf3nscwvcn8zZSt6kLsXYwNVK7ZKEhh9/IEnBfm/RVgJVcDKZCOVB6xGkCSL87nQFFYzGdxmCusuTcwVQEqRSY2i+hb1SLk3GTqAoqPWUw1aqqn6W0+JLHrkywKu8x0v7sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117431; c=relaxed/simple;
	bh=PYNLDHGO6ov8H5x5qqX5IZL4rw+a3BqAyT9tBi7RhC4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJpvhtFgu/cyBapjOkI5B2akZgqnmeilcFvV38csPogO3Tj44LsHn1HoyU63srPlESrNQeGVmVc06FgTweTjsXazTYy6lIFhooNIg/wRl1+pexTdEFdLhgk3Z/TkOsO+CyJm8cbZEkHh9vVKmtt1DxuHdE7zPpcEI2f0kqbQHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q84hagRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q84hagRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D8C1F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117429;
	bh=DMCjy06zEXDnbWum2gCuxx6nJG7pOKzGSJuwH+iOivg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Q84hagRT5mPR6Sg5DtuRlLw+qHQbfE0zv769VXXV9fdXQpiVBljonlJJa72YMpf7y
	 iYZKdHDeOLn8CpItSXEjn1bhf/D4qCsfnSPEa7/PTcNChMqAhAqIRMVv6IPYnjTWNf
	 f6fX48BpqcIK+ON+887Wu4FNF344byUQrM0B06tKW0vZac2Mc7MOJY+3WBJGIbOU+Y
	 s+XfEqlz2dR3TJcJ/wfD5eHKBMjk+CX2g65Qv7jgY9vFpJ/lCvVHcRqKIqgqNj8AG2
	 O0InDdM9pynSkxccpuvAM61EcsTe+9yFBOyTSh9Ps6BNkic3e+7+aR0leWcj1IPoJc
	 1hyWYWU7Tv3Eg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aec201b582so5151192e87.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 05:10:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RquWKgkVqJIaMmH5C/aBlHGhQCb0GeZNX4P+1GY6l8zUmLlTM1R5QKj0dn9oo3NaaALQicWL30I8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx1v2afD6ROnh3zU5aL+lY3GkdNB2yMurOi/EvxusPS7bKHIn
	l2aPnXurzqWp9oTEbQ1wkZMbv8fuWMevj/NxhYIT5SCsgMRI2GPRv8/rcMi29/xUdqg+zlaCQJB
	pTkmQUeP6LU7YFUL+kmZN3Rxm8xDtLerwEmdCBzOm3w==
X-Received: by 2002:a05:6512:2507:b0:5ae:bcf8:e7d0 with SMTP id
 2adb3069b0e04-5b15d7baf00mr578542e87.55.1784117428284; Wed, 15 Jul 2026
 05:10:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 12:10:26 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 12:10:26 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aldS3qTympJuVXYj@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-4-wenst@chromium.org>
 <aldS3qTympJuVXYj@ashevche-desk.local>
Date: Wed, 15 Jul 2026 12:10:26 +0000
X-Gmail-Original-Message-ID: <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
X-Gm-Features: AUfX_mxpntQH8Qnw3cJ2vX6VfUBu9N4HciM9BCR-9eipAChzpXbQ2rXlvYEnYl8
Message-ID: <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 11:29:02 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Wed, Jul 15, 2026 at 04:53:33PM +0800, Chen-Yu Tsai wrote:
>> The power sequencing consumer API already does power on state tracking
>> internally. Expose the state to consumers through pwrseq_power_is_on()
>> so that they don't have to reimplement it locally.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
>> +/**
>> + * pwrseq_power_is_on() - Queries the last requested state of the power sequencer.
>> + * @desc: Descriptor referencing the power sequencer.
>> + *
>> + * This returns the last requested state of the power sequencer.
>> + *
>> + * Returns:
>> + * On success, 1 for on or desc is NULL (optional) and 0 for off;
>> + * negative error number on failure.
>
> I would rephrase it a bit.
>
>  * On success, 1 for on and 0 for off; negative error number on failure.
>  * If desc is NULL (means optional) return 1.
>
> And this rises a question: why 1? Shouldn't it be some "unknown" state?
> (But since Bart Acked this, this doesn't prevent the patch to go, you
>  got my tag above.)
>

No, this is good feedback. Maybe we should prefer an enum like so:

enum pwrseq_state {
	PWRSEQ_POWER_UNKNOWN,
	PWRSEQ_POWER_ON,
	PWRSEQ_POWER_OFF
};

Bart
