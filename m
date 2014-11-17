From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
Date: Mon, 17 Nov 2014 15:32:57 +0000
Message-ID: <20141117153257.GS4042@n2100.arm.linux.org.uk>
References: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43300 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750812AbaKQPdP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 10:33:15 -0500
Content-Disposition: inline
In-Reply-To: <1416237550-31092-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org

On Mon, Nov 17, 2014 at 04:19:10PM +0100, Ulf Hansson wrote:
> The amba bus, amba drivers and a vast amount of platform drivers which
> enables runtime PM, don't invoke a pm_runtime_get_sync() while probing
> their devices.
> 
> Instead, once they have turned on their PM resourses during ->probe()
> and are ready to handle I/O, these invokes pm_runtime_set_active() to
> synchronize its state towards the runtime PM core.

The above is misleading for amba.  The code sequence is:

                pm_runtime_get_noresume(dev);
                pm_runtime_set_active(dev);
                pm_runtime_enable(dev);

                ret = pcdrv->probe(pcdev, id);

AMBA drivers should never call pm_runtime_set_active(), as the runtime PM
state has already been initialised by the bus code.  Platform drivers are
different; the platform code provides zero help for runtime PM.

The sequence used by AMBA bus code is the sequence which was used by PCI
(as per commit f3ec4f87d607) at the time the runtime PM support was
written for AMBA.  PCI assumes that unbound devices are already powered
up, and as far as I'm aware, that's also true of AMBA devices as well.
I have yet to have access to a platform where this isn't true, neither
has anyone reported that such a platform exists.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
