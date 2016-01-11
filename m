From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH V3] cpufreq: qoriq: Register cooling device based on device tree
Date: Mon, 11 Jan 2016 22:13:06 +0100
Message-ID: <13735438.Yvdu0suV1m@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com> <AM3PR04MB3376CC754973BD535CF3F99EBC90@AM3PR04MB337.eurprd04.prod.outlook.com> <AM3PR04MB530F71205574CA86CADE93191C90@AM3PR04MB530.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:64161 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbcAKVNg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 16:13:36 -0500
In-Reply-To: <AM3PR04MB530F71205574CA86CADE93191C90@AM3PR04MB530.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scott.wood@nxp.com>, Hongtao Jia <hongtao.jia@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Scott Wood <oss@buserror.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Hongtao Jia <hongtao.jia@freescale.com>, "edubezval@gmail.com" <edubezval@gmail.com>

On Monday 11 January 2016 17:34:52 Scott Wood wrote:
> >>
> >> I think you need a 'depends on THERMAL' to prevent the driver from being
> >> built-in when THERMAL=m.
> >>
> >> Arnd
> > 
> > Correct. I need to add following lines to the Kconfig file:
> > depends on !CPU_THERMAL || THERMAL=y
> > 
> > Hi Rafael,
> > Should I send a new patch include this fix or send a fix patch?
> 
> Why THERMAL=y and not just THERMAL, which would allow building this
> driver as a module?

Right, that would be better, and it is what all other drivers do.

For some reason, some drivers depend on !CPU_THERMAL and others
depend on !THERMAL_OF here, and I think the result is the same, but
we are a bit inconsistent here. CPU_THERMAL cannot be set if THERMAL_OF
is disabled, and the header file only uses the 'extern' declaration
if both are set.

	Arnd
