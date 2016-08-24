From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] thermal: rcar-thermal: enable hwmon when
 thermal_zone
Date: Wed, 24 Aug 2016 16:26:31 +0800
Message-ID: <1472027191.2682.50.camel@intel.com>
References: <874m7mlzto.wl%kuninori.morimoto.gx@renesas.com>
         <871t2qlzr5.wl%kuninori.morimoto.gx@renesas.com>
         <1471606524.2691.59.camel@intel.com> <1472025111.2682.41.camel@intel.com>
         <87shtutwpv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87shtutwpv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "cm-hiep@jinso.co.jp" <cm-hiep@jinso.co.jp>, hucBui <bd-phuc@jinso.co.jp>
List-Id: linux-pm@vger.kernel.org

On 三, 2016-08-24 at 08:17 +0000, Kuninori Morimoto wrote:
> Hi Zhang
> 
> > 
> > > 
> > > > 
> > > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > 
> > > > rcar-thermal is supporting both
> > > > thermal_zone_of_sensor_register()
> > > > and
> > > > thermal_zone_device_register(). But
> > > > thermal_zone_of_sensor_register()
> > > > doesn't enable hwmon as default.
> > > > This patch enables it to keep compatibility
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.
> > > > com>
> > > Queued for 4.9
> > > 
> > the subject should be "thermal:rcar-theraml: enable hwmon when
> > thermal_zone_of_sensor_register is used", right?
> Yes exactly.
> Should I resend v2 patch ?
> 
nop. I've already updated the patch subject.

thanks,
rui
