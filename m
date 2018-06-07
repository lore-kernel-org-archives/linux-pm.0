From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Date: Wed, 6 Jun 2018 18:09:57 -0700
Message-ID: <20180607010955.GA209574@rodete-desktop-imager.corp.google.com>
References: <20180602012900.181352-1-briannorris@chromium.org>
 <7cbe27cf-2917-a17b-07bf-e5fdeb5fef15@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7cbe27cf-2917-a17b-07bf-e5fdeb5fef15@electromag.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>, Alexandru Stan <amstan@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Doug Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi Phil,

On Wed, Jun 06, 2018 at 10:03:59AM +0800, Phil Reid wrote:
> On 2/06/2018 09:28, Brian Norris wrote:
> >   drivers/power/supply/sbs-battery.c | 54 +++++++++++++++++++++++++-----
> >   1 file changed, 46 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> > index 83d7b4115857..a9691ea42f44 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c

...

> > @@ -806,6 +837,7 @@ static int sbs_probe(struct i2c_client *client,
> >   	if (!chip)
> >   		return -ENOMEM;
> > +	chip->flags = (u32)(uintptr_t)of_device_get_match_data(&client->dev);
> >   	chip->client = client;
> >   	chip->enable_detection = false;
> >   	psy_cfg.of_node = client->dev.of_node;
> > @@ -915,12 +947,15 @@ static int sbs_suspend(struct device *dev)
> >   	if (chip->poll_time > 0)
> >   		cancel_delayed_work_sync(&chip->work);
> > -	/*
> > -	 * Write to manufacturer access with sleep command.
> > -	 * Support is manufacturer dependend, so ignore errors.
> > -	 */
> > -	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
> > -		MANUFACTURER_ACCESS_SLEEP);
> > +	if (chip->flags & SBS_FLAGS_TI_BQ20Z75) {
> > +		/*
> > +		 * Write to manufacturer access with sleep command.
> > +		 * Support is manufacturer dependent, so ignore errors.
> > +		 */
> > +		sbs_write_word_data(client,
> > +				    sbs_data[REG_MANUFACTURER_DATA].addr,
> > +				    MANUFACTURER_ACCESS_SLEEP);
> > +	}
> 
> Now that this is only being done for only TI devices that support this I would think the comment
> about ignoring errors needs to go, and errors checks added.
> Ditto in the new sbs_get_ti_battery_presence_and_health()

Seems reasonable. I'll look at doing that and respinning.

> >   	return 0;
> >   }

Thanks,
Brian
