Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740934A773;
	Mon, 29 Jun 2026 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733318; cv=none; b=O3qdDfNfpjQzg4EXJCKhlAYIXisushhHgfY263i9ahGITnl7VEAIeqrGSVyxh88VC7dCckLh1CjVwZsXrDmTKDZy9elQk7jWCbPapO7uC8tJknbEUc8TpsAR+KX33Ur5DAlenxYk3bMhI7TEh04ACkDYNpQYVjSaDNBsVSoA0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733318; c=relaxed/simple;
	bh=XI7tjKfsCpj/p/vNSX2XrFm98TaRr68D01oPAiXFFwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7uJAIR2K7wDpS4d8H282795QPYUvQQ0a2JVeEClcY5xl+bcbKwKdrd4sjZ2oC6cjAaQ0xsUmj8EvW/DgX5KYIa5HmWaJnSXQOTWn+WRwLhVRdS8uapw43z9SdOFV/yQWvRO0akZcrCkBL2mGtrlKzSOHt5D9qHFG/iFy9RYYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0891C20027F;
	Mon, 29 Jun 2026 13:41:54 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1weAN7-005Eie-2n;
	Mon, 29 Jun 2026 13:41:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1weAN7-00000005hN9-35Ue;
	Mon, 29 Jun 2026 13:41:53 +0200
Date: Mon, 29 Jun 2026 13:41:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev, avaneesh.dwivedi@oss.qualcomm.com,
	umang.chheda@oss.qualcomm.com
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
Message-ID: <akJaAesz35Ml3iW4@pengutronix.de>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Faruque,

On Mon, Jun 29, 2026 at 04:44:18PM +0530, Faruque Ansari wrote:
> On 29-Jun-26 4:40 PM, Faruque Ansari wrote:
> > Hi Oleksij,
> > 
> > > 
> > > Hello all,
> > > 
> > > This patch series introduces the Power State Change Reasons Recording
> > > (PSCRR) framework and its related components into the kernel. The PSCR
> > > framework is designed for systems where traditional methods of storing
> > > power state change reasons, like PMICs or watchdogs, are inadequate. It
> > > provides a structured way to store reasons for system shutdowns and
> > > reboots, such as under-voltage or software-triggered events, in
> > > non-volatile hardware storage.
> > > 
> > > These changes are critical for systems requiring detailed postmortem
> > > analysis and where immediate power-down scenarios limit traditional
> > > storage options. The framework also assists bootloaders and early-stage
> > > system components in making informed recovery decisions.
> > > 
> > > 
> > 
> > Just wanted to understand rational behind creating this new framework
> > (PSCRR) for
> > reboot reason recording and not considering extending the existing
> > nvmem-reboot
> > framework ? As, this framework already provides a way to represent nvmem
> > cell in
> > the DT and the driver as well can discover it. Would it be correct if
> > nvmem-reboot
> > driver itself is extended with the features which this framework provides ?
> > 
> > or was there any other reason you decided to create a new framework ?

There are two main reasons:
- nvmem-reboot - Tells the reboot target - What should system do after
  reboot. This frameworks is collecting information - why we
  rebooted/booted in the first place.
- System may have more then one recorder or source of information. Non
  of it provides full picture. This framework should provide easier
  access to different providers. For example:
  - SoC tells PoR
  - PMIC tells PoR
  - Watchdog tells nothing
  - nvmem storage - tells under-voltage.

  All of them provide own opinion on what is happened. Evaluation or
  prioritisation should not be done in the kernel

So far i struggled with DT, but may be i need to put it to the side for
now to go forward?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
