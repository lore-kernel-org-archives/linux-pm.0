Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BD37DEBB
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255869; cv=pass; b=eLVlrHPFki58P3fomnfNVenPc0LZAvIT/BFcxLVWf/DQUvBlNZr2trfjMekWYttGbFGdBQ98FwvGnJYQT5HePGd923DFH3DESmd0aKdCMXfpSp30eEAC5LBAUVT/OyyYYVo/Pd6BmHcjOI57AkqZnZEfuuVdrKeN/PWDTuFojy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255869; c=relaxed/simple;
	bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0OXPM4lVlpcq/COA20diY5L6gK2ACqqY4W1L+55NnVVPpX5NOprhYbv0/m/njAB9X7tHzmWHYscIVGU+YIWXspxyASXnpEjcqGBuvKasJt3e0x59CMT6FcdfEjlDW6NIt9MPfTCDx/rew3X+l8lkM3X9OtBboZEAtgtRtkmw5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cp45EbXQ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cp45EbXQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7f69b71f7b2so7685427b3.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 02:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255867; cv=none;
        d=google.com; s=arc-20240605;
        b=kxdmfWYxZ/vPSuR4qh50FIbZV2r+Sz+stgzurh/q4X+YzsFdPLK03MktqQy+s942Eu
         UVJQTaSvVKOfgSnqbn46yZYiDtO4yQZo+/OyExHLlxHBbM/3nhbpNCdMiz+1AD3MwQf7
         C0xhJnMuzK4xQE22DKG7yKw+cA/Cf7ebGzjENEYHzkDWuNO1hAQi5IqzpRcfJa4fFv+i
         KiWHiTT5S7SodnPzDaWzbYJKi0TENPBnCVWz4b0NddY1rqwtK1tnMzy7VrZ9la5c5xeh
         YufWxR3L9hHOQx3GgWDUaWk7fXzpv2dZH8xP+G0yV4MNW4X5xnO0HaoeskuxTNIg6KoT
         8L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
        fh=ENqFwbsH4LvJxbUao0pYrJAp7qOMJ8tO6MI5ymKyTjQ=;
        b=Ykxk3q+/ANrR9tbj/aYjm55tjh9yehXC2Dey8j4j3aFb4Wd1JeJdLvj7TOBFzjkW+h
         1BuPmy0gBPdux3exGCGJYhAV1JZo2EJxSwNe3Ad3KvUgiZ6gIDU4QSGrLjQncsnQfwYM
         BdTYhJuiGHl7wT73KxQwwz0o17ID31lURdgtIO3M6XbJ3kvEFnkoZTqLcBl3lXJP++9f
         D0vbDNXVRbbvvm9IeBuLhyRZb9+qiCtthBq8DUuv1RlckGj0Wl67HzECquFnYQeN4N8f
         Mnngp+rweqcUKBRFWpiS2yX+eyt9U6L1vw/9bNqVDU2AWvTNjxTfkwRuRm3ALu9feKY6
         wTxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781255867; x=1781860667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
        b=Cp45EbXQPotQHJV6pD9Z1tRcMMw/E1UVxgnMhXoZBjFie5UhROaMkWEwt2QF5D70y8
         YOD/NxeL/50JCSOtVLg3QZOu3/P+oUy7rMUa01zQtjLxNz547rc1kAL0UpiWXQfOIV15
         NmZbH96i2TJi0/uf3Vwh2QluHzpV4IczZXOAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255867; x=1781860667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
        b=nvwmA4NNuegBwz07jeXn5fw59m883XnUFs4jCPr0g4QIzFSOWnBk057etBkzrX7pa4
         ZBm+mq4kXcINnf9iPfPWYS7g580zvf53xWov+PnYQdvXZ0TadqPCsgrhp1lkVaHoP2wj
         YnD28BUBON4qBFDZk5qsgmPZlae0WDqFG9qhjRZCnokA5cBLk8ey6oeHotFZK9SgttUC
         ehxbAv7PTwoY9xHYS5a85ZoGxIagfE8Zp7UrQfx4DRh3aT+f985oeow5Uu0G9Tq95pa8
         SBfYFdyb+1Q4Z3228drbr1SCuHw1xPmPL+12yrjLmqdiy8wZUaT+xEy117CBhTC5NYWb
         tudg==
X-Forwarded-Encrypted: i=1; AFNElJ9qFUeV5kAq3KAf0IfB+sQFt1v1bB0yJTzg9Y4+qN32ofx0VaIGFqBux05Phr1kWLxWpYwbp/YaWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpiniThajw43KJgMV4AuLdGwvaZQWJqV9IP/JpOmG0dXxiqAd5
	GLmCO9UDdMgwY/9mKtBBrjrTE83uiQPMTJu5o8tTwumV/IcgHyldSb8szWMoVILApYGka0W3SEB
	vnRC+9GI/QyrlcO+Qlx3TOvtPld0Dq96bjminkVVM
X-Gm-Gg: Acq92OGUtVtG3Y1Of+2sK/3Kmt2jHNILsPIC2wRPBdEEHuLb7LWM543j2j8gV+tBdE3
	AVpxkczdJagr60ZM+ukZD3UAVa8JVpSoE2qsITtS4F9+i+eHo0EHf2GJccGqkkyNSMKgGyrUYQY
	0inUpLC2+W5osfNW86dFVj9IXA6WRZGdU204MZFwDKCBHwDzmVgqUGiZ1L39wkWAv49ZdHKe4qn
	pMLW+57s6LCu4w47rrsgRB5X92hHXZkntC/lnDnEuX6a722P81x2wb0YyOgwQtmjVB4XU30CHhS
	b5500iaQ
X-Received: by 2002:a05:690c:3a0:b0:7cf:af41:50b0 with SMTP id
 00721157ae682-7f7b8d248damr20618557b3.36.1781255867482; Fri, 12 Jun 2026
 02:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-12-wenst@chromium.org>
 <ail2VcubjT7HNGUC@ashevche-desk.local>
In-Reply-To: <ail2VcubjT7HNGUC@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 18:17:35 +0900
X-Gm-Features: AVVi8CeDuG6qw5zFxFcHgtnnMaKWsSajO4ZT4D-k-SPwtRIr1WJR_hE6bMB1VZI
Message-ID: <CAGXv+5GNfWFinO1E=5X46xnBsQpY-_i45mq60eeQu=U3Z0MtDA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] power: sequencing: pcie-m2: Add usb and sdio
 targets for E-key connector
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:45PM +0800, Chen-Yu Tsai wrote:
> > The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
> > UART for BT. Currently the driver only supports PCIe and UART.
> >
> > Add power sequencing targets for SDIO and USB. To avoid adding a
> > complicated dependency tree, rename the existing power sequencing units
> > "pcie" and "uart" to "wifi" and "bt". The existing target names are lef=
t
> > untouched. The new "sdio" and "usb" targets just point to the renamed
> > "wifi" and "bt" units.
>
> Why can we do that? No breakage? Only internal names? No ABI affected?
> Please, clarify all this in the commit message.

Will do.

In short, the target names (which are not modified) are used by the
consumer, while the unit names are internal only.


ChenYu
