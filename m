From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH][RESEND] thermal: hwmon: EXPORT_SYMBOL_GPL for thermal
 hwmon sysfs
Date: Wed, 10 Aug 2016 15:40:56 +0800
Message-ID: <1470814856.2316.9.camel@intel.com>
References: <874m7mlzto.wl%kuninori.morimoto.gx@renesas.com>
	 <87a8gu8vqf.wl%kuninori.morimoto.gx@renesas.com>
	 <8760r9idot.wl%kuninori.morimoto.gx@renesas.com>
	 <744357E9AAD1214791ACBA4B0B9092633AAA3F54@SHSMSX101.ccr.corp.intel.com>
	 <87r39xgx22.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r39xgx22.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "cm-hiep@jinso.co.jp" <cm-hiep@jinso.co.jp>, PhucBui <bd-phuc@jinso.co.jp>
List-Id: linux-pm@vger.kernel.org

On 三, 2016-08-10 at 02:54 +0000, Kuninori Morimoto wrote:
> Hi Zhang
> 
> > 
> > > 
> > > Hi Linux-PM, Linux-Kernel ML
> > > 
> > > I posted thermal driver patch 2month ago, but no response and
> > > nothing
> > > happen.
> > > I'm following scripts/get_maintainer.pl, but am I wrong ??
> > > Who is the maintainer of these patches ??
> > > 
> > The patch is queued for 4.8-rc2.
> > As you can see at https://git.kernel.org/cgit/linux/kernel/git/rzha
> > ng/linux.git/log/?h=next
> Oh, thanks
> But, I think it doesn't include [1/2] patch, is it rejected ?
> 
Usually, soc thermal driver changes should go to Eduardo' tree first.
I can also take soc thermal driver changes only if they've got ACK from
either Eduardo or the driver Author.
In your case, I can take patch 1/2, but let's see what Eduardo says
first.

thanks,
rui
> 			
> > 
> > > 
> > > > 
> > > > > 
> > > > > Kuninori Morimoto (2):
> > > > >       thermal: rcar-thermal: enable hwmon when thermal_zone
> > > > >       thermal: hwmon: EXPORT_SYMBOL_GPL for thermal hwmon
> > > > > sysfs
> 
> Best regards
> ---
> Kuninori Morimoto
