From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Fri, 23 May 2014 09:14:39 -0700
Message-ID: <00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl>
References: <20140521073457.GD31687@pengutronix.de>
 <e9090453-ce40-4662-a3ea-fbdaffdb2aa4@BN1AFFO11FD046.protection.gbl>
 <20140521182308.GN31687@pengutronix.de> <20140521203300.9521.67546@quantum>
 <ac335a38-b0f4-4d95-b111-56c05e1a6234@BN1BFFO11FD045.protection.gbl>
 <20140522182040.GB20155@pengutronix.de>
 <6612b069-1228-488f-81f7-ea8839f6c468@BN1BFFO11FD029.protection.gbl>
 <20140522210328.9521.34889@quantum>
 <a86642cb-855f-455f-b07c-a52bc6aa426f@BN1BFFO11FD050.protection.gbl>
 <20140523013732.9521.70820@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140523013732.9521.70820@quantum>
Sender: cpufreq-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2014-05-22 at 06:37PM -0700, Mike Turquette wrote:
> Quoting S=C3=B6ren Brinkmann (2014-05-22 16:44:53)
> > On Thu, 2014-05-22 at 02:03PM -0700, Mike Turquette wrote:
> > > Quoting S=C3=B6ren Brinkmann (2014-05-22 13:32:09)
> > > > On Thu, 2014-05-22 at 08:20PM +0200, Uwe Kleine-K=C3=B6nig wrot=
e:
> > > > > Hello S=C3=B6ren,
> > > > >=20
> > > > > On Thu, May 22, 2014 at 11:03:00AM -0700, S=C3=B6ren Brinkman=
n wrote:
> > > > > > On Wed, 2014-05-21 at 01:33PM -0700, Mike Turquette wrote:
> > > > > > > Quoting Uwe Kleine-K=C3=B6nig (2014-05-21 11:23:08)
> > > > > > > > Hello S=C3=B6ren,
> > > > > > > >=20
> > > > > > > > On Wed, May 21, 2014 at 08:58:10AM -0700, S=C3=B6ren Br=
inkmann wrote:
> > > > > > > > > On Wed, 2014-05-21 at 09:34AM +0200, Uwe Kleine-K=C3=B6=
nig wrote:
> > > > > > > > > > On Tue, May 20, 2014 at 02:48:20PM -0700, S=C3=B6re=
n Brinkmann wrote:
> > > > > > > > > > > On Tue, 2014-05-20 at 10:48AM -0700, Stephen Boyd=
 wrote:
> > > > > > > > > > > > On 05/20/14 09:01, S=C3=B6ren Brinkmann wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > >>>>> +{
> > > > > > > > > > > > >>>>> + unsigned long lower, upper, cur, lower_=
last, upper_last;
> > > > > > > > > > > > >>>>> +
> > > > > > > > > > > > >>>>> + lower =3D clk_round_rate(clk, rate);
> > > > > > > > > > > > >>>>> + if (lower >=3D rate)
> > > > > > > > > > > > >>>>> +         return lower;
> > > > > > > > > > > > >>>> Is the >-case worth a warning?
> > > > > > > > > > > > >>> No, it's correct behavior. If you request a=
 rate that is way lower than what the
> > > > > > > > > > > > >>> clock can generate, returning something lar=
ger is perfectly valid, IMHO.
> > > > > > > > > > > > >>> Which reveals one problem in this whole dis=
cussion. The API does not
> > > > > > > > > > > > >>> require clk_round_rate() to round down. It =
is actually an implementation
> > > > > > > > > > > > >>> choice that had been made for clk-divider.
> > > > > > > > > > > > >> I'm sure it's more than an implementation ch=
oice for clk-divider. But I
> > > > > > > > > > > > >> don't find any respective documentation (but=
 I didn't try hard).
> > > > > > > > > > > > > A similar discussion - without final conclusi=
on:
> > > > > > > > > > > > > https://lkml.org/lkml/2010/7/14/260
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >=20
> > > > > > > > > > > > Please call this new API something like clk_fin=
d_nearest_rate() or
> > > > > > > > > > > > something. clk_round_rate() is supposed to retu=
rn the rate that will be
> > > > > > > > > > > > set if you call clk_set_rate() with the same ar=
guments. It's up to the
> > > > > > > > > > > > implementation to decide if that means rounding=
 the rate up or down or
> > > > > > > > > > > > to the nearest value.
> > > > > > > > > > >=20
> > > > > > > > > > > Sounds good to me. Are there any cases of clocks =
that round up? I think
> > > > > > > > > > > that case would not be handled correctly. But I a=
lso don't see a use
> > > > > > > > > > > case for such an implementation.
> > > > > > > > > > I don't really care which semantic (i.e. round up, =
round down or round
> > > > > > > > > > closest) is picked, but I'd vote that all should pi=
ck up the same. I
> > > > > > > > > > think the least surprising definition is to choose =
rounding down and add
> > > > > > > > > > the function that is under discussion here to get a=
 nearest match.
> > > > > > > > > >=20
> > > > > > > > > > So I suggest:
> > > > > > > > > >=20
> > > > > > > > > >     - if round_rate is given a rate that is smaller=
 than the
