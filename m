Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3813B3BFF
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855952; cv=none; b=rltnV0X3Z5w7xVN2/tg6kLIfLUxp3SfcqBh5qkceJL1DW5CanKomfPijTW/gEUjlfQeDPLPbLR04H21Z6HRaVpITIDFbaVNPbqcxyvzRNtvjwKHGVE8482aUfD93Iz/C+fkzzEYRHVT/juKIrAUArwIrGFF/yf5G8USXA4Dra70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855952; c=relaxed/simple;
	bh=5ei7fh/Y69tCRQ3kK/dbGYFuojcIwy3an7mcbITipcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/jXAa4Q3cK1evOhc3QBt9TRglQmzrkbJjkb4GRSj0X0nlJ0ubd7e4479dPGTZhikwA+AXhLVyUV6yL3U445dEPe1eFGo81MI0WuCyTnWMOch2uMbgaUGBcA6kbwZAC5VwHfnElsobWRbvtgaYkrVpuyk+hIRDWlhElriRpW6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=r5fzMnjx; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="r5fzMnjx"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6312970d9e3so5947030137.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1778855949; x=1779460749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQxJjtW9NoHteCK0AjadT0ZiWp4xMo5S2G7yHBWhKm0=;
        b=r5fzMnjxo0qn47DQheu+8z2BqVawUayNL19uz+3HNCVkcfleHmePGSySdncjPWRlFL
         pyzYzWAhxGtYttSooQV6s0iEnztVj8Znl0pLey9ORkA+ry7diHDpSXXziTw4HzbpN+mL
         5igrMArIrATYGLp9FMEWMoWAwbQRiX7FBxA88r1H74RNRo0QkogWc0Pfy3h0uzfgy2Ow
         UOJpkHXJo1G9zABJeA/iUcFWpnGwA+3ztUcjxcxYS2KuQDWaMpKQrKJt6fpQyNp5Y1lw
         oMcuYZtMhxuN9N0/NLYbsqbptZruq8Iv+HICmnHUG1iWpANS/ZrpA6TwTCe6khEjfn+S
         hMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855949; x=1779460749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQxJjtW9NoHteCK0AjadT0ZiWp4xMo5S2G7yHBWhKm0=;
        b=pZnrFeJiCE588EotFlIWT5HoXbrsPmZTVIeODGyalIENWY3aWW9aptloUOMx8MzZwg
         ZaFknHeaS3l4iDDkGGQO5Fg1wJSi9cfyt2P5umgQ3MLTovOR1ZcEpRRESOWWfEoK9boP
         0ZT6lnaw/HfRrnzCmejqDiAaHRCCnD7KW30S3sojKCGrIc+lWiv6NnmhUj5OJ2pvoqCi
         4TcrvNIrlzgmPNKSzvnTLyVyarIOkfmWv2j1dOl9zLR574O8Kzp8QIhSGOHRglDIP+uO
         edpxAO99e9JM2WNK4C++4d2ZFMEpxME4CZkOsEafE+nosfPLq/lQWrgCjtRZbTmAQH8a
         SvPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+61f+70rMQi6+iCqiF7adIl74niT1oCpmlVWKbJyg1KykoDOl54QC/1m5bzgamFWUd/i6OgAcIUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweJ7yhtM8c45K+guqTVXvKwgYvIjTUr425FvXpOaTrhSpJlEHC
	HbyvKJ9KxCIPF/jrzPJO37RcUk9EXLvGDIkxunfp9udvbKuxe2IfYpR3f8uO+obSeR2ZISwAKBY
	4JS8=
X-Gm-Gg: Acq92OHH/RVM27e4ElsNnUTrCQ68RnZ366RCpDnMVcB0a3frTfN6E75eOPmKL6BSGNq
	o0/4bys16AGmBafs8zUoVJTLi3oQ1s1c7NRzmB0yZ2WOaCOK1oz14qq90TJFWZKOT6JorhAjD3n
	4KJLntIsP39S3HLWZVFjr6ViyqiS7r9sMjkMse88ZezR28JXRbJh+chGl1ZPoUMjPXlo7LW3GpM
	jIj/Lg64mSfl+R0Qj6qQXQoYnRlRcviub0yU1TIU6K7E3fxqbbpheH8YaXEQsshOFToceAE5fNg
	cnHp4luv7aYi72wbzBzrhp+Su2Y5sADZ+QgI0wTG+uG1SBxoeluvkI2wPXHr0UyheNEuXg6ydUe
	8Ktok7TtPb9I0jkSwnpsFEKYVHsBlPuhVOMoOduavK8QmWYDoMtJ/NqNAGxzVVCSqWV0Tcyx/CS
	jB4wQNqj3N94qjEJV9zQTIB0UCBz/pRpi4R+MTBk8mC0s=
