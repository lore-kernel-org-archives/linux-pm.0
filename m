From: Greg KH <greg@kroah.com>
Subject: Re: Re: lockdep report in hibernate code
Date: Wed, 24 Oct 2007 14:57:15 -0700
Message-ID: <20071024215715.GA9524@kroah.com>
References: <Pine.LNX.4.44L0.0710231750370.21581-100000@netrider.rowland.org>
	<200710240018.02655.rjw@sisk.pl>
	<1193215220.4097.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1193215220.4097.8.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 24, 2007 at 10:40:20AM +0200, Johannes Berg wrote:
> On Wed, 2007-10-24 at 00:18 +0200, Rafael J. Wysocki wrote:
> 
> > Yes, which is what I think is happening in this particular case.  More
> > precisely, we get pm_mutex while holding a buffer mutex, so lockdep is warning
> > when we get another buffer mutex afterwards.
> 
> Precisely. That's why I copied Greg on the second mail :) It seems that
> sysfs already uses nested locks, but that only protects against lockdep
> reporting a false positive for nested locks, not this case.

Ok, I'm confused, where is the sysfs issue here?

thanks,

greg k-h
