From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 4 Dec 2013 15:56:35 +0100
Message-ID: <20131204145635.GA8062@lunn.ch>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-2-git-send-email-andrew@lunn.ch>
 <20131204143317.GL29282@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56648 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178Ab3LDO4n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Dec 2013 09:56:43 -0500
Content-Disposition: inline
In-Reply-To: <20131204143317.GL29282@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Wed, Dec 04, 2013 at 09:33:17AM -0500, Jason Cooper wrote:
> On Wed, Dec 04, 2013 at 03:17:18PM +0100, Andrew Lunn wrote:
> > The Marvell Dove SoC can run the CPU at two frequencies. The high
> > frequencey is from a PLL, while the lower is the same as the DDR
> > clock. Add a cpufreq driver to swap between these frequences.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Sort header files
> > Remove unneeded header files
> > Notify only on change
> > Use get_cpu_device(0), devm_clk_get()
> > Use platform_get_resource_byname()
> > Error check clk_prepare_enable()
> > Comment the interrupt handler
> > 
> > rebase onto 3.13-rc2 linux-next
> 
> Is there something you need that prevents you from basing on v3.13-rc1?

It seems to be Rafael's policy that patches for pm need to be based on
his linux-next branch. Viresh has also been making some major changes
to all the cpufreq drivers to move code into the core and out of
drivers. These changes are in rafaels linux-next, and i've made
similar changes to the driver so it fits in.

	Andrew
