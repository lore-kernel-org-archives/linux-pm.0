From: Tony Lindgren <tony@atomide.com>
Subject: Re: Moving forward with the patches for using the bq24190 on x86
 systems
Date: Mon, 3 Apr 2017 17:56:46 -0700
Message-ID: <20170404005646.GX8575@atomide.com>
References: <527947b5-948b-1aab-233f-c421bdf317e2@redhat.com>
 <CAKvHMgR+mvxSRYH69oAyGGL2ppZxO=s1CtUw_N2Cy-tZe-nAUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:43130 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdDDA4u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 20:56:50 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgR+mvxSRYH69oAyGGL2ppZxO=s1CtUw_N2Cy-tZe-nAUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, linux-pm@vger.kernel.org

Hi,

* Liam Breck <liam@networkimprov.net> [170403 14:59]:
> On Mon, Apr 3, 2017 at 12:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > 1) The "power: supply: bq24190_charger: Never reset the charger chip" patch.
> >
> > Sebastian you said you would merge this after letting it sit a bit longer
> > on the list, unless any problems with it were noticed. I believe Liam
> > would prefer for this to not get merged as-is. So I see 3 options:
> >
> > a) Merge as-is (AFAIK no problems with it have been noticed)
> > b) Add a "no-reset-on-probe" boolean device property which will
> > make the driver not do a reset on probe (nor on resume)
> > c) Add a "reset-on-probe" boolean device property and make the
> > driver only do a reset on probe (and on resume) if this is set
> >
> > Sebastian, can you please pick one of these 3 options ? Then I
> > will adjust my patch as necessary and post a new version.
> 
> I've solicited Tony's input on this. He's studied the charger/driver a
> lot, and is a guru-level kernel contributor.

Hehehehe I think we're all just-trying-to-make-it-work kernel
contributors on this driver :)

My guess is that the reset is left over from missing handling of
clearing of the EN_HIZ on errors. I recall that EN_HIZ error can
happen when plugging the cable a little bit sideways to a USB hub
with loose tolerance USB connectors.

So it should be safe to limit the reset to only happen if something
like "reset-on-probe" is specified. Not sure we want to remove it
completely, maybe just add notes that reset may misbehave in
some conditions.

On the other issues I bet you guys know more than I do so no
comments from me.

Regards,

Tony
