From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 4 Apr 2016 11:44:44 -0700
Message-ID: <20160404184444.GA32131@kroah.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <20160331170635.GH2350@sirena.org.uk>
 <87d1q9anpt.fsf@intel.com>
 <20160401141643.GX2350@sirena.org.uk>
 <877fgd7iqx.fsf@intel.com>
 <20160404160448.GI2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57777 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbcDDSo4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 14:44:56 -0400
Content-Disposition: inline
In-Reply-To: <20160404160448.GI2350@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Apr 04, 2016 at 09:04:48AM -0700, Mark Brown wrote:
> On Mon, Apr 04, 2016 at 01:47:50PM +0300, Felipe Balbi wrote:
> > Mark Brown <broonie@kernel.org> writes:
> 
> > > It does in this new world order.  IIRC on an earlier round of review
> > > there was some code that didn't use a bus but that got complaints that
> > > it was trying to reimplement the bus functionality.
> 
> > fair enough, I'll wait for Greg to have some time to comment on
> > this. Bottomline is that there is *no* real bus. Charger ICs will use
> 
> I've got a feeling Greg is zoning this out by now...

Very true :)

I have a lot of other patches to go through this week, it will be a
while before I get to these...

thanks,

greg k-h
