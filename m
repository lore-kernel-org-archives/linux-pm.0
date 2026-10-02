Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355584ACC74
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947786; cv=none; b=k9/laxmPduDFzi8q8IzBlB35Iw53EzL+g5XRHvdUaScUTxw7nSnvC8slL7BLKtO75Gut24CGmNJHiMzCb5OwZPH27vMIFkuyNjej9XJ67B5gKWG93Vvbw79niSJBVPpUwUlr8ZfiEBu8R9ftTPu/uEySdFDKK7eau/49qkhzMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947786; c=relaxed/simple;
	bh=mz9iUP0v4DTEP90FdhR7m5iuHGwHG/WevtKBp9xCmIA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpPwSxgLCPtUPQzJ9SgTDv3637Ti4ashESPG9WcHj6zKv2WQLJWrex7XqLRGbK6ngpCOzpnoJp0pw6lTnYqzfyoJCcpA+x6EPoasHexw5OGoTOjaVnDXOz2Z0OKDRmd8oh2iRQrEFQK1Nw6cxzosFpO3TBb13OXahS19g89MwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANsUYav8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANsUYav8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79FA1F00898
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790947779;
	bh=mz9iUP0v4DTEP90FdhR7m5iuHGwHG/WevtKBp9xCmIA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ANsUYav8iQZMtHoNw/c861LtduJYf0cs0fpIyp57ZAefntEBl9XtLc8cWRvWB5cVb
	 9oUHoVTtJpDLnH1CnWCKvxID+mxM/72V4afC5FiJ48JhooZwJGzHjdU+EfLfNSVWCb
	 EUqTI0HHMMRWsdVJjPa1vf6u8nAy/XVkfZNAyFuih1042Yts6Nzi8KlJfM5zLT6UIp
	 TqnuYcv4oByHp7TC5tVICvw6bqPYyoF8Md6muCPABkMBXvrzG9EbHZqtH3xPSk6953
	 72DBFrh3qPl80+YZs9By46io5SJgIj+h2ZIzMJqkSBO1gszU4xNZCb6Q8uKexS9GIT
	 6zAanF8QcG7jA==
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a87a4aa6f2so13514051fa.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 06:29:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzx4lkRYOJJb8NHvsQBHhalfKqE9EnRlTUABA7ROiUd0hfue24fhYmB+nZ9ii0grhgHZAzltOOY5A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3egUc5GYm8SQLzA0CAO9PBCm4wFrD+1RX54mZZIDqIVqoenFq
	nLGEwHOsnloGY2o6UlVnz9D7+aqGFpGkSL1tkFv/J1DU0EKJdRPR0tsZ4qK64Dp+HD7MMXs5eoz
	CsuQkoVMP37JMbUPoW+hZDHqo5T9dpizJ6p3a/igqMQ==
X-Received: by 2002:a2e:be8c:0:b0:3a6:4452:bff1 with SMTP id
 38308e7fff4ca-3a8877b37dcmr7461191fa.16.1790947778657; Fri, 02 Oct 2026
 06:29:38 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 16:29:36 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 16:29:36 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-4-b24e2348e8e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
 <20260928-arm-psci-system_reset2-vendor-reboots-v26-4-b24e2348e8e1@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 16:29:36 +0300
X-Gmail-Original-Message-ID: <CAMRc=Mchn4YHX3p+Y1f+mpW2DW0Vv5Z5xngxWJt8rczY23Fp5g@mail.gmail.com>
X-Gm-Features: AclHuK-Ef5zXTasgvfxWkin_hCN8CWI4Y3M6MqXWqh3YH1TDztK4qUV84kA9Flw
Message-ID: <CAMRc=Mchn4YHX3p+Y1f+mpW2DW0Vv5Z5xngxWJt8rczY23Fp5g@mail.gmail.com>
Subject: Re: [PATCH v26 04/10] firmware: psci: Add support for PSCI auxiliary devices
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sep 2026 08:09:16 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
> Currently, both the PSCI core driver and cpuidle-psci-domain bind
> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
> introduced, would also need to bind in the same way, leading to multiple
> drivers attached to a single device node.
>
> Introduce a PSCI auxiliary-device provider that binds to "arm,psci-1.0"
> and registers PSCI child devices on the auxiliary bus. As the first
> user, register cpuidle-psci-domain as an auxiliary device.
>
> Update cpuidle-psci-domain to probe as an auxiliary driver and use
> the PSCI device node for power-domain traversal. Allow the probe to
> succeed if at least one auxiliary device is created.
>
> Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Suggested-by: Lee Jones <lee@kernel.org>
> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
