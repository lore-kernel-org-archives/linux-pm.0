Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93223A16AC
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325256; cv=none; b=bppSLc8w3z5zTXv/acfUyQDmQSs0OAzd/k+DL02ABEKYR7JtbnE2vLcqhyehiGOmkgYrJnEfpzXFyU42Ig98BNei95cCyFOK5Y6vL+ABYiOAsOwyzJ7XJK2V/8NWZCZopsCFdwokkkpBubq9XER6/eZJDMwBl1AWDfcYlvVDTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325256; c=relaxed/simple;
	bh=9CGkjdaf9efUWmVF8DkWsBSG/mNOtkaQY4XZbz1OfAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGOwATIlG3B0Q8CQf1Bnszc8kdivNp0l5X6XFaUk6oKw52rqB7kBhK1Oyig8r79kCPIsJ3GV7AT1/5wiNztEwhsjPQXMOLeVG5ju4vGP/z02/r4yQOTsVZ5DN2+mHnpmnhkVylXR+O6a77Vraj3id5qoubwBHZwjXZhHM3EzE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ygsIKuOt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygsIKuOt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8299f1ca894so2984920b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 21:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774325254; x=1774930054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7SqHnHYZqEYtwdh+YkC9S161bBgEEEQDmxfAGwav9w=;
        b=ygsIKuOtMQ3hKmi54IkJFj3o4ZTQvxAPFmrDZQA/WuJX51JT3yp0RQLBgpcEv9vwZP
         dQwPi18O2PuJPVTDi+X2mt4zV58XePhM+0EN1t+26BMOWBR/kKtACbUi4Ja5lngZjD/e
         pElL+06ucmyz/aBgmWzkHIRi8Pi+HqaDv2horrX3WOljIrl8r7dG0mhen54QKU90BWnA
         zq2pM7RPhd+C9vOHS7iIC0yzSNIfXMMQPSzzMrClqBMsDCCyn2aYhD0ZyVlDa1O87gKA
         dhMBEeq7OkHCtnsKBAf4vAgAlKKyMt7uLrF/yI8O6pYz1hVlFToL5FSDzlf18UsTqznW
         ERog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774325254; x=1774930054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7SqHnHYZqEYtwdh+YkC9S161bBgEEEQDmxfAGwav9w=;
        b=cqYQtzFyUNCc7yb730ujmdsx0cuxfE5ie818fW9FAKOvPVI4+NhOFY/7TWemI9hGA4
         XMtTga34xyXLsA8yGMWXZuKnQJefq2DTjZS8KVS+IYXPprLnXpGYXRz4HwQ95DYE3B1Q
         vOyTAkdeXHQGF5LDImiVsnsP3QkGAn6zALYc74q/LZCEOFAPZ+r4xUNIVDoZx67ldrf1
         0QRop8OrYbMjc5VdbpYmOGiWpG/rOYV2uVMRJdKKnzIkhhvfFJP8DHLUjQCWuK0beb6c
         gawfjAs9jgFkB6ghi5uODKvK9Qldai2exM/4YzYujf/r3zO2tRD2AgeOu3RMHtHxSZmK
         z3+A==
X-Forwarded-Encrypted: i=1; AJvYcCVx8WIcF57/Aa0AmjNw+X3SwB51OSiNnRI85/Q8HT+CEhedzW5TV5Bh4cgekYATZPiSiFrdkOrMzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFadnR0TDnXKtRpu09Knmd9qm+VWyihC+3UYXqVQbzcBWgc+3I
	W44ZA8bTZ8/kLUQcF/JRDGIqOX2MOORsmyiPjtn5aTnwy7HvKT5UcZSv8PTOvmtbj1I=
X-Gm-Gg: ATEYQzzilK9RGvIZ/0uOZvF2E1r+ioPLBuw59+1vcXIjxnmDQZicoIiRmXH681zzXDD
	act9kVhXPJjiwo94+xQKb6GZ6qC18gAprLZSq4iPbh8VKaFjpN5LL3jhEkm5yQn9R1dchTGQeKY
	5adDp4+WJMbRPiSy9MikSA6HcpJJloL5Z12oQxkXQjLpkHH7jGlGjDghGjIDpSqg5mPk1s8Dmxp
	R1set8WX8PEBP8zt9pGHsCIso8q5I+0nEKm1kzNRs3ec+BqQBcUeYQaga5F+5bPMuYQ48Ljo0RV
	nJDT5nt5Do3IoC8KuFzB3AjuKN7QxiXy03xd39/yOkck4qNRVf3ZfnOry3CK4zUsximQc0dx5OI
	N1fiRU7TMoxQJo1oyLDsfzh6mHF27qmFJhwVBzJvwaLqMSoK+RT7/vig74yKi0wUz+W/73DAvd+
	Y55VPGrLz8O9qyESfKiXYGUW75KPGk1hpVfcQ=
X-Received: by 2002:a05:6a00:3bec:b0:82c:2155:5b6d with SMTP id d2e1a72fcca58-82c21556203mr7996673b3a.12.1774325253941;
        Mon, 23 Mar 2026 21:07:33 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409bf65sm10979176b3a.34.2026.03.23.21.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:07:33 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:37:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 0/2] dt-bindings: thermal: st,thermal-spear1340: convert
 to dtschema
Message-ID: <n6jllrlsu5fatso5geeyjgiuefzj7qclkpsptgpowdy6splnip@re32x6zwepsp>
References: <20260323133814.14152-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323133814.14152-1-krishnagopi487@gmail.com>

On 23-03-26, 19:08, Gopi Krishna Menon wrote:
> This patch series converts SPEAr Thermal Sensor bindings to DT schema
> and renames thermal_flags property in spear13xx.dtsi to
> st,thermal-flags to fix the unevaluated property warning in
> st/spear1340-evb.dts.
> 
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
> 
> Gopi Krishna Menon (2):
>   dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
>   ARM: dts: st: spear: fix dtbs warning on spear thermal sensor
> 
>  .../bindings/thermal/spear-thermal.txt        | 14 --------
>  .../thermal/st,thermal-spear1340.yaml         | 36 +++++++++++++++++++
>  arch/arm/boot/dts/st/spear13xx.dtsi           |  2 +-
>  3 files changed, 37 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
