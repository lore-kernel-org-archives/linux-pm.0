Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73456383316
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712353; cv=none; b=nz2IVcEWkbKyFFpKQ7mVTOEyUUqfP7UaDQRjrMW37QHIBpWHLgcgjbL8X6UvFuNwV2vdalCLRHf5wHcDhT3pQxb6P0eARdTUOFIXF7IpUWZMNYgF0sV9Erhz1xTfTdnkYnQIzMHYwN4sRS/9d4CujYeXyC9IohiIdCeePZDV+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712353; c=relaxed/simple;
	bh=Vg0lqJRyVD20Y1n9hS9MZYne+PScrbXmvpNBLpIzIT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpzNVC3LtmPiUeWWy6lu5e23/SZ+nnSWKsJh0qmp53mxENVaLSnRmZlsM0HWzM8eSN71fLyN4dyTLSbkhSGZef2WOYuaw12nZlzyeQD0UnJdgA+uT4b2DMHdS+/zUbZvK9/tl4xsnxInOaJ/4jcuyIgCmvVRuv4Knh7VPZCamdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5fylJo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5fylJo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE211F00A3E
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712352;
	bh=Vg0lqJRyVD20Y1n9hS9MZYne+PScrbXmvpNBLpIzIT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S5fylJo7ou/pe199LtPQYvBFXxrwL2FbyqQl69usIF9KH+Xpwhm7/O9YsYQL6yvU1
	 2HQHaI4uuJPCtrN5QfHZaGhV+57YImE+ceP74UrFfYrevhNnC4+liMPSSeX3Zrblny
	 7dmJTB8RGQkPi8pt/kKzdIilkSC+rJe8zJfDhM5G5HvgA9SMF4/imv5dBjaw6KjOaJ
	 ahd5gfMEK7lO/5VZdI8YSo/l4c3dQ4/7fIhMUyXHh4M9dblXFBcnJfcaWrvcDQcOzx
	 hsgkuK86Q9g0z5zE5BfH0ELQD2UahEtNk+x0egd6qqczWgwi65n957AEGT7BJ591w/
	 bZKwReIZLzdvQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so13476861fa.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 12:39:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpGDLzR3CMcfvnuHGGxDl1CA5cIuDRbclMVajABte1cmnkbTHgIdSuykO7nPDxvn6D5JUUoQCyv+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvyL6eCPDYOc5t3gGXJEQtHndd2GMS6bPeyyy0YqO3anqMtXj
	Gl4BE/v1GLyZtc6VyDkMYKUKoe6ZNEQcTRDYcQhiir2XLJxphMfg7a0aVbJbAl5xZtTER6XEgfG
	h4nBCbg3K7katxWqdF4nrCgvxBvg9zEA=
X-Received: by 2002:a05:6512:350c:b0:5ae:bf2e:b86a with SMTP id
 2adb3069b0e04-5b0235611f9mr108035e87.8.1783712350848; Fri, 10 Jul 2026
 12:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709033428.362970-1-panchuang@vivo.com> <20260709033428.362970-5-panchuang@vivo.com>
In-Reply-To: <20260709033428.362970-5-panchuang@vivo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:38:57 +0200
X-Gmail-Original-Message-ID: <CAD++jL=BjZqhL34Phb2P4ZL=YfTGFX8kTEc8+yVKg+1w7KGs1w@mail.gmail.com>
X-Gm-Features: AUfX_myT8PmuZ9-tNSLmmwKrWMbFlBNS86VEEGQkh-KBn26XkhAppa2GO_cynkQ
Message-ID: <CAD++jL=BjZqhL34Phb2P4ZL=YfTGFX8kTEc8+yVKg+1w7KGs1w@mail.gmail.com>
Subject: Re: [PATCH 04/43] power: supply: ab8500_btemp: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 5:34=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wrot=
e:

> The devm_request_threaded_irq() and devm_request_irq() now automatically
> log detailed error messages on failure. This eliminates the need for
> driver-specific dev_err() and dev_err_probe() calls that previously
> printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
