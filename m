Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE6394E80
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255538; cv=pass; b=puXkgQh5DLQ5NTtsHNvXSaYs6qDoRvYTSAr4qM1Rp+vKtdAMZLhKSwRkc6XM9/Gb34WS2T6p9fMTPA0hUWebrdiS5ucpsICVIryUPt1rg/TEO1QrtNB55lIZidoXWtRdXEFQNojKcHSX4TRtfrMhus/z3g3GiPzv6wvF7oxBQE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255538; c=relaxed/simple;
	bh=V9+QmrpZdZ64QkPAYEa/J5l5l39WRUXFgGRxiy0LOV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EADBK1UnsFURHphMYnZEu18MVhyRHL/N48WYigFxSYn08MliQKP8QniZ6yXsUBaxTEEO/CZIIhIjcC51MS9DDkOh1vOOHfH4MoNElLKZ32qgUdPE3B0sheCq/PMgTJjWNm/FqKr3DZ7a1ScGzPhJSVvnegyiY135kywGnqXSWDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VY6z8Y27; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VY6z8Y27"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dc67a5e102so7168117b3.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 02:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255532; cv=none;
        d=google.com; s=arc-20240605;
        b=fCq5gEWt8UJ3MmIl3+Fy1K9KpWaCjZuWmZy6Jz8t0tdJ+Dd+zY5QFu9vxjNRl8Tvhm
         1Qba9tEuTZnhnw9fvsIQteXEPdpiuF9UGhNJvGvdx3a6OGvjo468o6dT1xWhs0x+YOD7
         c6kfphJN+bBejqO8pW+G2X4wTzjCVVpqEJxDJBi9hvwe4ML4ReiDuNhOLpbj/AP1eaKe
         KhBavnBqrzV3iNcuKAt/qPsryNYG3W7vwaJV+oXGOUEQaD5ke+7y237EsYP6+OtSoK/W
         4hSQ68LuqKedM0rClsc4ZmJSExkLBytnbI7Rb5v5z/WKNv509AGKOkxPcDJ2eGFAOyH/
         QnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GT5k7NNhpJZZ3Z4dV7FccQcGuRptRglhhV64m8hW5dM=;
        fh=3xPEWbIpya3h3Lsm8pYGNHDRZauqxx3ZuQbWO8bMt7Q=;
        b=Wp/IVcFylz0e7SsPFe/Y/u99nQV3mHB3HBHShuAwOm3P9lVCHbufBv9glvsQO26kxw
         8BCcqiKj4U37gAd2kcaYc8Bw0/d+nW8FjN7Ztn2Kh7A6AfcwCWa10ORjNGnirsM9xdMQ
         dUiKd7OsC5ECCAbSGwNyIcmPM4P4zYtfwLPHlUsxFs6j6WZF3kuM/LHjhF4wCNxRMwW7
         qXRQgXP6Krk7ZdUaoRaPaNVWInC10EIMHXYRdWK724wiRme4KH5KqnOLTVKc3nF9yM4a
         iBuPGvfi/MrkswB4I8ENBteQbGrMruApe9O7Z51nSJMbtWhrdnOq9WKLdjgcuwQaxCJg
         afKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781255532; x=1781860332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT5k7NNhpJZZ3Z4dV7FccQcGuRptRglhhV64m8hW5dM=;
        b=VY6z8Y27Bq/k1VaXQDtfw4d6RhDkAb7ja36E1h1GoBPyxh8YLLuJ0VGxGCciWhduL3
         K6pOSFQWx1us+l10HBVmKuj+38x5U1b+jmRjcTWKFAb1lZmSa9x2dBwuyDpyBhsriic0
         0cEp83ACaRF9R3X5w43ashV/jsuNNogzc5ovw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255532; x=1781860332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GT5k7NNhpJZZ3Z4dV7FccQcGuRptRglhhV64m8hW5dM=;
        b=laX/rL6uWu2teoEKU/t5+ioPG1nYauv1mLc40fladFT+S+SOGfXDM5ysKM3h9+sSir
         bZfbydWNGehAVP8FLlxyZIQNCy9w1tXJcAeOxbk+rrlq3W/UngLhlYOtYwHGE4afEvQY
         0bY6/qqnZ4DwQ/IiOqE+Yij+pR/2S02esbK7hqjbjOg7Cmgh0qJIL6JtZpu/D0MxHGh3
         HzWGlwJgZX/I8OV0rsneevBp9M7GGikqMHnTpsj1gZsZqQ9eKcb+iSHxpGL9c74hxpvQ
         JdZqAvUNvmORxjaI2Q4TG/mBTTOVXk9OgrUAqfeHkDsZQvq6eq395JUsawGa9ml14kJJ
         gtSA==
