Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56E3C3431
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917091; cv=pass; b=eui5vui5U431gG4WV5bhm1G5lHCLMaKgU0G45CK/5eFsaPn6uvV7eT0JbCs2eDEJqL4uDFJDHuFeE5/mdMIkyc+Uy5b8w485SOopevU6AAcXhK1ZnFXxyMu9vLCwoBO8Ru+WCl16FiUluxIrINo0GwN9WGj7v6pW9K/5rvMxjQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917091; c=relaxed/simple;
	bh=EiYofbmwlMfzv/ArY5NjYo10OUgrpmbug4B8jl033qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKZrZ1UB8YmB2ewqZjeC3I8ZAkUrHJrbc+aZw3/bqYDwbQZHLntWMY+Xl46oC7SVEMe/qivTlPfaJ3ROlWv76Qbg0mQHu8zoDoqdcIDdAis9L2ne+v34IxwnbWDd3IuDd4VXffsvlVfOR2b4k3MOcbyDsdQQ72xey9gvVdEoxdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chR08dS0; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chR08dS0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-667de793310so1448949a12.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 03:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773917088; cv=none;
        d=google.com; s=arc-20240605;
        b=I6ZP3XEycR5b9oBG9OA0SYyXZHZrk4fYt37u/0nSUrSLtqq4f5vB0mFhgf7k1c3AoS
         +eJWuvKwq0bqNXQTTt7ozUpoSnEkGfYnXzWSpSRFMW9pcOr8mUuXpZY02mq4VUx/Gk0A
         4i1F8XEut57zF+TrBUhy/hICxSnnUB+dLhIFkNqBxtexLXx8lsv6fTxWtllmnwgCv4Q4
         T4KEZyScpN3MNpdlAEH2QECobRQKlAwK16jViQJ4gbtScXEOM5XweuhnyudCrNwrsMR9
         8/Yp0m+bdRvcYyK9LoWRR20j8ecUrxgV3PuvXs3aJVUyo01sQkZEXOeZQI69j4QVBvHe
         wZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8nsXLrCC8XRALmE6EP9wDlaUdJlORBZ30G/UqxIe1EE=;
        fh=ipFncFVy5ibWj+Qn6V0j4CeFwBcBveIYhVLDVDapbUI=;
        b=ASUwVqmbC0z3f4qauvQvbbdEytQceddnnN8xsZqXbfpksmSZ83vd47O0EtVaCeL+ul
         zHZXjc+km5zMn63p2MgksOO7kKtkxQ74P4IECzLlkof1R7MeQ2zHh0bI0LEm59cZDPqr
         QRmtEDk30y8AWkK1cMci8bqs1IKsPTDcXoY9tBpX6EGZ9MEHoWIxmVOZv18dTUGGq/dP
         1IsiHIbt8WpLbNuQkIMsYeAqP8zthqIl1cpoHMStB8dDVqtJ/FTvhChhrZ+PUxXq+psi
         /7rnoEbKdWprKCIjuyHpkKyr+b4timBLriszX5PJkSHBKJNjmNO+yTIHOF47iRB8xINf
         Wb/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773917088; x=1774521888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8nsXLrCC8XRALmE6EP9wDlaUdJlORBZ30G/UqxIe1EE=;
        b=chR08dS04ikmDgU7f5w0IwqvzESzg8c9wODVm8YQoEJF8XxctE+XvO2BjRXbtt5go0
         wGrHhCxnOJJIMW+ToEXVOXJYVWUOSTR5aicD+ZzGAY0IVcd1IjnMvlbpT2oLhowxBtrU
         1pBkdYp14DjhdqCKk6r/BpYxS6WOBFSj28GZDivX3vcz1maskS6iEqmrzEO6a7hevf+r
         6PsTvq1Km6REpPCgYaw2M6jT4SilHYsjufs7BTs1T2mxDspjoH4fUF7cto4KhaYdLu1J
         gnsFygZosc1laJsMy3BqGFMd3oloxKkFLZ9Sw8DZagvmoAJEIsfzA0DIiiChec/dDzYx
         1fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917088; x=1774521888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nsXLrCC8XRALmE6EP9wDlaUdJlORBZ30G/UqxIe1EE=;
        b=efZSRTuXt9Iq8X9mKxUe/iZSIbiUEHJmfEVN+dAzIoGgUMxk5YrWlGXqLMOrwqJb8L
         h5qB7KhOJwpbmiFdlmlks5a6ieWZtecDIM3Tt+SmmHJ/Q2KV9ARiWqBsqTrTi4GlsDy2
         4GjktRYIheHASzFy9Z3RISc1yQh6G3ASFkbyBDNNdElXFumcPvtktEu0fLtlOZfLR6Gw
         50vy0hL3S2+s2BvHNXMEmYZCYWGW6lSDQXKoZl8vzmLjMriYtOp4ZAEv900SG2jZn5l+
         IrjOuhFvEKkZ9vAQDS37Xiak1zdQEZVaDL0sSdU9McMqditX6oDajPBkBJbxrNG6fuQz
         iRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV49ar+pHPytVUai0+UnF3J7bVgO0XCjkQbsKRj16/3wVT8FBPGKC8G+B4qn+ECzeWKQKM5i6iCLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLn+gBDq9xfwYg8OcZizomaIjdNBeUgxA4uEbu6Wm3LMfsvKH
	MzCS33VntE759+Ph2NgRdprkOYHfYKc4/84sJoSxmEIWs4wyhFCDYgPd4NSSXlHms8jp/ETiYcv
	33pYm8Q2tValdwoG67M9w+Hx4B9gx0PA=
