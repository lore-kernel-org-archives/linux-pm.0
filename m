From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv5 5/5] thermal: rcar_gen3_thermal: Add delay in
 .thermal_init on r8a7795
Date: Tue, 13 Dec 2016 10:15:42 +0100
Message-ID: <20161213091542.GA24175@bigcity.dyn.berto.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-6-niklas.soderlund@ragnatech.se>
 <20161213033125.GA11329@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213033125.GA11329@localhost.localdomain>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On 2016-12-12 19:31:26 -0800, Eduardo Valentin wrote:
> On Mon, Dec 12, 2016 at 03:18:05PM +0100, Niklas Söderlund wrote:
> > From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > 
> > The .thermal_init needs to be delayed a short amount of time after
> > setting REG_GEN3_CTSR to allow for the TEMP register to contain
> > something useful. If it's not delayed theses warnings are common during
> > boot:
> > 
> > thermal thermal_zone0: failed to read out thermal zone (-5)
> > thermal thermal_zone1: failed to read out thermal zone (-5)
> > thermal thermal_zone2: failed to read out thermal zone (-5)
> > 
> > The warnings are triggered by the first call to .get_temp while the TEMP
> > register contains 0 and rcar_gen3_thermal_get_temp() returns -EIO since
> > a TEMP value of 0 will result in a temperature reading which is out of
> > specifications.
> 
> I think this one can be folded on patch 2/5.

OK, will do this in next version.

-- 
Regards,
Niklas Söderlund
