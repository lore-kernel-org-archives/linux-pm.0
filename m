From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: [Regression in 2.6.29] forcedeth doesn't work after
	resume from hibernation (was: Re: Resume after hibernation
	regression in 2.6.29)
Date: Sat, 4 Apr 2009 14:04:24 +0100
Message-ID: <200904041404.24616.tvrtko__13529.9486843453$1238850588$gmane$org@ursulin.net>
References: <200903261920.32173.tvrtko@ursulin.net>
	<9ae48b020904030824o1f94831asb60f979b3e489a8b@mail.gmail.com>
	<1238780473.19305.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1238780473.19305.3.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ed Swierk <eswierk@aristanetworks.com>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>, "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, stable@kernel.org, Arthur Jones <ajones@riverbed.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 03 April 2009 18:41:12 Ed Swierk wrote:
> On Fri, 2009-04-03 at 08:24 -0700, Ed Swierk wrote:
> > On Fri, Mar 27, 2009 at 1:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > I was able to reproduce the problem and identify the commit that broke
> > > the resume of forcedeth, which turned out to be:
> > >
> > > commit cb52deba12f27af90a46d2f8667a64888118a888
> > > Author: Ed Swierk <eswierk@arastra.com>
> > > Date:   Mon Dec 1 12:24:43 2008 +0000
> > >
> > >    forcedeth: power down phy when interface is down
> > >
> > >    Signed-off-by: Ed Swierk <eswierk@arastra.com>
> > >    Tested-by: Arthur Jones <ajones@riverbed.com>
> > >    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >    Signed-off-by: David S. Miller <davem@davemloft.net>
> > >
> > > Since I have no slightest idea of what this commit is supposed to
> > > achieve, I can only ask for reverting it.  It reverts cleanly, BTW.
> >
> > The change causes forcedeth to bring down the physical link when an
> > interface goes down; leaving it up causes the switch at the other end
> > to think the port is still active, with potentially random speed and
> > duplex parameters.
> >
> > It's possible that the forcedeth driver needs to reset autonegotiation
> > after bringing it up the link again.
> >
> > Can you please try this on a 2.6.29 kernel that's exhibiting the
> > symptoms you describe, after resuming the machine from hibernation:
> >
> >   ethtool -s eth1 autoneg off speed 100 duplex full
> >   ethtool -s eth1 autoneg on
> >
> > This should reset autonegotiation manually and bring the link. Let me
> > know how it goes.
>
> Also please try this patch; it fixes the problem on my test system (a
> DFI board with an nVidia MCP55).
>
> Signed-off-by: Ed Swierk <eswierk@aristanetworks.com>
> --
> --- linux-2.6.29.x86_64/drivers/net/forcedeth.c.orig	2009-03-23
> 16:12:14.000000000 -0700 +++
> linux-2.6.29.x86_64/drivers/net/forcedeth.c	2009-04-03 10:11:26.839614710
> -0700 @@ -5995,6 +5995,9 @@
>  	for (i = 0;i <= np->register_size/sizeof(u32); i++)
>  		writel(np->saved_config_space[i], base+i*sizeof(u32));
>
> +	/* restore phy state, including autoneg */
> +	phy_init(dev);
> +
>  	netif_device_attach(dev);
>  	if (netif_running(dev)) {
>  		rc = nv_open(dev);

Works for me on MCP73 as well.

Although NIC LED is still on after hibernation - seems to go off shortly 
before power off and then comes back on. Could be firmware issue I guess, 
this motherboard has always gulped power when off.

Tvrtko