X-Forwarded-Encrypted: i=1; AFNElJ8GZXazKBZqnMZUNP9IE1pes36M+dYxpGCXpbGdZLJQr5H3EsWMO31KYrQRPDsoM/isFslP281hBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBoMM5WR+NHoyDDi7KEFZ8hDUNiVwZiVJiM7ow3Ufwwae0HuQT
	wsUKQgb3WMMi+W0YU67xOwE2oltuIu9nhk+5cFvQiTETHc8Rmya0DqrAdiWwtK7b7IhQ/Wjr5TT
	rxH9iLSRf9v6EXFjohF3PjQvP72g+CzFbtR+XI7lU
X-Gm-Gg: Acq92OGKj+en1eLgCLD1OPv354spAQsPUsiUlz2rvPuC36HD8S+9uZTI3TzV9kkRENy
	siIKXywkYAYUE925Mdhe+Y15Lro4wV2ip/D3jrkcFqEIySqq/xJAK0av0AyT5vH40vJF+5VF3ay
	tWFo+tbu3yyQ0d0FKF5jolI5Sxr9ov9VDAlD32PdZyxxC7HKnb6jo/2LI6Erj79HHghsSSAirLV
	uhuOgXrKn19ax4izxaVqUaIGDnugkhtGiQzWZ7EFZqHXm+hRZn0nnJUuKw+0peUGpr1VxZEpDBc
	f8mP02Ep
X-Received: by 2002:a05:690c:f0a:b0:7ef:d039:a334 with SMTP id
 00721157ae682-7f7bcf0d73cmr16871217b3.22.1781255532401; Fri, 12 Jun 2026
 02:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-11-wenst@chromium.org>
 <ail1sAxgh5Xtkj2y@ashevche-desk.local>
In-Reply-To: <ail1sAxgh5Xtkj2y@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 18:12:01 +0900
X-Gm-Features: AVVi8Cc47lUt9lrnuGQ2TayhjSsjO0Ufug4-8BS--usEeOHUYmKa3VTCiJvbq60
Message-ID: <CAGXv+5Fkp9R3i+WnCunbydJpn_rjxX5Cz9Cb=auS-cR1RE=R8g@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] power: sequencing: pcie-m2: support matching on
 remote "port" node
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

On Wed, Jun 10, 2026 at 11:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:44PM +0800, Chen-Yu Tsai wrote:
> > A USB hub can have multiple ports, and this driver needs to
> > differentiate which port is being matched to. The USB hub driver now
> > associates the "port" node with the usb_port device, so here we can
> > use the remote "port" node to check for a match. Then fall back to
> > the remote device node for the other connection types.
>
> ...
>
> > +             if (remote_port && remote_port =3D=3D dev_of_node(dev))
> > +                     return PWRSEQ_MATCH_OK;
> >               if (remote && (remote =3D=3D dev_of_node(dev)))
> >                       return PWRSEQ_MATCH_OK;
>
> We have device_match_of_node() IIRC the name of that API.

Ack. Will also replace the existing instance.
