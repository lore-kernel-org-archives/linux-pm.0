From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] sky2: Fix recent WOL regression
Date: Wed, 08 Oct 2008 16:12:10 -0700 (PDT)
Message-ID: <20081008.161210.79287275.davem__14620.2122014531$1223509481$gmane$org@davemloft.net>
References: <200810022339.34025.rjw@sisk.pl> <20081003090243.724cf79c@speedy>
	<200810090055.56598.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810090055.56598.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: akpm@linux-foundation.org, jeff@garzik.org, netdev@vger.kernel.org, tino.keitel@gmx.de, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, shemminger@vyatta.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 9 Oct 2008 00:55:55 +0200

> On Friday, 3 of October 2008, Stephen Hemminger wrote:
> > On Thu, 2 Oct 2008 23:39:33 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > sky2: Fix recent WOL regression
> > > 
> > > Since dev->power.should_wakeup bit is used by the PCI core to
> > > decide whether the device should wake up the system from sleep
> > > states, set/unset this bit whenever WOL is enabled/disabled using
> > > sky2_set_wol() (this fixes a regression from 2.6.26 on the Tino's
> > > machine).
> > > 
> > > Remove an open-coded reference to the standard PCI PM registers that
> > > is not used any more.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > Reported-by: Tino Keitel <tino.keitel@gmx.de>
> > > ---
> > 
> > Acked-by: Stephen Hemminger <shemminger@vyatta.com>
> > 
> > Thanks for fixing this.
> 
> Can you please include this patch into your next push for Jeff?
> 
> It seems to have been overlooked.

I missed this ACK but I did add the patch to my tree as you
can see from another email of mine.
