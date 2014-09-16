From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: document Rockchip thermal
Date: Tue, 16 Sep 2014 15:45:22 +0800
Message-ID: <1410853522.1280.0.camel@rzhang1-toshiba>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
	 <1410403012.25559.69.camel@rzhang1-toshiba>
	 <20140911121842.GB26715@developer> <40514790.Xc34lyFLGa@wuerfel>
	 <20140911155324.GA27076@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140911155324.GA27076@developer>
Sender: linux-doc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Caesar Wang <caesar.wang@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, dtor <dtor@chromium.org>, Chris Zhong <zyw@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org


On Thu, 2014-09-11 at 11:53 -0400, Eduardo Valentin wrote:
> Arnd,
> 
> On Thu, Sep 11, 2014 at 02:32:08PM +0200, Arnd Bergmann wrote:
> > On Thursday 11 September 2014 08:18:43 Eduardo Valentin wrote:
> > > > As what we want is to make thermal driver have a chance to configure the
> > > > hardware shutdown registers, I'm thinking if we can do this without
> > > > representing the hardware shutdown value as a trip point.
> > > > Say,
> > > > 1. parse DT, and get the hardware shutdown temperature value, and store
> > > > it somewhere, e.g. struct __thermal_zone.
> > > > 2. introduce a new parameter, int (*set_hardware_trip)(void *, long *),
> > > > in thermal_zone_of_sensor_register().
> > > > 3. invoke set_hard_trip(tz, hardware_shutdown_temperature_value) in
> > > > thermal_zone_of_sensor_register().
> > > 
> > > The only issue I have with the above proposal is that not all platforms
> > > use DT. Some still boot with boardfiles, for instance. Thus, the
> > > parameter to configure hardware thermal shutdown needs to be common on
> > > thermal core, not specific to of-thermal. Do you agree?
> > 
> > Do you know of a machine that can't yet be converted to DT and that
> > needs this driver? In case of rockchips that is certainly not the
> > case, and we don't care about anybody trying to use board files out
> > of tree, they can just hack the thermal support as well.
> 
> I see. Again, the only concern I have is to produce thermal framework APIs
> that would be only in the of-thermal. My point is not specific to this
> patch, or this platform, but with a detail in the above proposal. 
> 
> While I agree to have a trip specific to configurable hardware triggered
> thermal shutdown, I just don't see why it needs to be a feature
> implemented only via of-thermal. It has to be properly defined in
> thermal core.
> 
> The proposal of of-thermal is not to become a separate/competing thermal
> framework.
> 
Agreed.
And I think we can have such feature in thermal core.
But again I don't think we should represent it as an trip point.
Instead, we can have a separate parameter for

thanks,
rui
> > 
> > 	Arnd
> 
> Cheers,
> 
> Eduardo



