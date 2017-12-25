From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [regression] Re: Thinkpad T40p: suspend to ram stopped working
 sometime before 4.14
Date: Mon, 25 Dec 2017 11:05:14 +0100
Message-ID: <20171225100514.GB246@x4>
References: <20171224114921.GA9891@amd>
 <58258946.1WsWlzHmoT@aspire.rjw.lan>
 <20171224152232.GA30077@amd>
 <20171224153624.GA22377@amd>
 <20171224181740.GA26326@amd>
 <20171224223739.GA24747@amd>
 <20171225084748.GA246@x4>
 <20171225095423.GA7858@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:49974 "EHLO
        mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdLYKFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Dec 2017 05:05:18 -0500
Content-Disposition: inline
In-Reply-To: <20171225095423.GA7858@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, gregkh@linuxfoundation.org, kyle@kernel.org, akpm@linux-foundation.org, mmarek@suse.com, yamada.masahiro@socionext.com, dwmw2@infradead.org, torvalds@linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-pm@vger.kernel.org

On 2017.12.25 at 10:54 +0100, Pavel Machek wrote:
> On Mon 2017-12-25 09:47:48, Markus Trippelsdorf wrote:
> > On 2017.12.24 at 23:37 +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > > > 4.15-rcX is broken, but that had other problems so lets not go there.
> > > > > > > > 
> > > > > > > > 4.14 is broken.
> > > > > > > 
> > > > > > > And what exactly does happen?
> > > > > > 
> > > > > > Suspend looks ok. I believe there's some reaction to power button, but
> > > > > > screen stays blank. I'll re-check that.. I'm in the middle of bisect
> > > > > > now.
> > > > > 
> > > > > Ok, so suspend looks ok. On resume, "moon" LED goes off and power /
> > > > > bluetooth LEDs go on, but screen is black and no response to
> > > > > > > > anything.
> > > > 
> > > > And it seems bad commit is
> > > > 
> > > > commit 5620a0d1aacd554ebebcff373e31107bb1ef7769
> > > > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Date:   Thu Sep 14 14:23:01 2017 -0700
> > > > 
> > > >     firmware: delete in-kernel firmware
> > > > 
> > > > Unfortuantely, it does not revert cleanly.
> > > 
> > > I can't, because there's df85b2d767aad90fd2746f993fcd66dd322768f8 on
> > > top of it, partialy reverting it. Seems like 5620 was causing problems
> > > for other people before.
> > > 
> > > And then there's huge mega-patch called "license cleanup" on top of
> > > that, which changes 11100 files (!) and makes work harder still.
> > > 
> > > Can we go for full revert?
> > 
> > No, it does not make any sense. 
> > Could you please post your config? 
> 
> Well.. neither makes the original commit message any sense :-(.
> 
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE="radeon/R700_rlc.bin iwlwifi-1000-5.ucode"
> CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"

Looks like a pilot error to me. You have a R200 card, but you load R700
firmware. Try:
CONFIG_EXTRA_FIRMWARE="radeon/R200_cp.bin iwlwifi-1000-5.ucode"
instead.

-- 
Markus
