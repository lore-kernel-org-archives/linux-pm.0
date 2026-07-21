Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE83C279D
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624991; cv=none; b=r57FKzTFhmooyJZfhNBAxzfhUiiM9xjuqJ7t/XHzdEDEt1OedxukA21ZSyOQDvkMUkPpfspqMQBzQ7dn8lfPpRSjrAr79Qa5T9yq4BD63+dLcT/Uze18rQO25LsMWIaugfERoDzkowhS/Dtlskv2a+8nZogatU+3LECItWZjVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624991; c=relaxed/simple;
	bh=uvM+G7VRk/YqTwwm/37jHxsh/YM0a3jwdT/iGpNt7ns=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj9oIbvZ8rbwXwhfaircntKQnkuR5jTyYxgv9v+DKHTDByOXA5+M/aHhwJEbLBBfiZuj+r+Iv/Y26fIxj97v0IjOh/ZP4GohNjKSXeiVsMkax4fDO5f59SD8zP0yko37Hbx1ajkgWNcJ2MsNJPc53oBOVCfaYKtHHsqkpyLLbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVQO9e13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVQO9e13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD76E1F00ADB
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624989;
	bh=uvM+G7VRk/YqTwwm/37jHxsh/YM0a3jwdT/iGpNt7ns=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=MVQO9e13QUrl1ydM9tLxQtUaLCsnbcAtu8NgunLGYE4inVyVPW19Oav9+VQRrvtqa
	 wmKELzHocua82VssA7btIuIuDdOSyzsdxQUjVe1815Zw/htwZXJ+yQtpe+a+6wt5wh
	 +4j1aVXPzGCBf7oD26cJMav8pl/WEdSZrXJuFV0Zy0Fg4XrpxIa68x5pQQNY8vbOon
	 2Jb4Om5yt/pVv3lweKK87+3r6/K0Ayn0C1tuO52khz0O+QvalM2yny3NEZ0hZ9HF7h
	 frdv1XoaboFv7IEsh69K3VaUb3f5IZL78qHP2sWT5Aq9Z3gHI3BUoRl6RBQJCedg/p
	 0FRgkMqlPYC1A==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c74722e27so55735361fa.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:09:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RothsB1jFu3ufa4jDA2NWzas7IZLclNL+bqEpvpS92PYObim+xtDXmiBNF4ll61M1Me29odCnS7cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+kKjhbj/pNHnEFQtYID5mAyEBOY3TIk/v/XyxLQgbBGogJXT
	Gs90GqtN/VcP8fjArolt5u2Uko1jgQ8oSFhsqqpaNhXFVsGank0jVpfa2Z5B415S13Ays9CX6EZ
	ZQp3iJlI3dpMvubN1iZaNNZxD6gfUZqRog3KSpKOQCg==
X-Received: by 2002:a2e:b8c7:0:b0:394:8fc:8c3d with SMTP id
 38308e7fff4ca-39eb273c8e4mr29254061fa.4.1784624988499; Tue, 21 Jul 2026
 02:09:48 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:09:46 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:09:46 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260721065413.2306137-5-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-5-wenst@chromium.org>
Date: Tue, 21 Jul 2026 09:09:46 +0000
X-Gmail-Original-Message-ID: <CAMRc=McBNjvJK-dMBgifFxtgw0-bM_jaMYwJOWCRnV1PTLt-2w@mail.gmail.com>
X-Gm-Features: AUfX_mwsGGPfxToi9CFWvHg8F0vayIDb1DET27lB_HvrcHXw8Ht65VkjHJmkwKw
Message-ID: <CAMRc=McBNjvJK-dMBgifFxtgw0-bM_jaMYwJOWCRnV1PTLt-2w@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] usb: hub: Use assign_bit() in usb_hub_set_port_power()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 08:53:59 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> usb_hub_set_port_power() open-codes assign_bit(). Just use the
> assign_bit() macro instead. This makes subsequent additions to
> usb_hub_set_port_power() easier to read.
>
> This change does not introduce any functional changes.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
