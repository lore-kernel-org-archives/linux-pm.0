From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 3/4] amba: Don't unprepare the clocks if device
	driver wants IRQ safe runtime PM
Date: Tue, 16 Sep 2014 10:20:06 +0100
Message-ID: <20140916092006.GG12361@n2100.arm.linux.org.uk>
References: <1410857494-15936-1-git-send-email-k.kozlowski@samsung.com> <1410857494-15936-4-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410857494-15936-4-git-send-email-k.kozlowski@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 16, 2014 at 10:51:33AM +0200, Krzysztof Kozlowski wrote:
> @@ -191,8 +210,11 @@ static int amba_probe(struct device *dev)
>  		pm_runtime_enable(dev);
>  
>  		ret = pcdrv->probe(pcdev, id);
> -		if (ret == 0)
> +		if (ret == 0) {
> +			if (pm_runtime_is_irq_safe(dev))
> +				pcdev->irq_safe = 1;

Patch looks good, though I'd prefer this to always explicitly initialise
pcdev->irq_safe each time a probe succeeds.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
