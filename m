From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 11:23:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091117080.4120-100000__20115.7960146249$1260375843$gmane$org@iolanthe.rowland.org>
References: <20091209160256.GA3229@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091209160256.GA3229@rakim.wolfsonmicro.main>
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

> On Wed, Dec 09, 2009 at 10:49:56AM -0500, Alan Stern wrote:
> > On Wed, 9 Dec 2009, Mark Brown wrote:
> 
> > > There's some potential for this in embedded audio - it wants to bring
> > > down the entire embedded audio subsystem at once before the individual
> > > devices (and their parents) get suspended since bringing them down out
> 
> > For something like bringing down the entire embedded audio subsystem, 
> > which isn't directly tied to a single device, you would probably be 
> > better off doing it when the PM core broadcasts a suspend notification
> > (see register_pm_notifier() in include/linux/suspend.h).  This occurs 
> > before any devices are suspended, so synchronization isn't an issue.
> 
> I'm not convinced that helps with the fact that the suspend may take a
> long time - ideally we'd be able to start the suspend process off but
> let other things carry on while it completes without having to worry
> about something we're relying on getting suspended underneath us.

The suspend procedure is oriented around device structures, and what 
you're talking about isn't.  It's something separate which has to be 
finished before _any_ of the audio devices are suspended.

How long does it take to bring down the entire embedded audio 
subsystem?  And how critical is the timing for typical systems?

Alan Stern
