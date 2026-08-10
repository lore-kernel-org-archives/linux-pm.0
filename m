Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A741A4EE;
	Mon, 10 Aug 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379196; cv=none; b=CGnpF5MhfvgKwdPmrT5X8c1pAz7yL0D8trjfQFB6CWjH+1TvCriMw8VSWrW17Y6sSLoY/Uf4A2Re6C2rQTPJGSj27ETyLX0e7g0K+45kuitNL1uzaSJSk47tI5uktNI+8icP/I6IlWCM2G00hnUKUh9BD+MoM5+yjROlczpWlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379196; c=relaxed/simple;
	bh=ysPMNBeJ2ay+VOXT1/Gdtq9+3bpoy6chLIHWvgB0SHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw7dkEpju4bxSh9Nnyycl2YHyLoh0dIwufcmQnQZrMjlARHRvyGIX39YJWJHawVZmsNKu8T4LbZmz+ugSUe+YCAkNv7DplZiviQF+7Ha50QbmbFsS+dH9HShlKxgoFq/jijSIQMOw7jnHIJte2di/L4sy/O0Pb+SZI9TE3yu2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZLUvply; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZLUvply"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE791F00A3A;
	Mon, 10 Aug 2026 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786379185;
	bh=SUi8TvaGZ/ONLDR20xtbgTj2PSwgrawqHUmwvPH281Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iZLUvplyIcNz5VE9d3kCC55idVkZrcMUkNQMbp9OGxSTxJfNYZ4yr2JOIOsKLJAn8
	 OObjougUbmk/38Tg1bYoCpjH+ub9h5QwXhL5o/8zljucHR+7DSNhua66AetPZHytcQ
	 3y2CRfYBQvSNkeuKQbvgCx8L6hlt9D3WV679tfLe6BvPHzmCHXlH9U99BxReF/HGin
	 TL4hR+2U4zuEU+faiR9plq7xmFoQFSgBVHxVjTPoHNr+pLGwQl794ToVshVql7ZgUD
	 g+L0acQ0yPs3jYsKAs1idJ115olPzn+IoDNqdAlrajYd2g8cEdKKUpyT9Dcts4aZoC
	 Zur8II8DGV73g==
Date: Mon, 10 Aug 2026 18:26:15 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 13/16] power: sequencing: pcie-m2: Add usb and sdio
 targets for E-key connector
Message-ID: <hxidwwqeooyo4fwjc6rmbsfv35b2af7flub23qcpwin6bqj5ff@h46sqvwc6k6i>
References: <20260724084328.3943997-1-wenst@chromium.org>
 <20260724084328.3943997-14-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724084328.3943997-14-wenst@chromium.org>

On Fri, Jul 24, 2026 at 04:43:22PM +0800, Chen-Yu Tsai wrote:
> The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
> UART for BT. Currently the driver only supports PCIe and UART.
> 
> Add power sequencing targets for SDIO and USB. To avoid adding a
> complicated dependency tree, rename the existing power sequencing units
> "pcie" and "uart" to "wifi" and "bt". The existing target names are left
> untouched. The new "sdio" and "usb" targets just point to the renamed
> "wifi" and "bt" units.
> 
> The "unit" names are internal to the power sequencing framework, and
> should be confined to a single provider. The names are only
> informational. Dependencies are tracked with pointers to other units.
> 
> The "target" names are the strings that the consumer uses to acquire a
> descriptor with. As these remain the same, existing users will continue
> to work.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
