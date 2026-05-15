Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25472314D18
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854538; cv=none; b=Xmx9Marx7mRVEMVPCuOyaNTGq9AMsbNqD8sLrLtIzh5QzlRpSMMy9irVZmVsTUyy+CV9QcRjz6YWD1zo2q9hm11odKlpKYEKc2azo+UXFYkOc9LXxXILO3USPYS6YiN+QHPLsfMDMU57TL4qkHg+Vt5z8gdLQp5nYNB0gUuXhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854538; c=relaxed/simple;
	bh=AxIVVOkP8DzfUfnvY2EXq41TePoQG93Dw8tHUJ2/FXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELVFH9VfrML8/3A8lGaIcmw0Q2lTW5MmGzyJ2mB4YcGVh46YM+5AtzVKI4F51FakpqxhvXP9s4JC0+Wt//wWg1EqksbBFc19WR/9mC2gmqzIzjdOGwx5fHDx8AUUAueGIqOKWi7azbjSRdoVffAXPw2wHMQhbfU30s8mSaEra9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLw/s0Tp; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLw/s0Tp"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479dd56d016so6957056b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778854536; x=1779459336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3Ba1jDpFlV6BYps4ROIqTWMi/TLCycbOgGvzvGmAoI=;
        b=HLw/s0TpdyB9b+Cnbtd5LNKL0CcnZSA4okKrMtybZgK0qcaGd8wCrP4vZerumNCP/S
         g+/AbTg5JYBRDRL4pz9p0k+4SQrms9z6wqErao1Zdd4bR6RLBrQEwClsT3s4MXqUrzQ9
         82ohDatr4nHoQlw2hqKmNvyUv26aXtnW0oQKZ4iclcCAt+t/MPhoDkqx6fKAPzK86krU
         B7O4mwsaPr2LYALMRUzBgXNGsirvdjxs+IyyfBklQ42T45EgbhR83YRmR+zWxLCRwDcp
         ny5hbvigiXRQlXZrIUoP4NhgEljHZyWJYQtKnKWMfuIBk0SWAeppoJcTFFN393VEGUXR
         k+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854536; x=1779459336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3Ba1jDpFlV6BYps4ROIqTWMi/TLCycbOgGvzvGmAoI=;
        b=Au16ttAo6Mufjx2BVxzQZegYmPE6kFLNUFggQdMavrB9pnRwjdl/PlY2VvVWdRUF4s
         oy0ucTnt5LwQeUXcEIeFuO5JYM+oSQZU0XETjuPt875pjPnx4F4+IfzA+CJ/TM8AMG/G
         o+qPVvJJQR9+aWeW7Aeemy6ERguF3keCEw3A9JyTeFATuxUisMOHfJZ0c7J1T2PQkRO+
         P7a0vJonM8RNdMEce3j7dxLKFHcqsMH6wZs638j4w+Km/UdKF6ZY2ikWhhD+4SxGBsoE
         hCi5rJOtTEUi4MzOpdOlatwmhJ5BbxNakJqgv9Y1vzZAYyMibzZdSriKLStoQLxZZx0x
         QV0A==
X-Forwarded-Encrypted: i=1; AFNElJ8ZqZRCseJYtdqjazEw8AyjNawY4wN2LQmDAdnTOwEu/q4MyXPvnxd4ofl1ml3DeiSVck2H4AmmNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4NscqDymhTBWE7D6uCabjIeV2KvIN6keuYbPIPiIpVogKChw
	8QOhtJ7Say70ln4AtlFHxFyuwJhIWEUUN3ge+jpHijL9lMQLbU1JZNDOGR5WU5hX
X-Gm-Gg: Acq92OEyNYeIu1F6XvCp0qBhpPax/cTJ8z95OQrDyZGL667TNjxzf7tqnVtBPf9JEly
	soFFsM7IDT3rqJO8s3RymffZIGyF6dlUxWxyv9omTipSGC/mlWZXyuRrIWf2ItqZti3mCSBYwEU
	yLq4v5jGEvL9O3Ikqp7CZjeUZ3KM1V1V/s9W0YCE+kE1MABWSmbsfwqNbxU7XKxfkitkvTzshAp
	KynYWYKsjBjeaGM3o6S1X+J6f24X86TTEIzke/4K4ElymGBcwLH71UyAj9VIxVFsQSKDJQ3BCWA
	1Gy++kfWs/uir6DYPp4Dm9xwyXCJThmyNxOLgY+fO0vBhEI0V+HXrqHu1OnD9Hjpab/Zu/OL3zK
	11S5KMLB6XbToptOrYie7xKDoXQ0uld8bAFOg5xn6+tFWB3GBqMC1RT9DFqTqRQ9oFG0pERqYEP
	YlXN1JALKj+n8in/guDfL+uSIiR+mPWlLmWspoxP0Jat48
