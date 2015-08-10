From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 18/23] power/reset: at91-reset: get and use slow clock
Date: Mon, 10 Aug 2015 17:50:05 +0200
Message-ID: <20150810155005.GH3411@piout.net>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-19-git-send-email-alexandre.belloni@free-electrons.com>
 <20150805182220.GC11315@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150805182220.GC11315@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/08/2015 at 20:22:20 +0200, Sebastian Reichel wrote :
> Hi,
> 
> On Fri, Jul 31, 2015 at 11:39:54AM +0200, Alexandre Belloni wrote:
> > Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> > hang") added a workaround for the slow clock as it is not properly handled
> > by its users.
> > 
> > Get and use the slow clock as it is necessary for the at91 reset
> > controller.
> 
> You call clk_prepare_enable during probe without a matching
> clk_disable_unprepare on module removal.
> 

They will never be compiled as modules as the Kconfig option is a bool
so we don't have a .remove and the module will never be removed.

Do you want me to change at91-reset and at91-poweroff to work as
modules?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
