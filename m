From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Mon, 12 Dec 2016 19:22:42 -0800
Message-ID: <20161213032236.GB9668@localhost.localdomain>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
 <20161201220442.22057-3-wsa+renesas@sang-engineering.com>
 <20161207010119.GB12562@localhost.localdomain>
 <20161207090627.GB1724@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161207090627.GB1724@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 07, 2016 at 10:06:27AM +0100, Wolfram Sang wrote:
> 
> > Would you please check the following from checkpatch too?
> 
> I saw them and chose to ignore them. I am not strict with those warnings
> within the i2c subsystem as well. I can change the series if your mileage
> varies, of course.

at least those that make sense.

> 
> > WARNING: please write a paragraph that describes the config symbol fully
> > #82: FILE: drivers/thermal/Kconfig:248:
> > +config RCAR_GEN3_THERMAL
> 
> I can make up something.

cool

> 
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> Is this mandatory?

not really.

> 
> > CHECK: struct mutex definition without comment
> > #186: FILE: drivers/thermal/rcar_gen3_thermal.c:75:
> > +	struct mutex lock;
> 
> Can change, but if there is only one lock, I don't really see much
> benefit from this check.
> 

still good to explicitly write it down to prevent future changes to
abuse the lock.

> > WARNING: line over 80 characters
> > #204: FILE: drivers/thermal/rcar_gen3_thermal.c:93:
> > +static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc, u32 reg)
> > 
> > CHECK: Alignment should match open parenthesis
> > #210: FILE: drivers/thermal/rcar_gen3_thermal.c:99:
> > +static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> > +				     u32 reg, u32 data)
> 
> I have those warnings (80 chars and open parens) ignored by default but
> if you think it makes the code more readable, I'll change it.
> 

I typically ask to keep checkpatch as clean as possible. The above can
easily be avoided by returning right after static inline.

> > > +static void _linear_coefficient_calculation(struct rcar_gen3_thermal_tsc *tsc,
> > > +					    int *ptat, int *thcode)
> > > +{
> > > +	int tj_2;
> > > +	s64 a1, b1;
> > > +	s64 a2, b2;
> > > +	s64 a1_num, a1_den;
> > > +	s64 a2_num, a2_den;
> > > +
> > > +	tj_2 = (CODETSD((ptat[1] - ptat[2]) * 137)
> > > +		/ (ptat[0] - ptat[2])) - CODETSD(41);
> > > +
> > > +	/* calculate coefficients for linear equation */
> > > +	a1_num = CODETSD(thcode[1] - thcode[2]);
> > > +	a1_den = tj_2 - TJ_3;
> > > +	a1 = (10000 * a1_num) / a1_den;
> > > +	b1 = (10000 * thcode[2]) - ((a1 * TJ_3) / 1000);
> > > +
> > > +	a2_num = CODETSD(thcode[1] - thcode[0]);
> > > +	a2_den = tj_2 - TJ_1;
> > > +	a2 = (10000 * a2_num) / a2_den;
> > > +	b2 = (10000 * thcode[0]) - ((a2 * TJ_1) / 1000);
> > > +
> > > +	tsc->coef.a1 = DIV_ROUND_CLOSEST(a1, 10);
> > > +	tsc->coef.b1 = DIV_ROUND_CLOSEST(b1, 10);
> > > +	tsc->coef.a2 = DIV_ROUND_CLOSEST(a2, 10);
> > > +	tsc->coef.b2 = DIV_ROUND_CLOSEST(b2, 10);
> > 
> > What is a a1, b1, a2, b2 typical values?
> > 
> > are you sure they do not fit into int? Looks like you start from pretty small values,
> > but multiply by 10^3 on num and den to get better precision?
> 
> Typical values are a few thousand. a1_num uses CODETSD which multiplies
> by 1000 and makes it a million. a1 then multiplies again by 10000 which
> makes it 10 billion. No int.
> 
> I am quite sure the formulas can be rearranged to fit into an int. As
> mentioned before, I hoped we could start with the already tested
> formulas since documentation on them is sparse.
> 
> > > +static int _linear_temp_converter(struct equation_coefs *coef,
> > > +					int temp_code)
> > > +{
> > > +	int temp, temp1, temp2;
> > > +
> > > +	temp1 = MCELSIUS((CODETSD(temp_code) - coef->b1)) / coef->a1;
> > > +	temp2 = MCELSIUS((CODETSD(temp_code) - coef->b2)) / coef->a2;
> > 
> > aren't we overflowing the result of this 64 bit math assigned into an int?
> 
> The division ensures that we get an int. Hmmm, not very pretty, I agree.
> 
> Sigh, maybe it is better to refactor the formulas before submitting
> upstream :/
> 

cool,  I am checking on the next version.

> Regards,
> 
>    Wolfram
> 


BR,

Eduardo Valentin
