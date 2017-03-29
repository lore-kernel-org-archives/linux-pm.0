From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Wed, 29 Mar 2017 09:38:06 -0700
Message-ID: <20170329163806.GQ8575@atomide.com>
References: <20170323083235.15072-1-hdegoede@redhat.com>
 <CAKvHMgTqyW8MnVLyzR5L3+DjQHZ+04GZtW+MhkNAt7HBrqUhBw@mail.gmail.com>
 <0b3d3f1e-0f86-1090-4812-1a574d9dadb0@redhat.com>
 <CAKvHMgTu_HNKoxX-Ogj33xLOvQwczFMCjcB1h6cLRxOLyvwyBg@mail.gmail.com>
 <5990b469-8c86-428e-428d-d2be77569dd3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42684 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbdC2QiL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 12:38:11 -0400
Content-Disposition: inline
In-Reply-To: <5990b469-8c86-428e-428d-d2be77569dd3@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170329 02:36]:
> Hi,
> 
> On 29-03-17 10:21, Liam Breck wrote:
> > On Wed, Mar 29, 2017 at 12:34 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > > Hi,
> > > 
> > > On 29-03-17 03:12, Liam Breck wrote:
> > > > 
> > > > Sebastian, this patch needs some work, could you drop it from -next
> > > > and look for v4 from Hans?
> > > 
> > > 
> > > Nack.
> > > 
> > > Liam this whole dropping patches from -next business is not how
> > > things are normally done in kernel-land, please stop expecting it.
> > > 
> > > The whole dropping patches all the time thing means people don't have
> > > a stable base to base future patches on which is unworkable.
> > 
> > This was merged 3h after you posted it without acks from Tony or me.
> > So maybe asking for a do-over in this case isn't unreasonable :-)
> > Another of your patches has a replacement pending already. We'd both
> > benefit from a clean history wherever possible. And new-feature
> > patches should really simmer on the list for a little while.
> 
> When I posted my initial series you asked me to rebase it onto
> -next, which I agreed to as that is the normal way to do things.
> 
> All I'm asking of you is to do the same you've asked of me and
> base your patches on top of -next too.
> 
> Dropping patches out of -next is a rare thing and nothing something
> which we should do every other patch. This can all easily be
> fixed up with a follow-up patch without breaking bisectability
> or some-such.

Yeah agreed. Let's not start redoing branches if possible and
instead do incremental changes on top. Mistakes can happen, but
with multiple people patching the same code it's important to
have a branch we can all pull from.

> Actually having a follow-up patch to remove the 5v boost support
> is useful from a history pov as it documents why there is no 5v
> boost support in the extcon handling.

Yeah works for me.

Regards,

Tony
