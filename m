From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] Allow twl4030_charger to find phy reliably.
Date: Mon, 2 Mar 2015 22:05:14 +0100
Message-ID: <20150302210514.GL13270@amd>
References: <20150224035809.32252.4180.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224035809.32252.4180.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2015-02-24 15:01:29, NeilBrown wrote:
> The twl4030_charger is physically paired with the twl4030 USB phy,
> so the drivers need to be able to reliably find each other.
> 
> twl4030_charger currently uses usb_get_phy(), which works if there is
> only one phy to choose from, but is not reliable in more complex
> configurations.
> 
> These patches add a new interface to allow a phy to be found given a
> device node, and then use that interface in twl4030_charger so that
> it finds its sibling in the devicetree, and gets the phy associated
> with that.

Apart for dt documentation...

Acked-by: Pavel Machek <pavel@ucw.cz>

> --
> Signature

Smiley

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
