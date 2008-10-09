From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] sky2: Fix recent WOL regression
Date: Thu, 9 Oct 2008 23:01:35 +0200
Message-ID: <200810092301.36633.rjw__35885.7478750453$1223586087$gmane$org@sisk.pl>
References: <200810022339.34025.rjw@sisk.pl> <200810090055.56598.rjw@sisk.pl>
	<20081008.161210.79287275.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081008.161210.79287275.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, jeff@garzik.org, netdev@vger.kernel.org, tino.keitel@gmx.de, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, shemminger@vyatta.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 9 of October 2008, David Miller wrote:
> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> Date: Thu, 9 Oct 2008 00:55:55 +0200
> 
> > On Friday, 3 of October 2008, Stephen Hemminger wrote:
> > > On Thu, 2 Oct 2008 23:39:33 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > sky2: Fix recent WOL regression
> > > > 
> > > > Since dev->power.should_wakeup bit is used by the PCI core to
> > > > decide whether the device should wake up the system from sleep
> > > > states, set/unset this bit whenever WOL is enabled/disabled using
> > > > sky2_set_wol() (this fixes a regression from 2.6.26 on the Tino's
> > > > machine).
> > > > 
> > > > Remove an open-coded reference to the standard PCI PM registers that
> > > > is not used any more.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > Reported-by: Tino Keitel <tino.keitel@gmx.de>
> > > > ---
> > > 
> > > Acked-by: Stephen Hemminger <shemminger@vyatta.com>
> > > 
> > > Thanks for fixing this.
> > 
> > Can you please include this patch into your next push for Jeff?
> > 
> > It seems to have been overlooked.
> 
> I missed this ACK but I did add the patch to my tree as you
> can see from another email of mine.

I saw it, thanks!
