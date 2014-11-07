From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no
 PM_RUNTIME
Date: Fri, 7 Nov 2014 09:50:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411070948180.1214-100000@iolanthe.rowland.org>
References: <1415347601.8532.7.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415347601.8532.7.camel@AMDC1943>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Nov 2014, Krzysztof Kozlowski wrote:

> > Well, that is a good reason to introduce a wrapper around power.irq_safe in my
> > view.
> > 
> > And define the wrapper so that it always returns false for CONFIG_PM_RUNTIME
> > unset.
> > 
> > This way not only you wouldn't need to move the flag from under the #ifdef,
> > but also you would make the compiler skip the relevant pieces of code
> > entiretly for CONFIG_PM_RUNTIME unset.
> 
> Few days ago I would be happy with your opinion :), but know I think
> this is better solution than wrapper. Consider case:
> 1. PM_RUNTIME unset.
> 2. System suspends.
> 3. The pl330 in its suspend callback calls force_runtime_suspend which
> leads us to amba/bus.
> 4. The amba/bus.c in runtime suspend checks for irq_safe (it is FALSE),
> so it disables and unprepares the clock.
> 5. The pl330 in probe requested irq_safe so it assumes amba/bus will
> only disable the clock. So the pl330 unprepares the clock. Again.

To me, this sounds like a good reason to avoid using 
force_runtime_suspend().  In fact, it sounds like a good reason to 
avoid relying on the runtime PM mechanism to handle non-runtime-PM 
things (like a system suspend callback).  If CONFIG_PM_RUNTIME isn't 
enabled then the runtime PM stack simply should not be used.

Alan Stern
