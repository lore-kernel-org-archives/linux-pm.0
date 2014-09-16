From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 0/4] amba/dma: pl330: add Power Management support
Date: Tue, 16 Sep 2014 18:28:28 +0200
Message-ID: <1410884908.18259.4.camel@AMDC1943>
References: <1410872360-27029-1-git-send-email-k.kozlowski@samsung.com>
 <20140916161820.GM12361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20140916161820.GM12361@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On wto, 2014-09-16 at 17:18 +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 16, 2014 at 02:59:16PM +0200, Krzysztof Kozlowski wrote:
> > Any comments are welcome.
> 
> Thanks, I'm happy with patches 2 and 3.  What's the merge plan for them?

I think everything could be picked by dmaengine maintainers because the
pl330 is the cause of all these patches. On the other hand I could
submit the patches to your patch tracking system.

However I still don't have necessary reviews/acks from PM (patch 1/4)
and dmaengine (patch 4/4). Anyway can I assume that you acked patch 2
and 3?

Best regards,
Krzysztof


