From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v6] cpufreq: add imx6q-cpufreq driver
Date: Mon, 4 Feb 2013 21:12:17 +0800
Message-ID: <20130204131213.GA19301@S2101-09.ap.freescale.net>
References: <1359956789-17918-1-git-send-email-shawn.guo@linaro.org>
 <8795375.qIWYRXDKue@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:50993
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996Ab3BDNNO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 08:13:14 -0500
Content-Disposition: inline
In-Reply-To: <8795375.qIWYRXDKue@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 04, 2013 at 01:19:25PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 04, 2013 01:46:29 PM Shawn Guo wrote:
> > Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> > hardware specific frequency and voltage scaling requirements.
> > 
> > The driver supports module build and is instantiated by the platform
> > device/driver mechanism, so that it will not be instantiated on other
> > platforms, as IMX is built with multiplatform support.
> 
> Am I supposed to take it this time? :-)

Yes, finally :)

Shawn

