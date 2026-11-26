Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681288;
	b=TrMe44JdqxeI/o+O3KrRu/Fdhpo3qLwKU1oR3XH/F7N2vWRIYoHDqkUQOVvXZ/LRdskM
	 46mmTOKNpw/MfkRnlWbf3/yA8O598mMlCeAQRBjZNtGFROQ/45amuIhe8U/tOcibzjlmI
	 UH2utT9IrUgLGIHb6GQ7DS+40pqP82NH1SrTpXC6/We5KbifEQvJX54+qgCpPSpEV4aBc
	 EHrcGb4OCMZTaEBYyr6iT9nsOxK8A9qiLb5uJp+w/+ziVLeGus5g8JEjpSY7mwvLffY2L
	 W+8m8Peh2a9Jq4n9J5LGPoQ74eX2IVTcYYdIkwpdJX3DJxZbc2HFckCAwacSX1oPCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=wBOZvbV/Ao3pnBzrcXZtW9CD2639Ae7gzM3oEey/+58=;
	b=fdjLnqspz5E25Gr1ShXV4DvQXYu/kLbryGMUNbmS9e1kzf0zp7M6AavJsvJQ3twdiaFU
	 17sXR7GWgTY6KXIYm1WbhnXQj1FYwAI2jASZ9Yase2La1h0T1ULjlUB8C4Br7Y/n6AYXD
	 laq3slkF7P2xpaxD+zylRrN2Xe7FmEsHlMWYMYTDLASH9jev1Vr0w0Gi4Ss0N4rYNRgk5
	 6L28uuLW7Eejpgq5cFmDxdWnUiB7G4CcZaFl9eDwEy6UMOMdT2Uk4b+FyX2uAihzlvt+g
	 /p5O/girMGjGsQj9x/Bcq4ZmRAXuoz1yv7RlB3pzQ2qhQKDiQQ5vgdbABqAZFkDvSRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTdOHobo;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731D606A693
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 08:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8731D606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTdOHobo
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38431138772so8758274eec.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795681288; x=1796286088; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wBOZvbV/Ao3pnBzrcXZtW9CD2639Ae7gzM3oEey/+58=;
        b=yTdOHoboSe6gfTIhG0tnGzhdNHIQAkvIbhmz5xF0MSi0F3yzUttS9+e2B6NcNcIQDs
         9EHGmW3RTIyx+j8cGN6BbhT/YpLjG1pT6jhRZ3JKA8qgfElDTHGasz2d3K5oUrWu0Em6
         a6yl9NQfONiJP/AsIfiLJ4O2TyFU6nE4/lblOyl8ObcJFlqen0HDBvx/LYXPySKN2XZH
         ncia7RMEpCsjWQHz1+MHUp9z8tPfKaDCHPQbb6ElzkfKoj/btr7J+dC9wpX0uPkPMzI/
         mYzpIof1/CY389zEianq8zdKEJekaG0A+SmhmSJDS4+ThXSI/i+jstn5UkxKhJ3Kg05y
         XOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681288; x=1796286088;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wBOZvbV/Ao3pnBzrcXZtW9CD2639Ae7gzM3oEey/+58=;
        b=1hEZ7q4KpQZfMdoUZJ8o/piSaDXYd8khkPWBP/+PjdQYzt9BSs7lmbc51kefkphqjW
         saHgIrYfw/TgYg+fkVa9VdsndPqMzWpRFRbd1Pb69DH1Mf+GV/XjwsXuoU1ghNs370Cu
         NuCkmMog6XC0ncI9NN9R2InFtiEzs9AuQA5gBvMi4sy2uFhT0R4rsQpzF4SvAtKeLR0/
         lICR4aDCgTjTgUzyzqGOq3GWwzVMo3Bf+P9tKX5qQ2LxSWIrj5a9RAxkpulfhjzo3Wt2
         0LSXnMMuid/gI1MjIVzLxV9vojOMMvDkaHx+HTzfkmUjHLoAl8iK+Js3HPTVDpsfbRV0
         JKHA==