X-Received: by 2002:a05:6808:1982:b0:467:2a6e:adb3 with SMTP id 5614622812f47-482e5729bb3mr2592192b6e.23.1778854535958;
        Fri, 15 May 2026 07:15:35 -0700 (PDT)
Received: from neuromancer.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee38a5ecsm876341b6e.7.2026.05.15.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:15:35 -0700 (PDT)
Date: Fri, 15 May 2026 09:15:33 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch,
	airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com,
	neil.armstrong@linaro.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document
 sgm41542
Message-ID: <agcqhTCtrerKplSD@neuromancer.localdomain>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
 <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
 <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
 <534f0795-0002-4c04-a83c-fa1b3ce68216@kernel.org>
 <PH0PR19MB99733813E0295B511539050BA9A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260429-boisterous-cyber-hyena-ce870a@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-boisterous-cyber-hyena-ce870a@quoll>

On Wed, Apr 29, 2026 at 01:58:22PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Apr 28, 2026 at 02:54:53PM -0500, Chris Morgan wrote:
> > On Tue, Apr 28, 2026 at 05:09:49PM +0200, Krzysztof Kozlowski wrote:
> > > On 28/04/2026 16:09, Chris Morgan wrote:
> > > > On Tue, Apr 28, 2026 at 09:47:00AM +0200, Krzysztof Kozlowski wrote:
> > > >> On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
> > > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > > >>>
> > > >>> Document the SG Micro sgm41542 battery charger/boost converter.
> > > >>>
> > > >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > >>> ---
> > > >>>  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
> > > >>>  1 file changed, 99 insertions(+)
> > > >>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > > >>> new file mode 100644
> > > >>> index 000000000000..3e5041e5b551
> > > >>> --- /dev/null
> > > >>> +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > > >>
> > > >> Filename must match compatible.
> > > > 
> > > > Acknowledged.
> > > > 
> > > >>
> > > >>> @@ -0,0 +1,99 @@
> > > >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >>> +%YAML 1.2
> > > >>> +---
> > > >>> +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
> > > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >>> +
> > > >>> +title: SGM41542 Battery Charger
> > > >>> +
> > > >>> +description: |
> > > >>
> > > >> Do not need '|' unless you need to preserve formatting.
> > > >>
> > > > 
> > > > Will fix.
> > > > 
> > > >>> +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
> > > >>> +
> > > >>> +maintainers:
> > > >>> +  - Chris Morgan <macromorgan@hotmail.com>
> > > >>> +  - Xu Shengfei <xsf@rock-chips.com>
> > > >>> +
> > > >>> +properties:
> > > >>> +  compatible:
> > > >>> +    const: sgmicro,sgm41542
> > > >>> +
> > > >>> +  input-current-limit-microamp:
> > > >>
> > > >> Missing vendor prefix.
> > > >>
> > > > 
> > > > This *appears* to be a standard value (perhaps not formally, but in use by
> > > > enough devices to suggest a defacto standard), which is why I did not use
> > > > the vendor prefix here. Do I need to add that for this one?
> > > 
> > > I know, I found these other properties but I think they were just coming
> > > from old schema.
> > > 
> > > If it is really a common property, then should be defined in a common
> > > schema and this did not happen.
> > 
> > Would now be a good time to add it to the power-supply.yaml document?
> > It looks like this value is used by about 10 other devices.
> 
> I have mixed feelings. Adding it there would mean that all schemas using
> unevaluatedProperties will get that property. That suggests they have
> such limiting ability in hardware or this ABI is implemented in some
> generic part of the kernel.
> 
> None of these are true, I think.
> 
> Maybe we need some documented guidance on usage of common schemas.
> 
> Best regards,
> Krzysztof

Would you recommend I just use the vendor prefix then here? Or add this
to power supply as an option? Or is there a 3rd option you would like
for me to pursue?

Thank you,
Chris

> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
