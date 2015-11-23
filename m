From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: bq27xxx_battery: Reorganize I2C into a module
Date: Mon, 23 Nov 2015 20:26:04 +0100
Message-ID: <6108951.tAkyXlqtjc@wuerfel>
References: <1448297631-8916-1-git-send-email-afd@ti.com> <3809374.hKy9fQ2ldj@wuerfel> <5653485E.70005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5653485E.70005@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Dannenberg <dannenberg@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 23 November 2015 11:09:50 Andrew F. Davis wrote:
> On 11/23/2015 10:57 AM, Arnd Bergmann wrote:
> > On Monday 23 November 2015 10:53:51 Andrew F. Davis wrote:
> >> Separate out I2C functionality into a module. This fixes several small
> >> issues and simplifies the driver initialization.
> >>
> >> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >
> > That looks good to me overall, it should help with the randconfig
> > warnings I've been seeing and makes the driver structured more logically.
> >
> > The one part I wonder about is whether the platform_driver portion
> > should also be split out into a separate module in the same way.
> >
> I think it should, I'm just waiting until I can find some time to
> bring up regmap for 1wire, then I can really clean things up and
> move the platform stuff (which is really the 1wire interface) out
> more cleanly, all I'll need to do then is just pass a regmap handle
> to the core from the interface modules.
> 
> But that's all a project for another day 

Ok, sounds good.

	Arnd
