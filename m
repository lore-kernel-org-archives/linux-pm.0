From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Wed, 14 Nov 2007 14:11:29 +0100
Message-ID: <200711141411.30879.rjw@sisk.pl>
References: <200711041459.23082.rjw@sisk.pl>
	<1194979533.4299.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194979533.4299.5.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 13 of November 2007, Johannes Berg wrote:
> 
> On Sun, 2007-11-04 at 14:59 +0100, Rafael J. Wysocki wrote:
> > [Len, please add this patch to the suspend branch, thanks.]
> > ---
> > From: Johannes Berg <johannes@sipsolutions.net>
> > 
> > Lockdep reports a circular locking dependency in the hibernate code
> > because
> >  - during system boot hibernate code (from an initcall) locks pm_mutex
> >    and then a sysfs buffer mutex via name_to_dev_t
> >  - during regular operation hibernate code locks pm_mutex under a
> >    sysfs buffer mutex because it's called from sysfs methods.
> 
> Ping? Do I need to follow this or will somebody take care to merge it
> before .24 closes?

I wanted it to go via Len's tree, but unfortunately Len has not been responsive
recently.

I'll push it to Andrew later today.

Thanks,
Rafael
