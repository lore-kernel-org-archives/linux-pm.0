From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Tue, 10 Feb 2009 15:24:48 +0100
Message-ID: <200902101524.48536.rjw@sisk.pl>
References: <20090208103230.GB14143@elf.ucw.cz>
	<664304.90059.qm@web36806.mail.mud.yahoo.com>
	<20090210105820.GA4636@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090210105820.GA4636@atrey.karlin.mff.cuni.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 February 2009, Pavel Machek wrote:
> > Hi!
> >  
> > > > > > Just a FYI, with my Acer Aspire 1690 using 2.6.29-rc3
> > > > > > suspend/hibernate behave in this manner:
> > > > > > 
> > > > > > Hibernation completes ok but resumes immediately as if
> > > > > > I would have pressed the power button.
> > > > 
> > > > Thanks a lot for the tip, indeed it makes hibernation
> > > > working again:
> > > > 
> > > > root@localhost:~# echo shutdown > /sys/power/disk
> > > > root@localhost:~# pm-hibernate
> > > > 
> > > > Great! Is there a way to make this default on my
> > > > system, e.g., with a quirk?
> > > 
> > > Well, it would be better to fix it properly, than just work
> > > around it with quirk. I think it worked before and you already
> > > identified commit that breaks it?
> > 
> > Yes, we found out it with Rafael last month:
> > 
> > https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019225.html
> > https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019244.html
> > https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019251.html
> 
> Hmm, hibernation rework broke that, and looks USB related. Maybe it is
> fixed in latest kernel (-rc4), as there were USB-keeps-systems-awake
> fixes.

AFAICS, it is a chipset/BIOS problem.

As long as we were using shutdown to turn off the box during hibernation,
things worked on these boxes.  As soon as we started using the ACPI "enter S4"
feature, it stopped and ehci-hcd always happens to be the culprit (I had access
to one box with this issue, but unfortunately I don't have it any more).

The only thing we can really do here is to blacklist all of the boxes with this
problem and handle them in a special way.

Thanks,
Rafael
