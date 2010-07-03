From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: make runtime_status attribute not
	debug-only
Date: Sat, 3 Jul 2010 21:29:24 +0200
Message-ID: <201007032129.24889.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1007021959520.24201-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007021959520.24201-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 03, 2010, Alan Stern wrote:
> On Fri, 2 Jul 2010, Rafael J. Wysocki wrote:
> 
> > On Friday, July 02, 2010, Alan Stern wrote:
> > > This patch (as1404) makes the runtime_status sysfs attribute available
> > > even in the absence of CONFIG_PM_ADVANCED_DEBUG, and it changes the
> > > routine to display "unknown" when runtime PM is disabled for a device.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > ---
> > > 
> > > Maybe "unsupported" would be a little better than "unknown".  What do 
> > > you think?
> > 
> > I thought about that.  "Unsupported" seems to suggest that the device/driver
> > doesn't support runtime PM, whiile in fact it may be supported, although it's
> > not enabled at the moment.
> 
> Drivers that support runtime PM generally don't leave it disabled for 
> very long.  IMO this wouldn't be terribly misleading.

Well, whatever.  I'm fine with that either way.

Rafael
