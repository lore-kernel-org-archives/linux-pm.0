From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 10:49:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091044340.4120-100000__38192.858748562$1260373941$gmane$org@iolanthe.rowland.org>
References: <20091209133829.GF9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091209133829.GF9018@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Dec 2009, Mark Brown wrote:

> On Tue, Dec 08, 2009 at 09:35:59PM -0500, Alan Stern wrote:
> > On Tue, 8 Dec 2009, Linus Torvalds wrote:
> 
> > > It's just that I think the "looping over children" is ugly, when I think 
> > > that by doing it the other way around you can make the code simpler and 
> > > only depend on the PM device list and a simple parent pointer access.
> 
> > I agree that it is uglier.  The only advantage is in handling
> > asynchronous non-tree suspend dependencies, of which we probably won't
> > have very many.  In fact, I don't know of _any_ offhand.
> 
> There's some potential for this in embedded audio - it wants to bring
> down the entire embedded audio subsystem at once before the individual
> devices (and their parents) get suspended since bringing them down out
> of sync can result in audible artifacts.  Depending on the system the
> suspend may take a noticable amount of time so it'd be nice to be able
> to run it asynchronously, though we don't currently do so.

For something like bringing down the entire embedded audio subsystem, 
which isn't directly tied to a single device, you would probably be 
better off doing it when the PM core broadcasts a suspend notification
(see register_pm_notifier() in include/linux/suspend.h).  This occurs 
before any devices are suspended, so synchronization isn't an issue.

> At the minute we get away with this mostly through not being able to
> represent the cases that are likely to actually trip up over it.
> 
> > Interestingly, this non-tree dependency problem does not affect resume.
> 
> Embedded audio does potentially - the resume needs all the individual
> devices in the subsystem and can take a substantial proportion of the
> overall resume time.  Currently we get away with a combination of
> assuming that all the drivers are live when we decide to start resuming
> them and using the ALSA userspace API to deal with bringing the resume
> out of line, but it's not ideal.

You can do the same thing with the resume notifier.

Alan Stern
