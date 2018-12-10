From: Nick Fan <nick.fan@mediatek.com>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Date: Mon, 10 Dec 2018 20:36:12 +0800
Message-ID: <1544445372.3502.42.camel@mtksdaap41>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
         <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-12-04 at 13:51 +0530, Viresh Kumar wrote:
> On 04-12-18, 14:59, Nick Fan wrote:
> > Add API to get voltage for multiple supplies from opp table
> 
> And who needs to use this new API ? It would be better to add the user in the
> same series to make sure this really gets used.

This new API would be required when handling multiple regulators.
You can check the example 4 in
Documentation/devicetree/bindings/opp/opp.txt for multiple regulators.

When we specify multiple regulator voltages in device tree, we are not
able to access the secondary supply voltages.
Because the dev_pm_opp_get_voltage only returns the first supply
voltages, this new API is required to get the specific supply.

> 
> > Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> > ---
> >  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  3 +++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 2c2df4e..ee73546 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
> >  
> >  /**
> > + * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
> > + * with index
> > + * @opp:        opp for which voltage has to be returned for
> > + * @index:      index to specify the returned supplies
> > + *
> > + * Return: voltage in micro volt corresponding to the opp with index, else
> > + * return 0
> > + *
> > + * This is useful for devices with multiple power supplies.
> > + */
> > +unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
> > +					    unsigned int index)
> 
> How will the users of this API get the index ?

For the users who only use one supply, they can use
dev_pm_opp_get_voltage to get the voltage data from an opp.
But if the users who use more than one supply, they will need this API
to get their voltage data from OPP.
The users should know about the supply count while creating opp table by
using dev_pm_opp_set_regulators function.
By using this API, the users can get the voltages by using index to
specify which supplies they want.

The following is a simple example to get multiple regulators by this
API.
for (i = 0; i < regulator_num; i++)
	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);
> 
> > +{
> > +	if (IS_ERR_OR_NULL(opp)) {
> > +		pr_err("%s: Invalid parameters\n", __func__);
> > +		return 0;
> > +	}
> > +
> > +	if (index >= opp->opp_table->regulator_count) {
> > +		pr_err("%s: Invalid supply index: %u\n", __func__, index);
> > +		return 0;
> > +	}
> > +
> > +	return opp->supplies[index].u_volt;
> 
Nick Fan
