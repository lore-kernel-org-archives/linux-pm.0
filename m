From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] thermal: bang-bang governor: act on lower trip
 boundary
Date: Thu, 28 Apr 2016 07:50:55 -0700
Message-ID: <20160428145054.GC19279@localhost.localdomain>
References: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
 <1461553367-24744-5-git-send-email-wxt@rock-chips.com>
 <20160427215425.GD6438@localhost.localdomain>
 <20160428063018.GX7860@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160428063018.GX7860-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eddie.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 28, 2016 at 08:30:18AM +0200, Sascha Hauer wrote:
> On Wed, Apr 27, 2016 at 02:54:26PM -0700, Eduardo Valentin wrote:
> > On Mon, Apr 25, 2016 at 11:02:47AM +0800, Caesar Wang wrote:
> > > From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > 
> > > With interrupt driven thermal zones we pass the lower and upper
> > > temperature on which shall be acted, so in the governor we have to act on
> > > the exact lower temperature to be consistent. Otherwise an interrupt maybe
> > > generated on the exact lower temperature, but the bang bang governor does
> > > not react.
> > 
> > What is the expected impact on polling driven zones that use bang bang
> > after this change?
> 
> Polling driven zones may have to be one step cooler before the governor
> reacts, otherwise the behaviour should be unaffected.

OK. Can we add this description of the expectation of what will happen
to polling driver zones in the next version? An explanation on how this
has bee tested on polling driven zones it is also welcome.

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
