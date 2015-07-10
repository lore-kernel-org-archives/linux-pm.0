From: Guenter <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 10:01:19 -0700
Message-ID: <20150710170119.GA6585@groeck-UX31A>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150709173747.GA32448@roeck-us.net>
 <559F2719.3060708@atmel.com>
 <20150710031438.GA27089@roeck-us.net>
 <20150710055658.GZ3127@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33951 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427AbbGJRBX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 13:01:23 -0400
Content-Disposition: inline
In-Reply-To: <20150710055658.GZ3127@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Josh Wu <josh.wu@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

On Fri, Jul 10, 2015 at 07:56:58AM +0200, Alexandre Belloni wrote:
> Hi Guenter,
> 
> On 09/07/2015 at 20:14:38 -0700, Guenter Roeck wrote :
> > > This patch introduces a new compatible string: "atmel,sama5d3-rstc" for the
> > > reset driver of sama5d3 and later chips.
> > > As in sama5d3 or later chips, we don't have to shutdown the DDR controller
> > > before reset. Shutdown the DDR controller before reset is a workaround to
> > > avoid DDR signal driving the bus, but since sama5d3 and later chips there is
> > > no such a conflict.
> > > That means:
> > >   1. the sama5d3 reset function only need to write the rstc register and
> > > return.
> > >   2. for sama5d3, we can remove the code related with DDR controller as we
> > > don't use it at all.
> > > 
> > Sorry, I don't get it. Doesn't that mean there are two distinct logical
> > changes, which would ask for two separate patches ?
> 
> I would agree with Josh and I think that only one patch is needed. There
> is only one change, the removal of the workaround for sama5d3 and later.
> 
> As the workaround is using a table of compatibles to remap the ram
> controller and the one for sama5d3 is not used because it is not needed,
> I think it makes sense to remove it in that same patch. The logical
> change here is the removal of the workaround.
> 
Ok, makes sense.

Thanks,
Guenter
