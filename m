From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Tue, 8 Nov 2016 20:21:04 +0100
Message-ID: <20161108192103.GN1764@wotan.suse.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
 <20161107212250.GH1764@wotan.suse.de>
 <20161108064541.GA13024@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753178AbcKHTVI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Nov 2016 14:21:08 -0500
Content-Disposition: inline
In-Reply-To: <20161108064541.GA13024@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Andrzej Hajda <a.hajda@samsung.com>

On Tue, Nov 08, 2016 at 07:45:41AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 07, 2016 at 10:22:50PM +0100, Luis R. Rodriguez wrote:
> > We have no explicit semantics to check if a driver / subsystem
> > supports deferred probe.
> 
> Why would we need such a thing?

It depends on the impact of a driver/subsystem not properly supporting
deffered probe, if this is no-op then such a need is not critical but
would be good to proactively inform developers / users so they avoid 
its use, if this will cause issues its perhaps best to make this a
no-op through a check. AFAICT reviewing implications of not supporting
deferred probe on drivers/subsytsems for this framework is not clearly
spelled out, if we start considering re-using this framework for probe
ordering I'd hate to see issues come up without this corner case being
concretely considered.

Furthermore -- how does this framework compare to Andrzej's resource tracking
solution? I confess I have not had a chance yet to review yet but in light of
this question it would be good to know if Andrzej's framework also requires
deferred probe as similar concerns would exist there as well.

  Luis