> > > > > > > > > >       smallest available rate, return 0
> > > > > > > > > >     - add WARN_ONCE to round_rate and set_rate if t=
hey return with a
> > > > > > > > > >       rate bigger than requested
> > > > > > > > >=20
> > > > > > > > > Why do you think 0 is always valid? I think for a clo=
ck that can
> > > > > > > > > generate 40, 70, 120, clk_round_rate(20) should retur=
n 40.
> > > > > > > > I didn't say it's a valid value. It just makes the it p=
ossible to check
> > > > > > > > for clk_round_rate(clk, rate) <=3D rate.
> > > > > > > >=20
> > > > > > > > I grepped a bit around and found da850_round_armrate wh=
ich implements a
> > > > > > > > round_rate callback returning the best match.
> > > > > > > > omap1_clk_round_rate_ckctl_arm can return a value < 0.
> > > > > > > > s3c2412_roundrate_usbsrc can return values that are big=
ger than
> > > > > > > > requested. (I wonder if that is a bug though.)
> > > > > > > >=20
> > > > > > > > > >     - change the return values to unsigned long
> > > > > > > > >=20
> > > > > > > > > Yep, I agree, this should happen.
> > > > > > > > And we're using 0 as error value? e.g. for the case whe=
re
> > > > > > > > omap1_clk_round_rate_ckctl_arm returns -EIO now?
> > > > > > >=20
> > > > > > > No. clk_round_rate returns long for a reason, which is th=
at we can
> > > > > > > provide an error code to the caller. From include/linux/c=
lk.h:
> > > > > > >=20
> > > > > > > /**
> > > > > > >  * clk_round_rate - adjust a rate to the exact rate a clo=
ck can provide
> > > > > > >  * @clk: clock source
> > > > > > >  * @rate: desired clock rate in Hz
> > > > > > >  *
> > > > > > >  * Returns rounded clock rate in Hz, or negative errno.
> > > > > > >  */
> > > > > > >=20
> > > > > > > This has the unfortunate side effect that the max value w=
e can return
> > > > > > > safely is 2147483647 (~2GHz). So another issue here is co=
nverting clock
> > > > > > > rates to 64-bit values.
> > > > > >=20
> > > > > > So, let's assume
> > > > > >  - a clock does either of these
> > > > > >    - round down
> > > > > >    - round nearest
> > > > > >    - round up (is there any such case? I don't see a use-ca=
se for this)
> > > > > >  - or return an error
> > > > > >=20
> > > > > > I think my latest try handles such cases, with the limitati=
on of
> > > > > > for a clock that rounds up, the up-rounded value is found i=
nstead of the
> > > > > > nearest.
> > > > > >=20
> > > > > >=20
> > > > > > static long clk_find_nearest_rate(struct clk *clk, unsigned=
 long rate)
> > > > > > {
> > > > > >     long ret;
> > > > > >     unsigned long lower, upper;
> > > > > >=20
> > > > > >     clk_prepare_lock();
> > > > > >=20
> > > > > >     lower =3D __clk_round_rate(clk, rate);
> > > > > this is CCF specific while I don't see a need for it. (But ye=
s, a
> > > > > lock-less clk_find_nearest_rate is of course racy.)
> > > > Do we have to support non-CCF implementations? Isn't switching =
to the
> > > > CCF encouraged?
> > >=20
> > > No we don't. If you check out the ifdeffery in include/linux/clk.=
h
> > > you'll see more function declarations for CONFIG_COMMON_CLK then =
for
> > > !CONFIG_COMMON_CLK, so we're not breaking any ground here.
> > >=20
> > > >=20
> > > > >=20
> > > > > >     if (lower >=3D rate || (long)lower < 0) {
> > > > > If you made lower and upper a signed long, you could drop the=
 casting
> > > > > here. BTW, why does __clk_round_rate return an unsigned long?=
?
> > > > > There seem to be several more type mismatches in that area.
> > > > > Maybe we should add a waring if rate is > LONG_MAX?
> > > > >=20
> > > > > (And ISTR that the C standard doesn't specify what the result=
 of
> > > > > (long)lower is given that lower is of type unsigned long and =
holding a
> > > > > value > LONG_MAX.)
> > > > Looks like you're right. This probably needs some polishing to =
get types
> > > > sorted out.
> > > > Mike/Russel: As Uwe pointed out, shouldn't __clk_round_rate ret=
urn a
> > > > long as well?
> >=20
> > Sorry, Russell, of course.
> >=20
> > >=20
> > > Yeah. The strange thing is that .round_rate and .determine_rate b=
oth
> > > return long. I think I was asleep at the wheel on this one.
> > >=20
> > > I count about a dozen call sites that need to be fixed up for thi=
s
> > > change to happen. As we approach 3.15-rc6 I'm a bit nervous about
> > > introducing this change. How do you feel about dropping this chan=
ge in
> > > first thing after 3.16-rc1 and layering in your new clk_find_*_ra=
te
> > > stuff on top of it?
> > >=20
> > > I'll take a stab at fixing up __clk_round_rate early next week.
> >=20
> > Yeah, at some point this 'fix cpufreq stats'-series grew a little o=
ut of
> > control. Targeting the 3.16 cycle sounds reasonable. Then we could =
probably
> > also look at moving from (unsigned) long to some 64-bit type as wel=
l ;)
>=20
> Agreed on the 64-bit thing.

Viresh: Could you imagine something similar for cpufreq? You suggested
migrating to Hz resolution. I guess that would ideally mean to follow
the CCF to a 64-bit type for frequencies and increasing the resolution.
I have a messy patch migrating cpufreq and OPP to Hz and unsigned long
that works on Zynq. But cpufreq has so many users that it would become
quite an undertaking.
And we'd need some new/amended OPP DT binding.

	Thanks,
	S=C3=B6ren

