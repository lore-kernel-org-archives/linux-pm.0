From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v8 3/5] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Mon, 3 Nov 2014 10:04:42 +0000
Message-ID: <20141103100442.GB4042@n2100.arm.linux.org.uk>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
 <1413795888-18559-4-git-send-email-k.kozlowski@samsung.com>
 <1479283.dvHduzBoyf@vostro.rjw.lan>
 <20141101005514.GY27405@n2100.arm.linux.org.uk>
 <20141101010113.GA3831@n2100.arm.linux.org.uk>
 <1415003805.4241.6.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415003805.4241.6.camel@AMDC1943>
Sender: linux-doc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 03, 2014 at 09:36:45AM +0100, Krzysztof Kozlowski wrote:
> On sob, 2014-11-01 at 01:01 +0000, Russell King - ARM Linux wrote:
> > Would another possible solution be to remember the irq-safeness in the
> > suspend handler, and use that in the resume handler?  Resume should
> > /always/ undo what the suspend handler previously did wrt clk API stuff.
> 
> I think the second solution could be more readable. The WARN_ON wouldn't
> be needed. However this won't solve the two dual nature of runtime
> callbacks.
> 
> I wondered also about removing runtime PM callbacks from amba/bus.c
> completely and moving this to child drivers. This way runtime PM would
> be obvious in each driver case.

That makes it pretty horrid from the point of view of having bus
management code, because we now have the management of the bus clock
split between the bus layer and the device driver.

This is /really/ a problem for runtime PM.  Runtime PM permits there
to be a bus layer involved - and runtime PM can also be coupled up
to PM domains as well.  For all this stuff, the context which the
callbacks are called in depends on whether the driver itself has
marked the device as having IRQ-safe callbacks.

That's fine, but the bus and PM domain level code then /really/ needs
to know what context they're being called in, so they know whether
they can sleep or not, or they must to be written to always use
non-sleeping functions so they work in both contexts.  If we assume
the former, then that implies that the irq-safe flag must never change
state between a suspend and a resume.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
