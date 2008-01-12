From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Fri, 11 Jan 2008 20:29:46 -0800
Message-ID: <20080112042946.GA30093__31940.3741894805$1200112172$gmane$org@suse.de>
References: <20080112005619.GA4665@suse.de>
	<Pine.LNX.4.44L0.0801112208030.21411-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0801112208030.21411-100000@netrider.rowland.org>
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
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, ak@suse.de, linux-acpi@vger.kernel.org, pavel@suse.cz, tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 11, 2008 at 10:11:52PM -0500, Alan Stern wrote:
> On Fri, 11 Jan 2008, Greg KH wrote:
> 
> > On Fri, Jan 11, 2008 at 04:49:04PM -0800, Andrew Morton wrote:
> 
> > > err, no.  pm-introduce-destroy_suspended_device.patch demolishes
> > > pm-acquire-device-locks-on-suspend-rev-3.patch
> > > 
> > > Confused, giving up.
> > 
> > I'm confused too, I have no idea what the proper order of things should
> > be either.  Anyone want to give me a hint?
> 
> Sorry for the confusion.  The correct patch to apply is 
> pm-acquire-device-locks-on-suspend-rev-3 (plus the attending 
> style-fixups).  It encompasses those earlier patches.

Can someone resend this to me?  Do I need to drop the patch I currently
have in my tree as well?  Or put it before/after that one?

> The real problem is that our current email workflow patterns don't 
> provide a standardized way for maintainers to tell when a new patch 
> submission is meant to override or replace an earlier submission (or 
> even a set of earlier submissions).  Does anybody have some suggestions 
> for a good way to do this?

Yeah, just tell me what you want me to do with it (drop an old one,
replace it, add it, etc.)  We usually can handle this pretty well :)

thanks,

greg k-h
