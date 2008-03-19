From: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks
Date: Wed, 19 Mar 2008 11:07:21 -0700
Message-ID: <20080319180721.GB5296@kroah.com>
References: <200803170020.55473.rjw@sisk.pl> <200803170022.30345.rjw@sisk.pl>
	<20080319005340.GC8298@kroah.com> <200803191422.02064.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803191422.02064.rjw@sisk.pl>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 19, 2008 at 02:22:00PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, 19 of March 2008, Greg KH wrote:
> > On Mon, Mar 17, 2008 at 12:22:29AM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Introduce 'struct pm_ops' representing a set of suspend and
> > > hibernation operations for bus types, device classes and device
> > > types.
> > 
> > Ok, I must have missed the thread describing why we need to do this, so,
> > why do we need to do this?  What is this going to buy us in the end
> > after everything is changed?
> 
> There were many threads related to that.
> 
> To summarize, the first purpose is to separate suspend (aka s2ram and standby)
> callbacks from hibernation callbacks in such a way that the new callbacks won't
> take arguments and the purpose of each of them will be clearly specified.  This
> has been requested multiple times by many people, including Linus himself,
> and the reason is that within the current scheme if ->resume() is called, for
> example, it's difficult to say why it's been called (ie. is it a resume from RAM or
> from hibernation or a suspend/hibernation failure etc.?).
> 
> The second purpose is to make the suspend/hibernation callbacks more flexible
> so that device drivers can handle more than they can within the current scheme.
> For example, some drivers may need to prevent new children of the device from
> being registered before their ->suspend() callbacks are executed or they may
> want to carry out some operations requiring the availability of some other
> devices, not directly bound via the parent-child relationship, in order to prepare
> for the execution of ->suspend(), etc.
> 
> Ultimately, we'd like to stop using the freezing of tasks for suspend and
> therefore the drivers' suspend/hibernation code will have to take care of
> the handling of the user space during suspend/hibernation which would be
> difficult within the current scheme, without the ->prepare() and ->complete()
> callbacks.

Ok, thanks.  You might want to include this in the patch itself (hint,
hint, hint...)

greg k-h
