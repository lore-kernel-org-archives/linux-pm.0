From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v8 3/5] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Mon, 3 Nov 2014 15:44:33 +0000
Message-ID: <20141103154433.GC4042@n2100.arm.linux.org.uk>
References: <20141103100442.GB4042@n2100.arm.linux.org.uk>
 <Pine.LNX.4.44L0.1411031036350.1316-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54028 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751922AbaKCPo5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 10:44:57 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411031036350.1316-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, Nov 03, 2014 at 10:41:02AM -0500, Alan Stern wrote:
> Bear in mind, however, that once the irq_safe flag has been set, the 
> runtime PM core offers no way to turn it off again.

Ah, I thought it did permit it to change both ways.  In that case, we
don't need to validate that it doesn't change state on each call, and
we can just get away with checking its value.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
