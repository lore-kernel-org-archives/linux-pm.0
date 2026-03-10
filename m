Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515744B696
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134978; cv=none; b=IhyyNqeApZYfRJ2QR4j0GK0aoFQUJ2pUqVYw5Qf9XhGPOf9BM/X4TveboXN5GTeKc6hyBQZuDFDvSXh49Hq7X4Ocfmq4aKW+K3bffAMC7SGyi+I9fAniv9CQ5pP5eOsKNFuCfPzuJOCOglbo1yULZJksBeH56Ms+Oz37/VVTaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134978; c=relaxed/simple;
	bh=fSwpCH/UFERQ5kjBBQPd4Vfpb4R38RfBExl1BwL7OIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRbRqsEb+23OBwnpJpm+QA7IpuBB2fUoVBneqJTHnrpneaNwRJRRPILGBmcPsYUQES9jP9DiYg6ufMNoULoh2N02y1Zg3f/ACkhrnND9gGcZLq/QnfgxgwC6TdKoNdP5sTZ/MqaHDzz4go/bG8SkwuYdiN7S48qHdklh40M9b2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vztP1-0000B7-QO; Tue, 10 Mar 2026 10:29:23 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vztOy-004fqr-1H;
	Tue, 10 Mar 2026 10:29:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vztOz-0000000BUUr-2Wql;
	Tue, 10 Mar 2026 10:29:21 +0100
Date: Tue, 10 Mar 2026 10:29:21 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@pengutronix.de,
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
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PR 174] dt-bindings: chosen: Add "power-state-change-reason"
 nvmem property
Message-ID: <aa_kcRRg5uGQjd96@pengutronix.de>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <aN5pSWBFRZlNRv3U@pengutronix.de>
 <202510020904.1E48B7EB@keescook>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202510020904.1E48B7EB@keescook>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Rob and Krzysztof,

Following up on dt-schema PR #174 regarding the PSCRR framework. We are
currently stuck in a maintainer deadlock regarding how this framework should
bind to its NVMEM cell, and I need your consensus to proceed.

In the PR [1], Rob noted that /chosen only works if the OS standardizes the
NVMEM values. If the values are platform-specific (requiring a mapping driver),
Rob suggested creating a dedicated DT node akin to reboot-mode or
nvmem-reboot-mode.

However, in my earlier kernel patchsets [2] , Krzysztof explicitly NACKed a
dedicated PSCRR DT node, stating that it represents "OS policy" and a software
abstraction rather than physical hardware. Krzysztof suggested instantiating it
via sysfs/modprobe. I attempted that in v11 , but Greg strongly rejected [3]
the sysfs/module parameter approach as fragile and outdated for the driver
core.

We need a robust way to discover this cell during early boot across full power
cuts. To break this catch-22, could you please agree on one of the following?

- Option A (Dedicated DT node): Permit a dedicated pscrr-nvmem node (or a
compatible string on a fixed-cell) as a valid firmware description contract,
following the precedent of nvmem-reboot-mode.

- Option B (/chosen property): Accept the /chosen phandle approach

I am happy to implement whichever hardware/software binding pattern you both
agree is correct for this edge case.

Best Regards,
Oleksij

[1] https://github.com/devicetree-org/dt-schema/pull/174
[2] https://lore.kernel.org/all/58d24ddc-4e8f-4932-ac37-c9a699d36425@linaro.org/
[3] https://lore.kernel.org/all/2025071631-henna-synthesis-9961@gregkh/ 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
