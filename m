From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM / Wakeup: Introduce wakeup source objects and
	event statistics (v2)
Date: Sat, 18 Sep 2010 00:26:36 +0200
Message-ID: <201009180026.37013.rjw__44899.6687461205$1284762729$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1009171000100.1589-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009171000100.1589-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arve@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 17, 2010, Alan Stern wrote:
> On Fri, 17 Sep 2010, Rafael J. Wysocki wrote:
> 
> > > Was doing some experiments with this on OMAP, and found a minor
> > > cut-and-paste bug in the Documentation file:
> > > 
> > > [...]
> > > 
> > > > +What:		/sys/devices/.../power/wakeup_max_time_ms
> > > > +Date:		September 2010
> > > > +Contact:	Rafael J. Wysocki <rjw@sisk.pl>
> > > > +Description:
> > > > +		The /sys/devices/.../wakeup_max_time_ms attribute contains
> > > > +		the maximum time of processing a single wakeup event associated
> > > > +		with the device, in milliseconds.  This attribute is read-only.
> > > > +		If the device is not enabled to wake up the system from sleep
> > > > +		states, this attribute is empty.
> > > > +
> > > > +What:		/sys/devices/.../power/wakeup_max_time_ms
> > >                                                       ^^^
> > > s/max/last/ for this one.
> > 
> > Ah, thanks a lot.
> 
> There was another copy & paste errors in that file, a 
> "wakeup_active_count" that should be "wakeup_hit_count".

Indeed, fixed now.

Thanks,
Rafael
