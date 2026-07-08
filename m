Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562353DDDA1
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496610; cv=none; b=ElsspwUq988pYjGj+NBzrgqPtbLL6P+Q/KMHJ/8S+u0DwZ7ZdgJDDu01QmWeGN31yt9DA9AHC9DPgobPxetWI4P45o66n3riXLI3DHGeOU4Yz4cGMH1r35EW2JW83LemxnQm0hmpWJ7Iv/qsrWNhQLfqdLiGepyFGjjTlxOMIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496610; c=relaxed/simple;
	bh=wqspe9peDUDf7Lj0Ckvg+Ou41duj870AZXBlowe/bLA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMilR8IuzhvKrmeZWf1J9kLp7jgBaq7vqgYU244ym4uvKGLmzMu5lsyM4dYnlL0VnZqL8LM2XNdI7kPq4/HP0VqyPQq0oG52Y2TY6ct/BEjpLwTvN6ZLKflSOKTVpWkyer8Q3gBDqBp9gHMQjW7MxbaY3aoIW4lAztN1KJ3+L1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k18jVUIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k18jVUIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1603F1F00A3F
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 07:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496583;
	bh=wqspe9peDUDf7Lj0Ckvg+Ou41duj870AZXBlowe/bLA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=k18jVUIZ5iuyTiVbZ44DkGQWkxC5E7bw7/+E8NYse+rkTpXZzQFfeEgv+aRPJtLgK
	 tf1P/iE0lLIQFSg5OcR7el4tOu/ccCyqUbAjygnzrlszIoazxcVgVjKtIvhFF42Xy5
	 WE0pHqo/7840yTF0CxwEdFP32p2CTVaQHEB05MwjF7aqcPeyB12H3DkjXEyHeQm4V3
	 fzHQc2QQHKrgcUC0SEWbaYJcmr0/U/Cenl37AO5FjZ9Grq+pW7XlQ8kTjalgwwwhvi
	 9q/1OJYw5TlqjbE6ZQB9jxbnDgQnLAKSQYiEYvpEREP7gd+tdiX97s7H/INk+MhXz4
	 IX8UePaCWvj3w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b01146b205so296686e87.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 00:43:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrh9oGsr8BpdTVzbaZe2GfdJqAvtSIk5zlXMikIIIiRHS6e/JCQ6/T/knqyYOEmL1Uvs15N+B83Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgPo+i0ryFURSbuDtwNbDakBTSk1/sT95+SIIloiVrJ0Hlf6C
	fRVxnVZO/pREdjMn2BfubVj5/Vc5gcEZ/qrmKR7sijouIiUIqspLgPa6nvMLBhoqzHURKwCsTaT
	/CtUSd/HnbtTPZgBHsifeGvO31nGwwpxWgozDWPaAOg==
X-Received: by 2002:a05:6512:3a8:b0:5ae:a9eb:c5c3 with SMTP id
 2adb3069b0e04-5b011478162mr274920e87.61.1783496580641; Wed, 08 Jul 2026
 00:43:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 00:42:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 00:42:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ak0jyUbNonSRiP_g@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com> <ak0jyUbNonSRiP_g@ashevche-desk.local>
Date: Wed, 8 Jul 2026 00:42:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
X-Gm-Features: AVVi8Cc97SNnhCE85729H_fOi3Wx8wY1APMX-PhjHPSFVtKB-jxewFEQvchpN2c
Message-ID: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for platform_device_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	mfd@lists.linux.dev, Manuel Ebner <manuelebner@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 18:05:29 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Mon, Jul 06, 2026 at 02:44:17PM +0200, Bartosz Golaszewski wrote:
>> Users of platform_device_alloc() + platform_device_add() must not modify
>> certain fields of the dynamically created platform device object. Update
>> the kernel doc to say which fields are affected and which functions to
>> use.
>
> Consider using __private checker attribute for them as well. It will make
> sparse scream.
>

Sure but let's leave it for another series.

Bart