X-Received: by 2002:a05:6102:e14:b0:633:1fbe:79c8 with SMTP id ada2fe7eead31-63a3f597eb4mr2246407137.23.1778855948736;
        Fri, 15 May 2026 07:39:08 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b3d0bdbsm51850896d6.24.2026.05.15.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:39:08 -0700 (PDT)
Date: Fri, 15 May 2026 10:39:04 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH RFC 05/12] usb: hub: Power on connected M.2 E-key
 connectors
Message-ID: <41260a6d-46fa-4a45-9906-e1bc5e5dd83a@rowland.harvard.edu>
References: <20260515090149.3169406-1-wenst@chromium.org>
 <20260515090149.3169406-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515090149.3169406-6-wenst@chromium.org>

On Fri, May 15, 2026 at 05:01:41PM +0800, Chen-Yu Tsai wrote:
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 90ea597d42ae..4165f71e212b 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -31,7 +31,9 @@
>  #include <linux/minmax.h>
>  #include <linux/mutex.h>
>  #include <linux/random.h>
> +#include <linux/of_graph.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/kobject.h>
>  
>  #include <linux/bitfield.h>
> @@ -888,13 +890,25 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
>  {
>  	int ret;
>  
> +	if (set)
> +		ret = pwrseq_power_on(hub->ports[port1 - 1]->pwrseq);
> +	else
> +		ret = pwrseq_power_off(hub->ports[port1 - 1]->pwrseq);
> +	if (ret)
> +		return ret;
> +
>  	if (set)
>  		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
>  	else
>  		ret = usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
>  
> -	if (ret)
> +	if (ret) {
> +		if (set)
> +			pwrseq_power_off(hub->ports[port1 - 1]->pwrseq);
> +		else
> +			pwrseq_power_on(hub->ports[port1 - 1]->pwrseq);
>  		return ret;
> +	}
>  
>  	if (set)
>  		set_bit(port1, hub->power_bits);
> @@ -1867,6 +1881,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	struct usb_host_interface *desc;
>  	struct usb_device *hdev;
>  	struct usb_hub *hub;
> +	int ret;
>  
>  	desc = intf->cur_altsetting;
>  	hdev = interface_to_usbdev(intf);

This change is totally useless.  Didn't you get a warning from the 
compiler when you built it?

> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 9ebc5ef54a32..6039e5f5dcd7 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -85,6 +85,7 @@ struct usb_hub {
>   * @port_owner: port's owner
>   * @peer: related usb2 and usb3 ports (share the same connector)
>   * @connector: USB Type-C connector
> + * @pwrseq: power sequencing descriptor for the port
>   * @req: default pm qos request for hubs without port power control
>   * @connect_type: port's connect type
>   * @state: device state of the usb device attached to the port
> @@ -104,6 +105,7 @@ struct usb_port {
>  	struct usb_dev_state *port_owner;
>  	struct usb_port *peer;
>  	struct typec_connector *connector;
> +	struct pwrseq_desc *pwrseq;
>  	struct dev_pm_qos_request *req;
>  	enum usb_port_connect_type connect_type;
>  	enum usb_device_state state;

The fact that hub.h uses struct pwrseq_desc indicates that it ought to 
#include <linux/pwrseq/consumer.h>, instead of making the .c files do 
so themselves.  Then you wouldn't have to add the #include lines to 
hub.c and port.c.

> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index b1364f0c384c..2d09037fee93 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -7,11 +7,14 @@
>   * Author: Lan Tianyu <tianyu.lan@intel.com>
>   */
>  
> +#include <linux/cleanup.h>

Why is this needed?

>  #include <linux/kstrtox.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
>  #include <linux/sysfs.h>
> +#include <linux/of_graph.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/component.h>
>  #include <linux/usb/of.h>
>  

Alan Stern
