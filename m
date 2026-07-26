Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE7376BD9;
	Sun, 26 Jul 2026 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096281; cv=none; b=jkpGTD4RaBAr+A+ASyliiSOwEHIPspTPwLQlPpFnQ2apDWt4Ztg382sNmFvLvOe3HpWvKsvs4WaBkENf1oUGufqDgq7wrf0B1tbZdOa6LFsro2ybIidt7vDV4AqIpkHRetQ8UO1XBbBz3VV4Olr3C3Sfi33b8IOMc6cAGeD3Gng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096281; c=relaxed/simple;
	bh=o/ZkTxHN92Ux508EsSCnImcb/mYYjoiY375fVhJlGI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPXTqZzYCiXpGr5bE+2d3E/M1zU5As8Hw9y4mwHpOR8MdeMuJc2EWAv8a1aQBX5OpoyJqe0XdzFyFAiOP9gdAinGgupiPFetwL7CFarZmJ7lJo74RAcwdLgrb0ugjolfz5dW4XzBYQDbm0DyeU0IrdSjl35jdPoDHPPvysWbI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E5C0020258A;
	Sun, 26 Jul 2026 22:04:29 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wo55J-001QVo-2f;
	Sun, 26 Jul 2026 22:04:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wo55J-00000004lit-2pOz;
	Sun, 26 Jul 2026 22:04:29 +0200
Date: Sun, 26 Jul 2026 22:04:29 +0200
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
Message-ID: <amZoTd1w6okw0Rw6@pengutronix.de>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <3309e88e-e189-42ea-b74e-346aec1b4b5f@oss.qualcomm.com>
 <729b0e26-bdbc-42f9-8245-79b2942272c2@oss.qualcomm.com>
 <akJaAesz35Ml3iW4@pengutronix.de>
 <4b5321e8-05c8-4f3f-bc22-d3776e008151@oss.qualcomm.com>
 <akXnLLl_nq2G8EGI@pengutronix.de>
 <f1400208-0c47-4dc0-8b69-d3ca2b054bb4@oss.qualcomm.com>
 <e78ac252-1631-4f8c-a0e7-e48c66c20d9c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e78ac252-1631-4f8c-a0e7-e48c66c20d9c@oss.qualcomm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Faruque,

On Fri, Jul 24, 2026 at 01:17:40PM +0530, Faruque Ansari wrote:
> Hi Oleksij,
> > > > On representating nvmem cell to the framework  - if not DT what
> > > > is your plan
> > > > to represent it ?
> > > > 
> > > > How would framework discover the nvmem cell if its not DT based ?
> > > 
> > > I'll need to re-spin it and send a new version.
> > > 
> > > Are you on linux plumbers conference this year?
> > > 
> > > Best Regards,
> > > Oleksij
> > 
> 
> Just checking in - Do you have a rough timeline for the re-spin and posting
> the next revision?

Hier is updated version,

I did some framework refactoring to address some of comments. There are
sysfs interface changes:

https://github.com/olerem/linux-2.6/commits/v7.2/topic/pscr/

My plan is to send first 6 patches without drivers (if acceptable to reduce
review overhead). Can you please test the new interfaces and give me
some feedback.

May be, if you have some time pressure for this functionality, you can
take over the up streaming. Otherwise i'll continue..

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
