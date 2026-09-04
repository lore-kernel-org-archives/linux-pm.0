Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679213E63BD;
	Fri,  4 Sep 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540447; cv=none; b=Z3aPt4/Xq/kB1y9Ltm2ZqGtDcPoGPr1+ufPJ1UsteWbxsI/jR8WfSfaXl0tuZqR2UI5Emi1DiaQ+7abgOS8cTOJkQXg2DTfnPXJV/BSUIByPlxMINzlWxCL9tEXdFw4BuCm62rzcfn/NkN4QR6kwEYzPFFx6Yfpxu4eaBvdSXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540447; c=relaxed/simple;
	bh=T45Cpnn/Ejxo9tbMaWkq3no2QPIxnYkZfg1NxaS4+tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCun9ONBuZCl7MoE6EElEkKODvEkaWOMABWRBQpBeohPA3RDj9th7f9Abo1TU9PoWL99LE0TydPHHQrK9rXj4tl3FbMFWpIyKyZBz4M6NVROgJhdl6Mm1J1ihuOII81Bu1PUpwyl3ocxV8mYHTXm4MXh3XLtYaAGlEc7Mm8amck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ElI1ve5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ElI1ve5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FCB1F00A3D;
	Fri,  4 Sep 2026 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788540446;
	bh=fTWd52yFP65YxYGX1jhsbarPqnM67tVSqN38zDBl1Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ElI1ve5Nd6BtihDq8JaFfsbnYd4kSDgma7wyhIvYWOE8sajceMkHCCY/FR8jt1IcN
	 z4QP+OlpDxeCsq+Tajo5otPR1LuICxOv2ztASH57u8nNUyHjf5mmoFCPrh7DfDDN/f
	 VxGANRriNDW+vUGOX+EA1x5CuCswzULJxRW730rg=
Date: Fri, 4 Sep 2026 18:44:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 07/16] usb: core: Move struct usb_port and related
 APIs to port.h
Message-ID: <2026090430-botanist-ungodly-0299@gregkh>
References: <20260904084158.1341550-1-wenst@chromium.org>
 <20260904084158.1341550-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904084158.1341550-8-wenst@chromium.org>

On Fri, Sep 04, 2026 at 04:41:46PM +0800, Chen-Yu Tsai wrote:
> |struct usb_port| and its matching container_of() macro should live in
> its own port.h, matching the split we have for .c files.

Why?

> Move them as described. Also move usb_port_is_power_on(), since in the
> next change its |struct usb_hub *| parameter will be changed to
> |struct usb_port *|, and becomes a non-static function that only
> references |struct usb_port|.

No, please don't do that unless you have a really good reason.


> 
> port.h is only included from hub.h, as a subsequent patch will directly
> use fields from |struct usb_port| in a static inline helper in hub.h.
> The USB internal headers don't have header guards to help with this.
> 
> Also drop 'extern' from the header declaration of usb_port_is_power_on().
> This is not needed in modern C.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v4:
> - Dropped 'extern' (Andy)
> 
> Changes since v3:
> - New patch (Andy)
> ---
>  drivers/usb/core/hub.c  | 16 ----------
>  drivers/usb/core/hub.h  | 48 ++---------------------------
>  drivers/usb/core/port.c | 16 ++++++++++
>  drivers/usb/core/port.h | 68 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/usb/core/port.h

hub.h is small enough, making a single .h file that is 68 lines long
for no real good reason isn't a good idea.  Odds are this will make the
build take longer as you now need to open/read/close another file.

And if we really want to do this, it shouldn't be burried in the middle
of a long "enable this platform" series where people will miss it.

Thanks to Alan's review for making me notice it.

thanks,

greg k-h
