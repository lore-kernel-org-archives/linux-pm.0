From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v3 05/11] thermal: armada: Add support for Armada AP806
Date: Mon, 18 Dec 2017 13:11:56 +0200
Message-ID: <20171218111156.76a66q5kwh3advs7@sapphire.tkos.co.il>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-6-miquel.raynal@free-electrons.com>
 <87y3m5o9h4.fsf@free-electrons.com>
 <20171218104127.65017555@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:58102 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757030AbdLRLME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Dec 2017 06:12:04 -0500
Content-Disposition: inline
In-Reply-To: <20171218104127.65017555@xps13>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, linux-arm-kernel@lists.infradead.org

Hi Miquèl,

On Mon, Dec 18, 2017 at 10:41:27AM +0100, Miquel RAYNAL wrote:
> Hello Gregory & Baruch,
> 
> On Thu, 14 Dec 2017 12:05:43 +0100
> Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
> > > @@ -184,9 +214,9 @@ static int armada_get_temp(struct
> > > thermal_zone_device *thermal, div = priv->data->coef_div;
> > >  
> > >  	if (priv->data->inverted)
> > > -		*temp = ((m * reg) - b) / div;
> > > +		*temp = ((m * sample) - b) / div;
> > >  	else
> > > -		*temp = (b - (m * reg)) / div;
> > > +		*temp = (b - (m * sample)) / div;
> > >  	return 0;
> > >  }
> > >  
> > > @@ -237,6 +267,19 @@ static const struct armada_thermal_data
> > > armada380_data = { .inverted = true,
> > >  };
> > >  
> > > +static const struct armada_thermal_data armada_ap806_data = {
> > > +	.is_valid = armada_is_valid,
> > > +	.init_sensor = armada_ap806_init_sensor,
> > > +	.is_valid_bit = BIT(16),
> > > +	.temp_shift = 0,
> > > +	.temp_mask = 0x3ff,
> > > +	.coef_b = -150000,  
> > 
> > Don't you expect any side effect by storing a negative value in a
> > unsigned variable?
> 
> That is a fair question, I did not spot that.
> 
> As other values are really close to 2^32 I don't know what is the best
> option for us in this case. Should I:
> - don't care?
> - use signed values? (dangerous IMHO)
> - use a union with a signed and an unsigned value? (problem moved to
>   ->get_temp())

Another option is to use s64 type.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
