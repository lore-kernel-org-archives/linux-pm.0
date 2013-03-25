From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 17:57:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1303251756000.1372@syhkavp.arg>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org> <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org> <alpine.LFD.2.03.1303251616070.1372@syhkavp.arg>
 <5150C74E.1040903@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:46377 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365Ab3CYV5p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 17:57:45 -0400
Received: by mail-vc0-f181.google.com with SMTP id hv10so5002873vcb.26
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 14:57:45 -0700 (PDT)
In-Reply-To: <5150C74E.1040903@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Mon, 25 Mar 2013, Daniel Lezcano wrote:

> On 03/25/2013 09:28 PM, Nicolas Pitre wrote:
> > On Mon, 25 Mar 2013, Daniel Lezcano wrote:
> > 
> >> In the future, when all the ARM cpuidle driver will be fully
> >> consolidated, that will be easier to identify the common parts across
> >> the different arch and then move them to the generic framework.
> > 
> > Nothing prevents you from doing that consolidation work right in 
> > drivers/cpuidle/.
> 
> I fully agree with you but I think there is a misunderstanding.
> 
> The idea is to consolidate the ARM code in the ARM cpuidle driver which
> is mostly empty. The init/exit functions could falsely lead someone to
> think they could be moved in the generic framework but IMO it is too
> soon because the code consolidation will bring some arch specificity and
> in this case we will going back and forth. I want to avoid that.
> 
> Let me consolidate the ARM driver, cleanup the headers to split the arch
> specific code from the rest and then move this driver to
> drivers/cpuidle. This is just a question of a week.

OK.


Nicolas
