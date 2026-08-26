Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B107282F29;
	Wed, 26 Aug 2026 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709494; cv=none; b=M1KTvOFt7Ukbwzcrlsa7XMbf/wobn6mkUf/BZHJSXUPnpz5JJEYMaeB5d54PuWm5x6S5ejRtWMKI3kvftYAFgMumCCZlzDegGIwsOIyl3XfB3gO2Rk3Wr5Wu49D1fEQ6SU/kfNAxup/5mNxmvueoR6oiKy5CchajTvTrsJcW6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709494; c=relaxed/simple;
	bh=zqGQdb5xjVKoT2Wepqp46r0jz9RawPteE1AYX4v9uX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKmRVRb8GVX4qdICyC+vs/9s+hNUIXhKpUy46mAa7uEkdK+FQNyDUgVXWBQ5T1sS5TH+sg4SR/2SKnUSkaK5IQudKzcNl/qfcklJCtNMAj1k32GI3VyD8geUT693BSQ4FO7ggGxE7pzgZr6g1hOtA+Y3wgyE2rKEeaQG80k0Q1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzF2TgdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzF2TgdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6381F000E9;
	Wed, 26 Aug 2026 01:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787709492;
	bh=2eaMDZynatVenQeRYu1yqJyDeSsoG7n6E1bnn4mURms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QzF2TgdP5kaTIGwbqYW99ncbWGqFc3JWQFmRqmoc7SaHVM7DALmTK4TOahFLFg9zQ
	 gwJ7VAs9Z6NlwBwVH1OEXbeIb9grhCxjPTQVMa9GOAzvGiPW3c3rsTfqfvsBDZHECg
	 uYG+c+V1nkE3GTKvIRZQIyLAXf4U4mlyfo2qH4bLgJmJZ2HPxlwD4E9bJIWA2UdcW6
	 htnDIqPPa1+K+CSAL2CcrIjj1Sjq82HYpzw+4jjJw0hYNaPZdMIIq3Sq/FEn7vVX26
	 Y13XCvfqiXSZvcwaD6NrxYEMwfOMd0WyZAUWyn0UaupWvv41mEroauw/I2lU4qUXe5
	 HeloTTd6dZRpw==
Date: Wed, 26 Aug 2026 01:58:09 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Matt DeVillier <matt.devillier@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cros_charge-control: adopt EC charge
 state on probe
Message-ID: <ao5IMfqCOlrTBv5E@google.com>
References: <20260824155736.1186510-1-matt.devillier@gmail.com>
 <20260825120929.13168-1-matt.devillier@gmail.com>
 <20260825120929.13168-2-matt.devillier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825120929.13168-2-matt.devillier@gmail.com>

On Tue, Aug 25, 2026 at 07:09:00AM -0500, Matt DeVillier wrote:
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
...
> +static int cros_chctl_init_state(struct cros_chctl_priv *priv)
> +{
> +	struct ec_response_charge_control resp;
> +	s8 lower, upper;
> +	int ret;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	/* v1 cannot report current state; force a well-known EC configuration. */
> +	if (priv->cmd_version < 2) {
> +		cros_chctl_set_default_state(priv);
> +		return cros_chctl_configure_ec(priv);

Given it has introduced the label, how about:

    goto defaults;
