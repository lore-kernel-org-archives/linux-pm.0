From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 3/4] PCI: Avoid unnecessary resume after direct-complete
Date: Sun, 18 Sep 2016 14:43:03 +0200
Message-ID: <20160918124303.GC2169@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de>
 <2963851.chF2hIakqz@vostro.rjw.lan>
 <20160914095640.GB1597@wunner.de>
 <1922917.c92rJWRLH6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:40517 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbcIRMml (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Sep 2016 08:42:41 -0400
Content-Disposition: inline
In-Reply-To: <1922917.c92rJWRLH6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>

On Wed, Sep 14, 2016 at 03:14:37PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 14, 2016 11:56:40 AM Lukas Wunner wrote:
> > I first tried to solve this only for Thunderbolt by opting out of the
> > mandatory resume after direct_complete.  It worked, but it was ugly.
> > 
> > (I have to clear the direct_complete flag in the ->complete hook, but
> > the device tree is walked bottom-up during ->complete, and since the
> > Thunderbolt controller exposes multiple devices, I have to clear the
> > flag for all devices from the bottom-most device, which is the NHI.
> > And all the rest of the s/r code lives on the top-most device, which
> > is the upstream bridge.)
> > 
> > You suggested in your e-mail of July 18: "maybe it's better to change
> > the PCI bus type to do something different from calling the generic
> > function?"
> > 
> > So there, I did what you suggested and tried to fix it not just for
> > Thunderbolt but for everyone.
> > 
> > And you're still not happy.
> > 
> > *sigh*
> 
> Sorry for disappointing you.
> 
> I have concerns, so I talk about them.  Is that wrong?  If so, what's wrong
> about it?
> 
> My time goes into that as well, mind you.

Sorry, never mind, just a bout of desperation that I failed to control.

Kind regards,

Lukas
