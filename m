From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 16:46:54 +0000
Message-ID: <20091209164653.GI9018__40591.877353336$1260377374$gmane$org@sirena.org.uk>
References: <20091209160256.GA3229@rakim.wolfsonmicro.main>
	<Pine.LNX.4.44L0.0912091117080.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091117080.4120-100000@iolanthe.rowland.org>
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

On Wed, Dec 09, 2009 at 11:23:00AM -0500, Alan Stern wrote:
> On Wed, 9 Dec 2009, Mark Brown wrote:

> > I'm not convinced that helps with the fact that the suspend may take a
> > long time - ideally we'd be able to start the suspend process off but
> > let other things carry on while it completes without having to worry
> > about something we're relying on getting suspended underneath us.

> The suspend procedure is oriented around device structures, and what 
> you're talking about isn't.  It's something separate which has to be 
> finished before _any_ of the audio devices are suspended.

In this context the "subsystem" actually has a struct device associated
with it so does appear in the device flow.

> How long does it take to bring down the entire embedded audio 
> subsystem?  And how critical is the timing for typical systems?

Worst case is about a second for both resume and suspend which means two
seconds total but it's very hardware dependant.  

The latency budget for suspend and resume are both zero in an ideal
world, users want to be able to suspend as much as possible which means
they'd like it to take no perceptible time at the human level.  Some
hardware is at the point where that's getting realistic but the folks on
older hardware still want to get as close to that as they can.
