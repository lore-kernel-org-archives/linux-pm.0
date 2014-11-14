From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v11 1/6] PM / Runtime: Add getter for querying the IRQ safe
 option
Date: Fri, 14 Nov 2014 09:14:48 +0100
Message-ID: <1415952888.25732.3.camel@AMDC1943>
References: <1415802748-30530-1-git-send-email-k.kozlowski@samsung.com>
 <1415802748-30530-2-git-send-email-k.kozlowski@samsung.com>
 <3087810.nyWZ4cyKAA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:16485 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbaKNIOv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 03:14:51 -0500
In-reply-to: <3087810.nyWZ4cyKAA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On czw, 2014-11-13 at 02:34 +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 12, 2014 03:32:23 PM Krzysztof Kozlowski wrote:
> > Add a simple getter pm_runtime_is_irq_safe() for querying whether runtime
> > PM IRQ safe was set or not.
> > 
> > Various bus drivers implementing runtime PM may use choose to suspend
> > differently based on IRQ safeness status of child driver (e.g. do not
> > unprepare the clock if IRQ safe is not set).
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> I'm fine with this one, please feel free to add my ACK if that needs to go
> through a different tree.

Thanks!

With your ack I'll push patchset through Russell's patch system.

Best regards,
Krzysztof



