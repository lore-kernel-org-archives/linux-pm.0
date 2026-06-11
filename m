Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B22D9787
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165729; cv=none; b=go01vimZ8O552Ijl3vJ45rmFuldOtFYckpzWl8cez2FzoaeH6+ukjuiCwCCcSUK8hiRFxBAEVToFIDNWcdbN0L1Od0RQNNQVJqga+E4vpCJGRbmg8ex4XWoAJKUZrN8gWGLXuq8O/qsEjORdGoTzlwj5oqgKddswY4mTFVOOQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165729; c=relaxed/simple;
	bh=3IU3Izek11DlTn3+eMp02gjkvoPAVU9+fiOHobFbbBk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcPoslYpXO07kMIUqjGcRPJEuKFM72XmdGvJ1bKnNiaQ+aseQrtQ5tQfFoAhMBlfR9EFxIW7DUIkUW+dyme36vw3Qe1E6N0JI5PduVMzdoBFBeT98um288v5Lv8tCiInL6NcAv7aBvmIyLPcdYj0XGkdvzCl6N59iPNzkrPWSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI/avuyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI/avuyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD58F1F008A1
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781165727;
	bh=3IU3Izek11DlTn3+eMp02gjkvoPAVU9+fiOHobFbbBk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=nI/avuyh3YSIOPmXXn1nMjWH5uVZJu7d3qrMRHzvD3hNAVJbywKbxH0sNOXHdMJcA
	 MXxijJQfzhFP1PaFpNUOOonu56SHOL7OHcCbUnGflcum1wXmROR6AkSoFv5san8l9/
	 GUR0uCNeb3ZWB53wyI1EvI8LXQbb/3Pp37lgxiuqK0R5qAdySknzUCJ0Cqo1H4MB2S
	 jEbBAlP+CU8Ckz9JYKQLM37OAeFGxfRQcnXFATT7EsrPPcwAM6ZZpTPdwdsB0pxedK
	 R/VqD1KtHQMdpol48+XxbfBw0dd8kHz5cJ2Qg9ak5y9Jghbo7igPlqGn8IXZSCJEvY
	 yWGQJY9yUVxOQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso9215756e87.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 01:15:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+omlw5LjZsdo2qK7OzXAyBrh/AS7f92hvPoJL5eOBgh+1yMiqyiYBwiMdGaBpbIyi+b4l5aGdgDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymf/kpwO+Snzfg54NxhJfmm+al8aQAT2ccTGMCVeMq7G0adD7c
	r4t5Ia2YEDnQxyEI6ZJ6Nw+LdhFKFzsxQq1dH522tXBOinQzVQ8jznCm9XGFL3y2J7nmSVfkKug
	9th5juJE+CDZmWkxcJYIElW+B8RwKJ5cCdIuOJn93fA==
X-Received: by 2002:a05:6512:220b:b0:5ad:a04:e62b with SMTP id
 2adb3069b0e04-5ad27cd1f4dmr556504e87.32.1781165726578; Thu, 11 Jun 2026
 01:15:26 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 04:15:24 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 04:15:24 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610084053.2059858-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-2-wenst@chromium.org>
Date: Thu, 11 Jun 2026 04:15:24 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me0zQYLLuiyYBOtD5quL_LeK_Zg+WoL0vzXDhjB5e+gzw@mail.gmail.com>
X-Gm-Features: AVVi8CebXQLKBQMIYKPsMbHoISglCZVr32F3LvdIki_eZQgsmFxJVcEwTR4qpYo
Message-ID: <CAMRc=Me0zQYLLuiyYBOtD5quL_LeK_Zg+WoL0vzXDhjB5e+gzw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] device property: Add fwnode_graph_get_port_by_id()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 10:40:35 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> In some cases the driver needs a reference to the port firmware node.
> Once such case is the upcoming USB power sequencing integration. The
> USB hub port is tied to the corresponding port firmware node if it
> exists.
>
> Provide a helper for this.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
