Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782A3CFF55
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080776; cv=none; b=AvnMH7WeSsSagLUKFrSM6+ZAfdY3jE4/YfvETLWCZEXYNcZW4i5lGnDCpzQQRhg+WAhg7CS/74/9Qlyh5+SCc7Bb4eEHh/RzyqiQf21fkb9Y3VVJjstzlsPQFRoA+O7/gypXFo7K1pnOZt8l+euyPA6c9418hlpRb7SNBovWjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080776; c=relaxed/simple;
	bh=ZW1+Rwj2Zkkg4xFxLw7inao2NDBuiKLZLReMOE1kdHk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzi26kQcqdmOWFdjMFsfZxAe4avta4zZCWWPxTajC0okI8B+aem81Ht4brRREF542c3pUvYmewCma+sXg99cFP7ci34DqFzKjDTH7PXfPfs2tpDywlTtpn85+iZDsJXMoLDT+y97xr7F8YhjXndhz+zLM1IzH4wmjFd03Xddc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V13+C1TO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V13+C1TO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE701F0155C
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080775;
	bh=ZW1+Rwj2Zkkg4xFxLw7inao2NDBuiKLZLReMOE1kdHk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=V13+C1TO7e0BLup6/ZXRFCVqSB8pr91oUvp+sZqGgDu6dy35z5ppYNo0lSuhKJf1f
	 vWZ5VzzvMkh6hoWyk1wdjkd//bAC1zhiP0ugdLwRvhYzJAIbRnGx1D76pMjOdo1k09
	 1ZUqjXfwW0JozzdJ4gTapT02eIULAj+Q0nw4EIDW+B5+ZavUQA7EZwi3FFbE8D5gOz
	 D3D8CInjn2ciHTHbs6DLk5Zl+AWG5YXG4gR3X2WSFDVsNqohzwWXIqSer0SUApbXqU
	 zlj2Ddp1yY39dCBH8RwqN4GhbP9u5/BPm7Xdp6VcIqfcI6DZaRLauZombNCO7ssslT
	 hMOavJL5+escg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb77b3afbso528004e87.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqNZhXJ+/V4gjLntAkur991/o5WaC0Drj69PP6tgfs2i218TELTPzzrsKQxheBDjeeK/Iniz5KOpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJOmZ2BtTLIhB061oCnWi0ERiMPPkGg0oX/ysQUG4h+L9UCqL
	lTGlG1JDF5d9YYsV31gRRWozcTv5FuzFuKsdftOANFzks2SGeUTeRMMRArGpaA08VybMwEICte4
	aUWDX6q/o/A47qd0t1EyD6C8wA1vx8tD2kEDJJOmmtg==
X-Received: by 2002:a05:6512:6383:b0:5ae:a702:6528 with SMTP id
 2adb3069b0e04-5aec67ac494mr2230940e87.26.1783080773854; Fri, 03 Jul 2026
 05:12:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 07:12:52 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 07:12:52 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703110317.1283411-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-8-wenst@chromium.org>
Date: Fri, 3 Jul 2026 07:12:52 -0500
X-Gmail-Original-Message-ID: <CAMRc=McpxD325uVPO5NNZ=47DQgCBrD+uTOKUzoHTgbkPhqtiA@mail.gmail.com>
X-Gm-Features: AVVi8CftwarX-Z8K0VV5KkzRZ0nUoORfEc2vkRQt3p7UOG6R8Lwo7yu86B3HXFw
Message-ID: <CAMRc=McpxD325uVPO5NNZ=47DQgCBrD+uTOKUzoHTgbkPhqtiA@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] usb: hub: Use usb_hub_set_port_power() to
 control port power everywhere
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 13:03:08 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> There are still some instances in the USB hub driver where port power is
> directly controlled by toggling the USB_PORT_FEAT_POWER feature flag.
>
> Switch these instances over to usb_hub_set_port_power() so that only one
> unified function to do this exists. This makes adding external power
> control with the power sequencing API easier and consistently applied.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
