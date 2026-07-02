Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76083546FE;
	Thu,  2 Jul 2026 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782966065; cv=none; b=iNyPlbPo1jBi37pAhSNCQQ06YzTIkyG8NwIjFIJDDJErHZw8fVQCS+mGa8VQ1SoCVZ89AmSPnTK2J5ml0/T/ZJ1epYdL7qEsqsJNqT8F3biPU6xFUPSqvxKfA93sR3F9J/EC8JqSfPQprV8ToXomRTc+UgxjgO3NfyNE9iB5ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782966065; c=relaxed/simple;
	bh=XLQQx3d6kGS4PSmwpnvkbJ1gEOE1tFn00X90BmohfsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8WjR45BPhTQ5RS0aEfVp1ToexQWk0aOCdA0R715g2dwbNZXrn1bdW/aMWpMaVSTyX4pfkyUKMKQNb8tLjSsL4fGWWP5V9EZkC8UjyTMjoerb/4y896aiUdEyDI+BYxLDAQeW4NEUocmGvXwj792HZSciHLYb2QwQPvy4hAyOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61A77200B5C;
	Thu, 02 Jul 2026 06:21:00 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wf8v6-005gkb-0y;
	Thu, 02 Jul 2026 06:21:00 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wf8v6-0000000DC9x-0ede;
	Thu, 02 Jul 2026 06:21:00 +0200
Date: Thu, 2 Jul 2026 06:21:00 +0200
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
	umang.chheda@oss.qualcomm.com, faiyaz.mohammed@oss.qualcomm.com
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
Message-ID: <akXnLLl_nq2G8EGI@pengutronix.de>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
 <akJaAesz35Ml3iW4@pengutronix.de>
 <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Faruque,

On Wed, Jul 01, 2026 at 06:26:37PM +0530, Faruque Ansari wrote:
> Hi Oleksij,
> 
> On 29-Jun-26 5:11 PM, Oleksij Rempel wrote:
> > Hi Faruque,
> Thank You for sharing your rational behind and idea behind this framework !
> IMO it would be better to have a single framework to represent all the
> reboot reasons of a system and not just the reboot reasons caused because of
> errors
> Ex capturing reboot reasons like ota, bootloader,recovery etc ... currently
> nvmem reboot driver does not expose a sysfs/ABI which user app can use to
> infer reboot reason ...
> Also, it would be extend this framework to also support firmware triggered
> reboot reasons  ...
> Do you have any plan to extend this framework to support userspace triggered
> reboot reasons as well like bootloader, recovery, ota etc ?
> And also extend the framework to support vendor specific reboot reasons
> which can be triggered by firmware  ?

I have nothing against it. My imagination was limited only by some of
existing problems :)

> We can co-work to extend this framework  ?

Sure. Should I put it somewhere on git, so you can try your changes
on top of it?

> On representating nvmem cell to the framework  - if not DT what is your plan
> to represent it ?
>
> How would framework discover the nvmem cell if its not DT based ?

I'll need to re-spin it and send a new version.

Are you on linux plumbers conference this year?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
