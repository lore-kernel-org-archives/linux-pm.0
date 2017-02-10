From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime
 PM
Date: Fri, 10 Feb 2017 10:20:04 +0530
Message-ID: <20170210045004.GN19244@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 09, 2017 at 03:22:51PM +0100, Marek Szyprowski wrote:
  
> +static int pl330_set_slave(struct dma_chan *chan, struct device *slave)
> +{
> +	struct dma_pl330_chan *pch = to_pchan(chan);
> +	struct pl330_dmac *pl330 = pch->dmac;
> +	int i;
> +
> +	mutex_lock(&pl330->rpm_lock);
> +
> +	for (i = 0; i < pl330->num_peripherals; i++) {
> +		if (pl330->peripherals[i].chan.slave == slave &&
> +		    pl330->peripherals[i].slave_link) {
> +			pch->slave_link = pl330->peripherals[i].slave_link;
> +			goto done;
> +		}
> +	}
> +
> +	pch->slave_link = device_link_add(slave, pl330->ddma.dev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

So you are going to add the link on channel allocation and tear down on the
freeup. I am not sure I really like the idea here.

First, these thing shouldn't be handled in the drivers. These things should
be set in core and each driver setting the links doesn't sound great to me.

Second, should the link be always there and we only mange the state? Here it
seems that we have link being created and destroyed, so why not mark it
ACTIVE and DORMANT instead...

Lastly, looking at th description of the issue here, am perceiving (maybe my
understanding is not quite right here) that you have an IP block in SoC
which has multiple things and share common stuff and doing right PM is a
challenge for you, right?

-- 
~Vinod