X-Gm-Gg: ATEYQzwTKzt2STqXMFwwAXRMGF05PbS6R6PQPunDbRVb/pUoWBx8u0fDs+8wg2wCNbQ
	Dfpe1OWylfAIgH9Lfu289ppKrUfv01yyPYPYAvI2ory83rzt8FsnCoGqSbbirtaeR5RX2IrPJR0
	gpvo5fDkizmdc6Udg/VHyHbpUdYvr35Ls9yGgMxOu4z0LdSsURitsaarI9w7m6r5ejhh35cPLzF
	rnszYWAJo50xA4HlHhFNflNteNuTfBfPAGHPEej/vjYTb8lJ8di2NNqy+4YMSM+TxRuODr2vcos
	GB55jA==
X-Received: by 2002:aa7:ca56:0:b0:667:ddf7:7d9d with SMTP id
 4fb4d7f45d1cf-667ddf7835fmr2510617a12.10.1773917087638; Thu, 19 Mar 2026
 03:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
In-Reply-To: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Mar 2026 16:14:30 +0530
X-Gm-Features: AaiRm52C7IQCXAwHh87UFE9OwrOumGbtL8uwoXCOsBJxz_0fqoGXY7qT2wiZr5Q
Message-ID: <CANAwSgTp6urWYT9H96XR7viKv7Sy16L4exS2KR5PLq_FJ91xbQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
To: Shuwei Wu <shuweiwoo@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shuwei,

On Wed, 26 Nov 2025 at 17:27, Shuwei Wu <shuweiwoo@163.com> wrote:
>
> Introduce support for the on-die thermal sensor unit (TSU)
> found on the SpacemiT K1 SoC.
>
> Include the device tree binding documentation in YAML format, the
> thermal sensor driver implementation, and the device tree changes to
> enable the sensor on K1 SoC.
>
> Test logs:
> Hardware: OrangePi-RV2 integrates SpacemiT K1 SoC
> Kernel: 6.18.0-rc4 mainline
>
> Verified that all five thermal sensors are registered and reporting
> valid temperatures.
>
> $ cat /sys/class/thermal/thermal_zone*/type
> soc-thermal
> package-thermal
> gpu-thermal
> cluster0-thermal
> cluster1-thermal
>
> $ cat /sys/class/thermal/thermal_zone3/temp
> 28000
>
> Dynamic threshold and interrupt tests passed via sysfs trip_point
> manipulation.
>
> ---
> Shuwei Wu (3):
>       dt-bindings: thermal: Add SpacemiT K1 thermal sensor
>       thermal: K1: Add driver for K1 SoC thermal sensor
>       riscv: dts: spacemit: Add thermal sensor for K1 SoC
>
>  .../bindings/thermal/spacemit,k1-thermal.yaml      |  76 +++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi               | 101 +++++++
>  drivers/thermal/Kconfig                            |  14 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/k1_thermal.c                       | 307 +++++++++++++++++++++
>  5 files changed, 499 insertions(+)
> ---
> base-commit: f5f2e20b1cbc5f9ea20b372d15967b24921ede19
> change-id: 20251124-b4-k1-thermal-eca906e6dd7a
>
> Best regards,

Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

> --
> Shuwei Wu <shuweiwoo@163.com>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
