Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB02820C6
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782709121; cv=none; b=daw3bwuYPxx+KDBtWnAI0Iv7n5/dJGIl0Rzth1nems/nuRIYE16HFx8hxtEzGWKJApAyvRz/kJkjc+fsiXUvuanPICa/YlOm3VQKlzr/tNcJhOZ5x23Yd+B6wo1YwGUktayDNlkhcyLFdLjmw9Nj3YsGh+hGNXX4SYba4ZpzmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782709121; c=relaxed/simple;
	bh=CIWzjM+Jxse1BycqhtYy2huv0CauD709CmJ9y4Fmpl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/J0AJIrMAuatNQMSVOqB2BlU4b42qmP/K1CSl3Mu40zuE6P5rKxIQtGOY7HvOJibPjNwHndJfarawtPsG6zZIPKRDJZUB0Qg+al4vqBTOH/mPVquysTmdRu/xs9LOIH403c7FdaOTBM64KGsV24WPNwmxVUw/CG1O8POtW+HXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ST3YUnkS; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ST3YUnkS"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf132969bso4139119eec.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2026 21:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782709120; x=1783313920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsB27okN3oIFcQCd02Iqvl+jQspzLnJ1Dz6viWpLCEI=;
        b=ST3YUnkS+Wj/SV0uuFZYGcDbyIWgG8t3yJFbf0rIhwsro8bVGUk95hZ2+tfu8fSEAj
         YniYLdh+UcHGaXzzJMoykgxhz28zp4JHZz3XCy3UdvP7I3Kb3k80ZdiuZ8zAVzp3Xaic
         C5pJ2wxhChqBUb165/z+EFP6CO0d185h5xd4C2oaMLazv2MQRW+UUXKEIQdWO0EDudoF
         AZZcuxpw1o9mI99vyiB452/rBWu9DV/gXu/d7OPSaiyz80+wLSlxOSJtPnwvC9WlgIlQ
         oJSVAysyVE6y/6Kwe2rpZ+84Hcok+PuNURRononeqjmKssexetIUQyaLg73OrhoV0o1O
         /rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782709120; x=1783313920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsB27okN3oIFcQCd02Iqvl+jQspzLnJ1Dz6viWpLCEI=;
        b=AtdNbXBmmqr1K6zE9Hz8ZQe/bMevIARB3iiFOKrcniFTIYDoc11vV7zhcbdqYiiGum
         X8dbcBRWERO8eV5O6A4o/h3/drPKxzK5B9stgwwWarz6VHCJ9vys+rgsMohfDHnyBc7a
         5eWJkCO/+rwzpfmtDlOxJgptH6gYl+nlBm1DMmD6HHydLre3N3ySezrRLlpvhvyDywJl
         l1QcVgneLVpo2G+wWglB7yjedcBGwm6SgAe0A3SI/NxWFyPYYOWpR2A8UAghCtbduXYY
         syzLAl8KbO7LW+k/ip5onzsj1SOCttMei0Nv3zxu9XQ/Q5M7ctEZrHaLjU7o2Bi0nrn9
         8GiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEU9r3/4W1XtPHiMZdFNU7pH9SLA6z7TB9e/Sb9KgNw82M3+CJX8VK43AMk78kZzBZNv9ZJ6LPAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/Nza285qUwhYE3d4th6+bELkV5SspC8ODdbgXtcAvdSASIbJ
	DBzDk6ZiVMdYZ+ElR1CJfa5aVwWNigSoBm+UuljmDrf74Ekd7hg/dqDqx7FVVeKI/VE=
X-Gm-Gg: AfdE7ck8Cwa81loP1bhtwEqpmI6eqz7XrfCZnOPnpGtOIdxwp3dCEkutt5B4tIib1Vu
	zHGOeFajps0fv94hsVNvt8E0jRY9ZWLjg2Bf1J34EF7MgVPl+dzcwjW1QRtZI4u7P1kNQVAf+gP
	jg61pV/Ru6YGQ6eY4on18EAbD4AAZRt6MqCQ68WnUQOMePzNE/I1md009puNh2EuHRRBJxtm5m5
	2lyKyLM1leDluZguwz9Oe0RQH/QlzNUrm0bzSJb0BlhX3r65GQAR/jJV4pDtGFY0kNSWpCnbR9O
	j89c7wTIbuFV5RbpsXkPsbN50IyFgkfKgBYinpr3Ers/G3n235nlnpv8uh2FqzefpbxQxlh5149
	HL4BGrqT3n3WEJJ+h9fG4Y15CTt5md/JleW6tBNzRHkyAaebWa2BUVo5BzittvDIE7L/nrOkyTR
	x1dVU3Leea1dU/
X-Received: by 2002:a05:7301:2a08:b0:30c:ab4f:46a3 with SMTP id 5a478bee46e88-30cab4f48e1mr7122599eec.39.1782709119287;
        Sun, 28 Jun 2026 21:58:39 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ca5f14f8asm27880242eec.6.2026.06.28.21.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:58:38 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:28:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: dt-platdev: Add SpacemiT K1 SoC to the
 allowlist
Message-ID: <7x5mgpk3z3aiebifhxto2v7m5yrikj52lwf5pzegzhk5aiehhj@jqm6opm6nrub>
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
 <20260626-shadow-deps-v4-1-bba9831f2f1d@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-shadow-deps-v4-1-bba9831f2f1d@mailbox.org>

On 26-06-26, 16:10, Shuwei Wu wrote:
> Add the compatible string for supporting the generic
> cpufreq driver on the SpacemiT K1 SoC.
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> ---
> Changes in v4:
> - Drop the K1-specific cpufreq driver and use cpufreq-dt again
> - Add spacemit,k1 back to the cpufreq-dt allowlist
> 
> Changes in v3:
> - Add a K1-specific cpufreq driver for the shared-rail, dual-clock topology
> - Add spacemit,k1 to the cpufreq-dt blocklist
> ---
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 25fd3b191b7e..e262394b56f9 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -81,6 +81,8 @@ static const struct of_device_id allowlist[] __initconst = {
>  		{ .have_governor_per_policy = true, },
>  	},
>  
> +	{ .compatible = "spacemit,k1", },
> +
>  	{ .compatible = "st-ericsson,u8500", },
>  	{ .compatible = "st-ericsson,u8540", },
>  	{ .compatible = "st-ericsson,u9500", },

Please take this via arch tree.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
