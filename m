From: =?iso-8859-1?q?J=FCrgen_Borleis?= <jbe@pengutronix.de>
Subject: Re: [PATCH V2 4/6] DT: add binding for mxs on-chip regulators
Date: Mon, 4 May 2015 15:51:26 +0200
Message-ID: <201505041551.26355.jbe@pengutronix.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com> <1430346747-28728-5-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55690 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbEDNtP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 09:49:15 -0400
In-Reply-To: <1430346747-28728-5-git-send-email-stefan.wahren@i2se.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, fabio.estevam@freescale.com, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, sebastien.szymanski@armadeus.com, Shawn Guo <shawn.guo@linaro.org>, David Woodhouse <dwmw2@infradead.org>

SGkgU3RlZmFuLAoKZm9yIHRoZSBpLk1YMjMgdGhlIHJlZ3VsYXRvciBkYWlzeSBjaGFpbiBsb29r
cyBhIGxpdHRsZSBiaXQgZGlmZmVyZW50OgoKKy0tLS0tLS0tLS0tLSsgoCCgIFZERDVWIKArLS0t
LS0tLS0tKyCgVkRESU8KfCBEQy1EQyCgIKAgoHwgoCArLS0tLS0tLS0+IExJTlJFRyCgKy0tLS0t
LS0tLT4rCnwgoCCgIKAgoCCgIKB8IKAgoCCgIKAgoCCgfCBWRERJTyCgIHwgoCCgIKAgoCCgfAp8
IKAgoCCgIKAgoCCgfCCgIKAgoCCgIKAgoCstLS0tLS0tLS0rIKAgoCCgIKAgoHwKfCBEQ0RDX1ZE
RElPICstPi0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnwgoCCgIKAgoCCgIKB8IKAg
fAp8ICAgICAgICAgICAgfCAgIHwgVkRESU8gICstLS0tLS0tLS0rICBWRERNRU0KfCAgICAgICAg
ICAgIHwgICArLS0tLS0tLS0+IExJTlJFRyAgKy0tLS0tLS0tLT4KfCAgICAgICAgICAgIHwgICB8
ICAgICAgICB8IFZERE1FTSAgfAp8ICAgICAgICAgICAgfCAgIHwgICAgICAgICstLS0tLS0tLS0r
CnwgoCCgIKAgoCCgIKB8IKAgfCBWRERJTyCgKy0tLS0tLS0tLSsgoFZEREEKfCCgIKAgoCCgIKAg
oHwgoCArLS0tLS0tLS0+IExJTlJFRyCgKy0tLS0tLS0tLT4rCnwgoCCgIKAgoCCgIKB8IKAgICCg
IKAgoCCgfCBWRERBIKAgoHwgoCCgIKAgoCCgfAp8IKAgoCCgIKAgoCCgfCCgICAgoCCgIKAgoCst
LS0tLS0tLS0rIKAgoCCgIKAgoHwKfCBEQ0RDX1ZEREEgICstPi0rLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0rCnwgoCCgIKAgoCCgIKB8IKAgfCBWRERBIKAgKy0tLS0tLS0tLSsgoFZEREQK
fCCgIKAgoCCgIKAgoHwgoCArLS0tLS0tLS0+IExJTlJFRyCgKy0tLS0tLS0tLT4rCnwgoCCgIKAg
oCCgIKB8IKAgoCCgIKAgoCCgfCBWREREIKAgoHwgoCCgIKAgoCCgfAp8IKAgoCCgIKAgoCCgfCCg
IKAgoCCgIKAgoCstLS0tLS0tLS0rIKAgoCCgIKAgoHwKfCBEQ0RDX1ZEREQgoCstPi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCistLS0tLS0tLS0tLS0rIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgfAogoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIHYKClJlZ2FyZHMsCkp1ZXJnZW4K
