Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF97501F4B
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540270; cv=none; b=PyTssOwWkhA+VeDFlyU6Ei7jSxZgYUXr8ApF+HyDvzfgjGh6GLdGjY8ADMq0363U0ajcKIXDWk3eo718mxhWFEMUxqhoMh7P8/oDV9K7JXdG5eP6cdPJvxwYRZixfRe0zSlT0xIaoKZcimLMpy/RPLb9zyzqiZDLOW6ERlmp1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540270; c=relaxed/simple;
	bh=zuOhkEhl9/3hyPjwkXOeT9Ut7Y3NkxiWsPCsZKsgbNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJJcLcy+h2leVTz/vNvjukGJwk0jCciIX4827s2bt8VYqw/Nip/bEDm5dhddMT4ofvi6oUsLHSyxHkk/HxQv0WqpOBpqFdvBtdIwnWSln7Zn20o/RK90DTC2ZmlPpylB9uWGIJ+n2BVZc9CjDfmkicpa8mfFMq9ibeJpB25A7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=B7bYHnO8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="B7bYHnO8"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90cdffe8e3eso13576116d6.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1788540268; x=1789145068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/3GNXQSGCY34ByWxnrlCAFhsDJSzJ5v9o2W5RmLNQI=;
        b=B7bYHnO8Z5IUF5Q0zumDpAn3bFIhRme1cBP1iPR82tUKmGBeVlf/irl0tcerQ+NQei
         eQ/SKa1HBSiJQiHNlDxMcCBgUbLdF72QO8gisnhHza0KYFDSXsERs10RgSDTtJ2p7jn6
         Lxj0MMautUOaHSs/mOWCNEpwwPsm4eqxtx/cKE0SAbfVkmP4v+cmNbYRKOrfkiaPohl/
         UQB48LmwbMWtTc3C+PPs//g5+iSJfDfhhO4UyjRjdM4FROili83DOtW9UOhTZAo23bSu
         N0gP2Etd8U9crqXwasRhJ/KSkqd6u12jiyV5IV7GSLDe1FTPnwGHYDecCNkuNIwsfr1Q
         udyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540268; x=1789145068;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/3GNXQSGCY34ByWxnrlCAFhsDJSzJ5v9o2W5RmLNQI=;
        b=KBmmBRybPgbUfiNhiMeVQe+OnUuKbx5aJJrN1+uOzspCcK0ng0ug5MWL6wUeUzlwbg
         PeBOp9vEgssHCZr1JoqH6ecLVs1DcEeeSuAmavhihxbGF4VgB3y/dwrXZCG0w//vlNVH
         VXyHcpr2uiyWZW9CsiNwtrx/M/T/KlAgM/481eu1fk7TrUZlZo3k36bZadr5oyEJV8s0
         wtJsYsuCqJgs22vUqWeutTQB6PcbEWqxcDbXvqgP8YygA4KtOhAJ0ihpvsABaVu7ckwT
         +tzpSnaB2lTKwZLiDqbWrQXi52zik+2+nKun7lQYeKOOl+xEuQA4Ayhlnet7WwP3V/6U
         kP+g==
X-Forwarded-Encrypted: i=1; AKwUvBziiuNTvuRMwxw30rzV+kI4zfLWLqjCYbhbYy+pQb/fALdaogsnjTRHLQGpdBHSJy0WZ3fBRFh1Xg==@vger.kernel.org
X-Gm-Message-State: AFuF++mrKWh5tOQtK8Qf3hknLJtxhEg7PcuS5Et9i4mR20C5gzsFHRmy
	sBPUOFNzqybS4xn3jtaKqRSI+cjhZm8YNNNVyHoag/H/eBaHpOtYnejjpOsB+2A+Bg==
X-Gm-Gg: AYBFou2aF8pZ1T4j6fRHFkq4dwCDJLTLMlQ41lBJwQIRVf5r+xo8PQajfEXptQ+yPSq
	T1yUTUrfLU5rDtN3pCf2p8ltSmnFlfXG2+8OWE+exMZYDX9yVaLOEpfenT4USO3MKKauADPkq3X
	dKopGpqKUu6J/0Ne90y4ZYuEn+9X/PnzWP/D4J2wUP1ejaUFWbhJWZnP/QpMv49UA9JvHIVtNQl
	gUmhuTNLj5uaBVp7/a8zTuYtPEgRWrCb7Mn4+Jhx4e+46lIRegzD7nowDNuMilbBPcsPzOjkaAw
	dJcU9gZM7CHhUzWeHYWaLYc3PGfpBnff51vI4qlwNouqegWfxqbZZgzsw2FHZxhfjiwJRSIZLHQ
	ePc4JDuRaOrXoh3EZE/VlB8iqNmKpgQrEUE1v6wnyDQe8lRRuUqOBjQXD97l8ZS/yHq3jk7EuM2
	Xd0N7gQiLpR56SI5djemo5zWLupIA+n7D3HHNtUSNDBRXEInI2rgfiQUhQWFclyA==
X-Received: by 2002:a05:6214:3003:b0:910:3d6e:ed46 with SMTP id 6a1803df08f44-9103f0db656mr78478096d6.31.1788540263010;
        Fri, 04 Sep 2026 09:44:23 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d64sm24672736d6.14.2026.09.04.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:44:22 -0700 (PDT)
Date: Fri, 4 Sep 2026 12:44:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 08/16] usb: hub: Pass |struct usb_port*| to
 usb_port_is_power_on()
Message-ID: <c3740c4f-6ae8-4c6e-8f80-105f1607ef55@rowland.harvard.edu>
References: <20260904084158.1341550-1-wenst@chromium.org>
 <20260904084158.1341550-9-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904084158.1341550-9-wenst@chromium.org>

On Fri, Sep 04, 2026 at 04:41:47PM +0800, Chen-Yu Tsai wrote:
> usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
> it to tell if the hub/port is SuperSpeed or not.
> 
> In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> state tracking field in |struct usb_port|. Either structure can be used
> to identify whether a port/hub is SuperSpeed or not, as the field in
> |struct usb_port| is inherited from the hub:
> 
>     port->is_superspeed = hub_is_superspeed(hub)
> 
> Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> |struct usb_port*| so a subsequent change can use it.

Minor complaint (not referring to anything you're doing here): 
port->is_superspeed really should have a better name, more like

	port->is_superspeed_capable

or

	port->is_usb3.

As it stands, the name is ambiguous.  It might refer to the speed of 
devices that the port could connect to, or it might refer to the speed 
of the device the port is currently connected to.

Alan Stern
