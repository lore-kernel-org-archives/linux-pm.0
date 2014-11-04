From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v8 3/5] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Tue, 04 Nov 2014 08:59:29 +0100
Message-ID: <1415087969.2389.10.camel@AMDC1943>
References: <20141103100442.GB4042@n2100.arm.linux.org.uk>
 <Pine.LNX.4.44L0.1411031036350.1316-100000@iolanthe.rowland.org>
 <20141103154433.GC4042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20141103154433.GC4042@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pon, 2014-11-03 at 15:44 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 03, 2014 at 10:41:02AM -0500, Alan Stern wrote:
> > Bear in mind, however, that once the irq_safe flag has been set, the 
> > runtime PM core offers no way to turn it off again.
> 
> Ah, I thought it did permit it to change both ways.  In that case, we
> don't need to validate that it doesn't change state on each call, and
> we can just get away with checking its value.

It cannot be unset but still it could be *set* during runtime (not only
in probe). However that shouldn't happen between suspend-resume calls,
so the solution of undoing suspend's work seems fine.

I'll send a new patch doing this way. Without the wrapper.

Best regards,
Krzysztof



