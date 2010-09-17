From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM / Wakeup: Introduce wakeup source objects and
 event statistics (v2)
Date: Fri, 17 Sep 2010 10:03:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009171000100.1589-100000__35724.411896854$1284732235$gmane$org@iolanthe.rowland.org>
References: <201009170254.19753.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009170254.19753.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Sep 2010, Rafael J. Wysocki wrote:

> > Was doing some experiments with this on OMAP, and found a minor
> > cut-and-paste bug in the Documentation file:
> > 
> > [...]
> > 
> > > +What:		/sys/devices/.../power/wakeup_max_time_ms
> > > +Date:		September 2010
> > > +Contact:	Rafael J. Wysocki <rjw@sisk.pl>
> > > +Description:
> > > +		The /sys/devices/.../wakeup_max_time_ms attribute contains
> > > +		the maximum time of processing a single wakeup event associated
> > > +		with the device, in milliseconds.  This attribute is read-only.
> > > +		If the device is not enabled to wake up the system from sleep
> > > +		states, this attribute is empty.
> > > +
> > > +What:		/sys/devices/.../power/wakeup_max_time_ms
> >                                                       ^^^
> > s/max/last/ for this one.
> 
> Ah, thanks a lot.

There was another copy & paste errors in that file, a 
"wakeup_active_count" that should be "wakeup_hit_count".

Alan Stern
