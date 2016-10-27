From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH] [media] smiapp: make PM functions as __maybe_unused
Date: Thu, 27 Oct 2016 11:08:34 +0300
Message-ID: <20161027080834.GU9460@valkosipuli.retiisi.org.uk>
References: <20161026203814.1904690-1-arnd@arndb.de>
 <20161027072818.GQ9460@valkosipuli.retiisi.org.uk>
 <3736433.WSCIHGPKQU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3736433.WSCIHGPKQU@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Arnd,

On Thu, Oct 27, 2016 at 09:43:16AM +0200, Arnd Bergmann wrote:
> On Thursday, October 27, 2016 10:28:18 AM CEST Sakari Ailus wrote:
> > 
> > On Wed, Oct 26, 2016 at 10:38:01PM +0200, Arnd Bergmann wrote:
> > > The rework of the PM support has caused two functions to
> > > be orphaned when CONFIG_PM is disabled:
> > > 
> > > media/i2c/smiapp/smiapp-core.c:1352:12: error: 'smiapp_power_off' defined but not used [-Werror=unused-function]
> > > media/i2c/smiapp/smiapp-core.c:1206:12: error: 'smiapp_power_on' defined but not used [-Werror=unused-function]
> > > 
> > > This changes all four PM entry points to __maybe_unused and
> > > removes the #ifdef markers for consistency. This avoids the
> > > warnings even when something changes again.
> > > 
> > > Fixes: cbba45d43631 ("[media] smiapp: Use runtime PM")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > The power-on sequence is in fact mandatory as it involves writing the
> > initial configuration to the sensor as well.
> > 
> > Instead, I believe the correct fix is to make the driver depend on
> > CONFIG_PM.
> 
> (adding linux-pm list)
> 
> That would be a rather unusual dependency, though it's possible that
> a lot of drivers in fact need it but never listed this explictly in
> Kconfig.
> 
> What do other drivers do that need to have their runtime_resume
> function called at probe time when CONFIG_PM is disabled?

That's certainly possible as well.

V4L2 sub-device core operation s_power() no longer works (as it now uses
runtime PM) but I don't think that's an issue if PM is disabled anyway ---
we should really get rid of that in most drivers.

I can submit a patch.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
