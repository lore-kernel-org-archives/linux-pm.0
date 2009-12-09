From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 16:02:56 +0000
Message-ID: <20091209160256.GA3229__23451.7991579652$1260374643$gmane$org@rakim.wolfsonmicro.main>
References: <20091209133829.GF9018@sirena.org.uk>
	<Pine.LNX.4.44L0.0912091044340.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091044340.4120-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 09, 2009 at 10:49:56AM -0500, Alan Stern wrote:
> On Wed, 9 Dec 2009, Mark Brown wrote:

> > There's some potential for this in embedded audio - it wants to bring
> > down the entire embedded audio subsystem at once before the individual
> > devices (and their parents) get suspended since bringing them down out

> For something like bringing down the entire embedded audio subsystem, 
> which isn't directly tied to a single device, you would probably be 
> better off doing it when the PM core broadcasts a suspend notification
> (see register_pm_notifier() in include/linux/suspend.h).  This occurs 
> before any devices are suspended, so synchronization isn't an issue.

I'm not convinced that helps with the fact that the suspend may take a
long time - ideally we'd be able to start the suspend process off but
let other things carry on while it completes without having to worry
about something we're relying on getting suspended underneath us.

> > Embedded audio does potentially - the resume needs all the individual
> > overall resume time.  Currently we get away with a combination of

> You can do the same thing with the resume notifier.

Similarly, the length of time the resume may take to complete means it'd
be nice to start as soon as we've got the devices and complete it at our
leisure.  This is less pressing since we can tell the PM core we've
resumed but still block userspace.
