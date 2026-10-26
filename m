Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976021;
	b=5NJxB5Emavgquev71LD5Gw2/zcwnDLYp2LCw6CwwMce9mMich8ixiwCgB+jbUsvdbNDz
	 7Z8YcvFtJmFa4FhIFmp3Kcrs4e/UF0Du1NSQlMyygvL/sLl5ZY5cXzk1aVkeXso5UUmHV
	 TiONJU7dUTGzxs+ipYpQnbRV/pw72ALzZIbZXa8OXykGT2C7HFyXYH27gPfGj3qcqO83N
	 pDyirDfGU14Isn25I4x1o7/GHckX6V9Ql3sMiVpdtL/1tri+aQv4dU+R1qwyossXjAYQ/
	 3TfdO/W/kf+1aEkQU9j2Coli2sH0BbEuX9LEDsRtWPFp0fSsU7EbQpe6eHQPDsYTEkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1CFnm7wSorQu4xILRSQcq+VwmU0p4yxg5DP/r3Ep0oA=;
	b=D8E3xZeywd/OXfQAUv+hTGj0Kp2Cc5YhK6/OM758jxFg5AlBZVWVPOX9zVpPuECYuNC4
	 xQtbKm5LbyvrjCE+4xTApzoEJHy5+G2heMcR0ZLEFOtu0EYSPxBDwXT108KS1GjUNyHfP
	 yYvoEozM+m4UZmZ/eYd2gmKreOXE+crH7/bkugkphOkQjn0M6GaSLiNnGhvJlWLEDoBGq
	 UYWMy/pwo/Tu469DCmoiyx8EUfI/y7f1i2Nj73l8Qy03m5kXwT2VMeGyxVcRgDHxW9rU/
	 ICNvVesy8nZRkR7p5XPHFmYFnlS4CxPoE34PDSTme0DD1klPgQ4a0Femn08e18iydEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5IH9FKR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1856606A31B;
	Mon, 26 Oct 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5IH9FKR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A361F01825;
	Mon, 26 Oct 2026 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792976020;
	bh=1CFnm7wSorQu4xILRSQcq+VwmU0p4yxg5DP/r3Ep0oA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a5IH9FKRitSom1EYbCCpvJ6PU9ONaFfvwNFIHwanCLJzm9/vaObxyFXdlEdz7+Tj7
	 Vgropo5cXudT2jFzKWrcjHUvELHR5z7GjvyPjAukx7VVQiWEep3YTZdHwP2AJfh9LN
	 hdO9mpu5sXrVsLpEXbMp0v9zB5xkHnWHcjIHGzoAKug+AwYjUpMMwAfpPRnZmSgdD2
	 Q20QkAgtxv3pZEVF9t10oHoYuwvK8yuxT3vDSCO/AVjH0uaymysR6eI7Z6WCsv/nH8
	 E8JXo+bYCZ6gd0Z6HWZzEiuUuXC774Qr+sFgf60qZ8XjKiZGjiQpLAW314xfQRXR6L
	 A17PhOZ9CUAuw==
Date: Mon, 26 Oct 2026 00:53:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/17] iio: light: us5182d: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261026005333.7d8de0ce@jic23-hlaptop>
In-Reply-To: <20261021165858.v2.17.I2a58d2ac56600e492fd431e173bd0d67f180c6a3@changeid>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.17.I2a58d2ac56600e492fd431e173bd0d67f180c6a3@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 16:57:18 -0700
Brian Norris <briannorris@chromium.org> wrote:

> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> For this reason, modify this driver to simply discard the
> pm_runtime_put_autosuspend() return value.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

For reference, the power control function in this one is:

static int us5182d_set_power_state(struct us5182d_data *data, bool on)
{
	if (data->power_mode == US5182D_ONESHOT)
		return 0;

	if (on)
		return pm_runtime_resume_and_get(&data->client->dev);

	return pm_runtime_put_autosuspend(&data->client->dev);
}

So there is that bit of 'special' at the top. Honestly I've not
looked at why that is there, but for now I don't care - the
change proposed here is sensible on it's own plus removes at least
some of the 'special' :)

So applied to the testing branch of iio.git.

Thanks,

Jonathan
