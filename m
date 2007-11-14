From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Wed, 14 Nov 2007 22:54:33 +0100
Message-ID: <1195077273.22457.7.camel__43620.7866449424$1195077517$gmane$org@lappy>
References: <200711142225.58033.rjw@sisk.pl>  <20071114224200.GB7367@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071114224200.GB7367@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Wed, 2007-11-14 at 22:42 +0000, Pavel Machek wrote:
> On Wed 2007-11-14 22:25:57, Rafael J. Wysocki wrote:
> > [Andrew, please consider this as 2.6.24 material, thanks.]
> > ---
> > From: Johannes Berg <johannes@sipsolutions.net>
> > 
> > Lockdep reports a circular locking dependency in the hibernate code
> > because
> >  - during system boot hibernate code (from an initcall) locks pm_mutex
> >    and then a sysfs buffer mutex via name_to_dev_t
> >  - during regular operation hibernate code locks pm_mutex under a
> >    sysfs buffer mutex because it's called from sysfs methods.
> > 
> > The deadlock can never happen because during initcall invocation nothing
> > can write to sysfs yet. This removes the lockdep report by marking the
> > initcall locking as being in a different class.
> > 
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>

I guess mine got lost too :-)

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

> > Cc: Pavel Machek <pavel@ucw.cz>
> 
> ACK...
> 