X-Forwarded-Encrypted: i=1; AL+hErHklFUbK/48UACcpNswyZ+ZY+7e1A/SmcUjLrJ+bcbBOFGYdwlwvYFl1tzriuvNBLj15aO9F4VrpA==@vger.kernel.org
X-Gm-Message-State: APuU4Z884lHoTEA6i8OfBC1D4FC/ZXMksyzO1AdRlRWXxxhV9sfycwEN
	5GoijVhqAcU42bIn9ruEbA4liXR21kA/VS6CYm4KU0SnVXt0taC4iVd4
X-Gm-Gg: AZFdTZdIxFjLOzXAMvrOxxOLw8RNwRU/eOIH7Y4rLGYfbxUYvxkhl3h1i0jzQdBouZ9
	ctI5UrVM/vGXkuB+MPuiB9gn7XjIgtvCo1AloOI2RP25oGR13/yHSB/E4wNV7zk1OWDmnRVR3GG
	PNHRaXRa4IkOXMaW3z2fJHx0Msdp6B6EEpI9ReBIdmPvilSGHNPz1KVd1dtvgUx1y+k5tkmWCx4
	w0kC9uLopdX1QgKbwDBS1bYuLmeCGWSEhOZOMRbhYo+i+Zs8+jTdfdsXbSUwiTDJ+lsSbZQ3oLs
	nZWtEMngCX0La+nS0Q2+KaAAjLulcDbvgYxq4F1PIYAX7dteXYWo0ThSHPcrkyIy9rD6rCzpD5m
	FpRdj/CeT9jwlQurATcnJvtwuEWCH9yK47LWlNMrqo/K+YGvkM6ELQnrIHb7rHOYeg5FjfUvNnw
	lr7eviV3bOe8BcXNzkT9Zdw88UVcQs66Xdvib4+bDGxucLKlsvz3gDt2mSg0kz9okD2eM9Q641W
	IZ32CGyFXUP0OoR0XcnhMcykQxK05Bh52ko8gdhPcmric+wm/u/SQRZNEMSQgR7XTTUDCLPshxG
	rt6GNbsveKBBiHzYoLiXeUMKXRiLoKebbrJDKPMNKim/DR+lrbzNCwa9hJlYLudYEuu9vg==
X-Received: by 2002:a05:7300:ac82:b0:385:4b9:18f2 with SMTP id 5a478bee46e88-3857093f077mr31004036eec.21.1795681287254;
        Thu, 26 Nov 2026 00:21:27 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm68602910eec.26.2026.11.26.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:21:26 -0800 (PST)
Date: Thu, 26 Nov 2026 00:21:25 -0800
Message-ID: <8497d7101dc7524be91edbaa5a9face5@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Prasanth R <ragaprasanth@gmail.com>
Cc: linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH 0/3] Input: clear the wake IRQ on unbind
In-Reply-To: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
References: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Prasanth,

On Wed, Nov 25, 2026 at 04:21:21PM +0900, Prasanth R wrote:
> These drivers set a wake IRQ with dev_pm_set_wake_irq() and never clear
> it. After unbind and bind, dev_pm_set_wake_irq() warns "wake irq already
> initialized" and returns -EEXIST.
>
> Switch them to the device-managed helpers.

Adding PM and driver core maintainers to the thread.

I wonder why clearing the wake IRQ cannot be done automatically for all
drivers on unbind, for example in device_unbind_cleanup() alongside
pm_runtime_reinit() and dev_pm_set_driver_flags().

The only case I see where a wake IRQ is attached at device registration
time rather than by a bound driver (or bus probe()) is PCI OF WAKE# in
drivers/pci/of.c:pci_configure_wake_irq(). That could be distinguished
by checking dev->driver when attaching the wake IRQ, or via an explicit
flag, so device_unbind_cleanup() only clears driver-bound wake IRQs.

Handling this in the core would save us from having to hunt down and
convert individual drivers to devm_pm_set_wake_irq() across the tree,
and would also fix buses like SPI that set up wake IRQs in probe() but
do not clear them on remove.

Thanks.

-- 
Dmitry
