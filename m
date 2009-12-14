From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] uswsusp: automatically free the in-memory
 image once s2disk has finished with it
Date: Mon, 14 Dec 2009 12:08:35 +0100
Message-ID: <20091214110835.GA1937__49837.7331569374$1260789004$gmane$org@elf.ucw.cz>
References: <4B16797C.3010304@tuffmail.co.uk>
	<20091202211107.GA20830@elf.ucw.cz>
	<20091202220718.GI1457@csn.ul.ie>
	<20091202221524.GB20830@elf.ucw.cz>
	<20091202222516.GD26702@csn.ul.ie>
	<20091203075301.GA29440@elf.ucw.cz>
	<4B17B5B8.1060105@tuffmail.co.uk>
	<20091203145018.GG26702@csn.ul.ie>
	<9b2b86520912071637v6957ed24ie0f67acf6785ab08@mail.gmail.com>
	<20091211105352.GB30670@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091211105352.GB30670@csn.ul.ie>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mel Gorman <mel@csn.ul.ie>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-12-11 10:53:52, Mel Gorman wrote:
> On Tue, Dec 08, 2009 at 12:37:36AM +0000, Alan Jenkins wrote:
> > >> <SNIP>
> > >> Here's a new datum:
> > >>
> > >> Applying this patch has left a less frequent hang.  So far it has
> > >> happened twice.  (Once playing last night, and once today testing
> > >> hibernation with KMS enabled).
> > >>
> > >> This hang happens at a different point.  It happens _before_ writing out
> > >> the hibernation image.  That is, I don't see the textual progress bar,
> > >> and if I force a power-cycle then it doesn't resume (and complains about
> > >> uncleanly unmounted filesystems).
> > >>
> > >> Here is the backtrace:
> > >>
> > >> [top of screen]
> > >> s2disk D c1c05580 0 5988 5809 0x00000000
> > >> ...
> > >> Call Trace:
> > >> ...
> > >> ? wait_for_common
> > >> ? default_wake_function
> > >> ? kthread_create
> > >> ? worker_thread
> > >> ? create_workqueue_thread
> > >> ? worker_thread
> > >> ? __create_workqueue_thread
> > >> ? stop_machine_create
> > >> ? disable_nonboot_cpus
> > >> ? hibernation_snapshot
> > >> ? snapshot_ioctl
> > >> ...
> > >> ? sys_ioctl
> > >>
> > 
> > > Can you reconfirm that backing out both of those patches makes this 100%
> > > reliable or is it just a lot harder to trigger. It does not even appear
> > > that it's locked up within the page allocator at this trace message.
> > > Assuming c1c05580 is where it's stuck at, where does addr2line say that
> > > is (requires CONFIG_DEBUG_INFO) ?
> > 
> > The new hang happened with only one patch applied (my "uswsusp:
> > automatically free the in-memory image once s2disk has finished with
> > it").
> > 
> 
> Ok. I'm learning towards believing that the system is extremely
> borderline and what c1c05580 is doing is changing very slightly how many
> pages are available. Why it makes a difference on uni-core, I have no
> idea but it could be very small differences in available memory as it
> does increase the size of some in-kernel structures.

It should be very easy to test that theory, right? Just reduce
PAGES_FOR_IO to 3.9MB, and if it breaks, you know system was
borderline. 
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
