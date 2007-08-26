From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Date: Sun, 26 Aug 2007 21:10:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708262110010.3791__36539.7167778157$1188155613$gmane$org@poirot.grange>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
	<20070826110830.dfe6ea24.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070826110830.dfe6ea24.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 26 Aug 2007, Stephen Rothwell wrote:

> On Sun, 26 Aug 2007 02:03:49 +0200 (CEST) Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >
> > +static int ls_pm_enter(suspend_state_t state)
> > +{
> > +	char ier;
> > +	int ret = 0;
> > +	u64 tb;
> > +
> > +	if ((ret = mpc10x_suspend(state)) < 0)
> > +		return ret;
> > +
> > +	/* Get timebase */
> > +	tb = get_tb();
> > +
> > +	/* put CPU to sleep, re-enabling interrupts */
> > +	mpc6xx_enter_sleep();
> > +
> > +	local_irq_disable();
> > +
> > +	set_tb(tb >> 32, tb & 0xfffffffful);
> > +
> > +fail:
> 
> Unused label?

Right, will fix in the next version, thanks.

Guennadi
---
Guennadi Liakhovetski
