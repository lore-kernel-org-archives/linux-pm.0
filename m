From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] sky2: Fix recent WOL regression
Date: Thu, 9 Oct 2008 00:55:55 +0200
Message-ID: <200810090055.56598.rjw__34175.3797060393$1223506525$gmane$org@sisk.pl>
References: <200810022339.34025.rjw@sisk.pl> <20081003090243.724cf79c@speedy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081003090243.724cf79c@speedy>
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
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, Tino Keitel <tino.keitel@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 3 of October 2008, Stephen Hemminger wrote:
> On Thu, 2 Oct 2008 23:39:33 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > sky2: Fix recent WOL regression
> > 
> > Since dev->power.should_wakeup bit is used by the PCI core to
> > decide whether the device should wake up the system from sleep
> > states, set/unset this bit whenever WOL is enabled/disabled using
> > sky2_set_wol() (this fixes a regression from 2.6.26 on the Tino's
> > machine).
> > 
> > Remove an open-coded reference to the standard PCI PM registers that
> > is not used any more.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Reported-by: Tino Keitel <tino.keitel@gmx.de>
> > ---
> 
> Acked-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> Thanks for fixing this.

Can you please include this patch into your next push for Jeff?

It seems to have been overlooked.

Thanks,
Rafael
