From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Wed, 9 Nov 2016 07:45:01 +0100
Message-ID: <20161109064501.GA5252@kroah.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
 <20161107212250.GH1764@wotan.suse.de>
 <20161108064541.GA13024@kroah.com>
 <20161108192103.GN1764@wotan.suse.de>
 <20161108194335.GA22680@kroah.com>
 <20161108205824.GA13978@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcKIGox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 01:44:53 -0500
Content-Disposition: inline
In-Reply-To: <20161108205824.GA13978@wotan.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrzej Hajda <a.hajda@samsung.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Nov 08, 2016 at 09:58:24PM +0100, Luis R. Rodriguez wrote:
> > > Furthermore -- how does this framework compare to Andrzej's resource tracking
> > > solution? I confess I have not had a chance yet to review yet but in light of
> > > this question it would be good to know if Andrzej's framework also requires
> > > deferred probe as similar concerns would exist there as well.
> > 
> > I have no idea what "framework" you are talking about here, do you have
> > a pointer to patches?
> 
> I'm surprised given Andrzej did both Cc you on his patches [2] *and* chimed
> in on Rafael's patches to indicate that we likely can integrate PM concerns
> into his own "framework" [3]. There was no resolution to this discussion, however
> its not IMHO sufficient to brush off Andrzej's points in particular because
> Andrzej *is* indicating that his framework:

Dude, those patches were from 2014!  I can't remember patches people
sent to me a month ago...

> - Eliminates deferred probe and resulting late_initcall(), consumer registers
> callbacks informing when given resources (clock, regulator, etc) becomes
> available
> - Properly handle resource disappearance (driver unbind, hotplug)
> - Track resources which are not vital to the device, but can influence behavior
> - Offers simplified resource allocation
> - Can be easily expanded to help with power management
> 
> Granted I have not reviewed this yet but it at least was on my radar, and
> I do believe its worth reviewing this further given the generally expressed
> interest to see if we can have a common framework to address both ordering
> problems, suspend and probe. At a quick glance the "ghost provider" idea
> seems like a rather crazy idea but hey, there may be some goods in there.

>From what I remember, and I could be totally wrong, these patches were
way too complex and required that every subsystem change their
interfaces.  That's not going to work out well, but read the email
threads for the details...

> It was sad both Andrzej and yourself could not attend the complex dependencies
> tracks -- I think it would have been useful.

Sometimes real-life gets in the way of work, sorry :(

> I don't expect us to address a
> resolution to probe ordering immediately -- but I am in the hopes we at least
> can keep an open mind about the similarity of the problems and see if we can
> aim for a clean elegant solution that might help both.

I'll always review patches of what people come up with.

thanks,

greg k-h
