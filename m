From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Tue, 11 Aug 2015 05:53:42 +0530
Message-ID: <20150811002342.GD5766@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150810192336.GC9678@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 10-08-15, 12:23, Stephen Boyd wrote:
> On 08/10, Viresh Kumar wrote:
> > 'dev_opp' will always be NULL in _of_init_opp_table_v2() after creating
> > OPPs for a device. There is no point comparing it against NULL there.
> > 
> > Restructure code a bit to make it more efficient.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Curious if these are a response to the static checker mails? If
> so it would be good to add a reported-by tag.

No it wasn't, I had these waiting in my queue even before Rafael
applied the earlier ones. I was waiting for them to get in before
sending more stuff :)

> > ---
> >  drivers/base/power/opp.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> > index 1daaa1a418a2..c9747fb192b1 100644
> > --- a/drivers/base/power/opp.c
> > +++ b/drivers/base/power/opp.c
> > @@ -1295,20 +1295,19 @@ static int _of_init_opp_table_v2(struct device *dev,
> >  	if (WARN_ON(!count))
> >  		goto out;
> >  
> > -	if (!ret) {
> > -		if (!dev_opp) {
> > -			dev_opp = _find_device_opp(dev);
> > -			if (WARN_ON(!dev_opp))
> > -				goto out;
> > -		}
> > -
> > -		dev_opp->np = opp_np;
> > -		dev_opp->shared_opp = of_property_read_bool(opp_np,
> > -							    "opp-shared");
> > -	} else {
> > +	if (ret) {
> >  		of_free_opp_table(dev);
> > +		goto out;
> >  	}
> >  
> > +	dev_opp = _find_device_opp(dev);
> > +	if (WARN_ON(!dev_opp))
> > +		goto out;
> 
> Doesn't ret = 0 in this case?

Because ret is already 0, juse see the above if (ret) check.

> Why not drop the goto and just
> return some error code. Same for the goto out up above.

Actually yes, because we don't do anything special in goto now. But it
required more (unrelated) code changes, plus I didn't wanted to break
the 'return from single place' rule for this function, in case we
really need to free some resource or undo some work from the goto
place.

But if you suggest/insist, then I will do it in a separate patch.

-- 
viresh
