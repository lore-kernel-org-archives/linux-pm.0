Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D23B71C8
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080605; cv=none; b=IjXPSt2ZmZFdN2WK6IquiKcdrC4RxYzaGWf3fjcpTu3793kACmdIgZHzBArf5HqskgizCbq5EHPDnstiDrFXhXzeJVhslDFaMhTrSQEPYL+myR5TQddur+9LtOjTkIByBtlGSlIwtqenn9SHbBzNYUsgy5yjBAIBxoW0cB6jFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080605; c=relaxed/simple;
	bh=FRnTE+sfqNi4P4NSTy/kqSXlrErtvnHm1QlBxXoiDG4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqyR8xpVerFIxK4Gw6cY16qwHbXqYjHk0WExGXkKgUrf6gCD6YtUhNc/kFiz9L98ChB21rVnWWYOj1xVbR2OJz0+aJUYYf+tEdy/ILV3Q+N6YHaCnVHuzVZDmwEDXKsGMhLKGf9nAldxCqdcjUzGUDzFJj2MqBscmaj+VCilouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5EQi/XU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5EQi/XU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642861F0155C
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080604;
	bh=FRnTE+sfqNi4P4NSTy/kqSXlrErtvnHm1QlBxXoiDG4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=R5EQi/XUeS15y7qKoAb3iyfRNON/HfPCXUy4TXekpkz50HKLNuxkqfKMtIacIPCj2
	 excH/UeAK7lKnCYiE7kk/ZGc1Jfdv4I7p7pz/KRc++S0aaGZcMMiQLjOLAiJOjGnft
	 WMtcYRr9SpfVqjeoJajNQ/rtXF8WYtixMqYLReWDkKRvSDsn0G4NEMqd2rcm7GxCeW
	 4I4Nd6FfGuJ0Rx/EhdyECwnNkB7IuIcqDASN9jsbcVfNYBfIt1QxTQKalBynI+NzXm
	 +gC1za7Gwuqlvy4P/sjLjFDhyho2uKcKCsSlqjXvXaKuMVevHXQehOOSdPTahIYEnd
	 giIul7JI8B9WQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b27812c96so4373581fa.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:10:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSMHkT0YzBbh/5Ohchgxs3ji6hz8BS9VK/Vzd6WaQ9N6WLrMyibBLwm+L2e0v0yJpmjBvZ0kO/tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrS+TpgMdpRErgwSPr6iy4kfFEYIfyk1HPjtGgk8w8zlVAq4Aj
	DVt0cqKC1+7IWLZcjiNfouK0xOPCGWZkWzkrkvx+/1NF/YVyMpjH9mHfumszAVMAdzU2ulOLZec
	1am3q6CvhlSoqh1GuVwD1wnM4TbI0cFoL9Wc/Gd4P0Q==
X-Received: by 2002:a2e:b538:0:b0:39b:2b9c:5447 with SMTP id
 38308e7fff4ca-39b33f83e54mr14578471fa.5.1783080603058; Fri, 03 Jul 2026
 05:10:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 07:09:59 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 07:09:59 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703110317.1283411-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-6-wenst@chromium.org>
Date: Fri, 3 Jul 2026 07:09:59 -0500
X-Gmail-Original-Message-ID: <CAMRc=MddJrLT1f62-MCoKQ3ZzchHRypXF0njO0K1Fgxmpv4BGQ@mail.gmail.com>
X-Gm-Features: AVVi8CcIrznNQZqmZR1andR36KwnRtt161WRtINBstw2LlkWAj-ZsW0prqZIcwI
Message-ID: <CAMRc=MddJrLT1f62-MCoKQ3ZzchHRypXF0njO0K1Fgxmpv4BGQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] usb: hub: Associate port@ fwnode with USB port device
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

On Fri, 3 Jul 2026 13:03:06 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> When a USB hub port is connected to a connector in a firmware node
> graph, the port itself has a node in the graph.
>
> Associate the port's firmware node with the USB port's device,
> usb_port::dev. This is used in later changes for the M.2 slot power
> sequencing provider to match against the requesting port.
>
> To avoid potential conflicts with ACPI firmware nodes and then causing
> power management issues, only assign the firmware node if the hub's
> firmware node is not an ACPI firmware node.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
