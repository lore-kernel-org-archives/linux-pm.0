From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC Disable suspend on a specific device] This is a
	little	change in linux power scheme
Date: Tue, 7 Apr 2009 23:38:25 +0200
Message-ID: <20090407213824.GM3278@elf.ucw.cz>
References: <200904072257.23756.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0904071729210.307-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0904071729210.307-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2009-04-07 17:31:13, Alan Stern wrote:
> On Tue, 7 Apr 2009, Rafael J. Wysocki wrote:
> 
> > > >> I works on an hardware that have the gsm connect to wm8753 and the 
> > > >> bluetooth subsystem
> > > >> too direct connected. So I would like that a phone call for example 
> > > >> remains on during
> > > >> system suspend. With this approch I can disable suspend of an entire 
> > > >> subtree of device,
> > > >> that can be used by other hardware component. This change avoid any 
> > > >> specific change to the
> > > >> driver.
> > > >>     
> > > >
> > > > Why do you want to avoid changing the driver, actually?
> > > >
> > > > Rafael
> > > >
> > > >   
> > > Because, the driver may be connected to other device and you must change 
> > > the entire
> > > set. This simple modification can help to share devices on an embedded 
> > > board and control
> > > suspend/resume enable from user space. I don't know if it can be usefull 
> > > on broken board/device too. Do you see any possible risk with this 
> > > change?
> > 
> > Yes, a (rather high) risk of abuse.
> > 
> > > When I write it I try to have a simple modification on linux-pm part.
> > 
> > So, basically, you'd like to introduce an interface allowing the user space to
> > tell the kernel which devices not to suspend, because there may be some
> > dependencies between devices that the kernel presumably doesn't know of.
> > 
> > Well, what about teaching these dependencies to the kernel, so that it
> > can take them into account by itself?
> 
> Isn't that exactly what the patch already does?  It lets the kernel
> know that when the "don't-suspend" flag is set for a device then the
> entire sub-tree rooted at that device should remain unsuspended.

Well.... userspace should not have to decide this. If userspace tells
kernel not to suspend video card (on PC/ACPI), then we either honour
the request, or violate ACPI spec (and probably break suspend).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
