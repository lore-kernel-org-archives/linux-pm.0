Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8B426688
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603509; cv=none; b=pDk0kEluaY396GFo/XDmkDUkJGaV2/ZP++1aQqZA9QFQP97IfBRwIRLFGA7z3aGQVat50hvNvND2QEDzrcfcls8UULU9V1xQ1phEp01FuiRzrqyBHzgLD2a4Ctv5+TeOOu3o5dwvcAfpW71HtQkohMypycVXKjHG2EHDrEuW8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603509; c=relaxed/simple;
	bh=rKN6Dquf9JjEmoiOojbev5G9ca2XqPvpxKtiKVWHsuA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXxAA77qE3bMH96EpMUcwRL8EuKwoznx3m3UfiXubM85jFVZ+0dTyKeeGsTGJsQZl9LdWuwxqKXzvhUkFsQbXCQwRn4F73C+uadQ8wLaIesY3VwrG6Si8P3vpvEpIvMsdbQb6sKuf60fE7F7dMAu39lVMvTsyyc2Mka3t1ungcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F88UFqux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F88UFqux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874C71F00A3A
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781603507;
	bh=rKN6Dquf9JjEmoiOojbev5G9ca2XqPvpxKtiKVWHsuA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=F88UFquxP6GLTDnZndksxQH93yb7LMcZiAKfOmWMrZWnPbMsihpEeRj3B3ypIx14N
	 epvt/Fduq7ggo+VV9WejL+g7Sr8uUgpEwhUghrJOHV2dDu2cJpMGZAwcafnTN6Kwbp
	 a15VxT0oN1UFkqIjBTBPuz+ANyeGrSPc9cwc/Ba8wgMItVhAx1/RhWdSYi9MNN5EZL
	 /pngyeY6RoI0nwh7Z3R16ElAujbM26xlreosWrdgb2Uz0O09Yj8qqnp6vFlSetlLKF
	 BXjILI+uuZq84yMv33tltQiFi5KpHo5Cw4g55Nz/0ylLV1OUjYGEAN3Ht6BNupLR3T
	 h4rEOtybtCu8w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so4924422e87.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 02:51:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97oF8u1pXkLsSZsmfbCpPukNCKxQmm99cpvXqaUgd8mgwKljlRozOWkw3BC5SI6RMkvHF9xpdHKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhK1PYDmpKNYVglkfICwOR8LCYI/pAGcHu1ZvRgpDjXZsk5W8k
	N/dyT8qrdPr5hSDH5IdOKDXQtElXWMvgqO1A6EXu6swhECdhoPV3K9k01+mHBcLnYHNu3TWQSur
	DdczpvWm4M8y4JgtZf7cOy6EvGtcbPdKB3Bf/MbkF/A==
X-Received: by 2002:ac2:5597:0:b0:5aa:6aac:3f7f with SMTP id
 2adb3069b0e04-5ad4277bed7mr670959e87.22.1781603505619; Tue, 16 Jun 2026
 02:51:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 05:51:44 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 05:51:43 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ajEcDq0S067wMFaK@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local> <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
 <ajEcDq0S067wMFaK@black.igk.intel.com>
Date: Tue, 16 Jun 2026 05:51:43 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfY3k4a9KdPE-4pmMUEH4KADYaO8ZY+Md9sMzgFr0-s9A@mail.gmail.com>
X-Gm-Features: AVVi8Ccfi9fNZx5anc5Hh9w27iqbKs4Mv-ef0kQk9lnbNaF9SR74KH4RoJVGW8U
Message-ID: <CAMRc=MfY3k4a9KdPE-4pmMUEH4KADYaO8ZY+Md9sMzgFr0-s9A@mail.gmail.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide platform_device_set_fwnode()
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
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, driver-core@lists.linux.dev, 
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 11:49:02 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, Jun 04, 2026 at 05:32:27AM -0700, Bartosz Golaszewski wrote:
>> On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>> > On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
>> >> Provide a helper function encapsulating the logic of assigning firmware
>> >> nodes to platform devices created with platform_device_alloc(). Make the
>> >> kerneldoc state that this is the proper interface for assigning firmware
>> >> nodes to dynamically allocated platform devices. This will allow us to
>> >> switch to counting the references of the device's firmware nodes in the
>> >> future, not only the OF nodes.
>> >
>> > But why different for of_node and fwnode to begin with?!
>>
>> I'm not following. What are you suggesting?
>
> After re-reading of this thread, I think I'm suggesting the same what you have
> in plans to do in the future as you put it as "This will allow us to switch to
> counting the references of the device's firmware nodes in the future, not only
> the OF nodes."
>
> // Offtopic
> I haven't heard from you for more than a month on this:
> https://lore.kernel.org/r/af18zdP5HF3_P9Vo@black.igk.intel.com
> Anything should I do? Please, answer to that thread.
>

Eek, sorry, must have flown under the radar.

I'll pull it now, I will do a second PR for this merge window anyway.

Bart
