From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM / Hibernate: Add sysfs knob to
 control size of memory for drivers
Date: Wed, 18 May 2011 19:27:17 +0200
Message-ID: <20110518172717.GA5734__12932.1820023053$1305739710$gmane$org@elf.ucw.cz>
References: <201105100059.25372.rjw@sisk.pl> <201105150056.55601.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105150056.55601.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Martin reports that on his system hibernation occasionally fails due
> > to the lack of memory, because the radeon driver apparently allocates
> > too much of it during the device freeze stage.  It turns out that the
> > amount of memory allocated by radeon during hibernation (and
> > presumably during system suspend too) depends on the utilization of
> > the GPU (e.g. hibernating while there are two KDE 4 sessions with
> > compositing enabled causes radeon to allocate more memory than for
> > one KDE 4 session).
> > 
> > In principle it should be possible to use image_size to make the
> > memory preallocation mechanism free enough memory for the radeon
> > driver, but in practice it is not easy to guess the right value
> > because of the way the preallocation code uses image_size.  For this
> > reason, it seems reasonable to allow users to control the amount of
> > memory reserved for driver allocations made after the preallocation,
> > which currently is constant and amounts to 1 MB.
> > 
> > Introduce a new sysfs file, /sys/power/reserved_size, whose value
> > will be used as the amount of memory to reserve for the
> > post-preallocation reservations made by device drivers, in bytes.
> > For backwards compatibility, set its default (and initial) value to
> > the currently used number (1 MB).
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=34102
> > Reported-by: Martin Steigerwald <Martin@Lichtvoll.de>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> OK, there are no comments, so my understanding is that everyone is fine
> with this patch and I can add it to my linux-next branch.

Actually no, I don't like it. Yes, knob might be useful for debugging,
but having it as part of official kernel interface...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
