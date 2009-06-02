From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [regression,
 bisected] adb trackpad disappears after suspend to ram
Date: Tue, 02 Jun 2009 14:49:24 +1000
Message-ID: <1243918164.5308.23.camel@pasglop>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<200905292010.10615.rjw@sisk.pl>
	<87fxekxe3w.fsf@scholz.fias.uni-frankfurt.de>
	<200906011836.15507.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906011836.15507.rjw@sisk.pl>
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
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Jan Scholz <scholz@fias.uni-frankfurt.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> So, it seems we lose and interrupt during resume and that confuses the
> ADB controller driver or something like this.  Do you use the keyboard or
> the trackpad as a wake-up device?
> 
> Please additionally try to go back to the original code, put
> 'sleepy_trackpad = 1' at the beginning of do_adb_reset_bus() in
> drivers/macintosh/adb.c and see if the problem is reproducible with that.

Well, the ADB controller is also the PMU (drivers/macintosh/via-pmu.c)
which is also the system controller, handles the actual sleep state,
etc... :-)

That code is a bit itchy around the edges. I'm not sure it would have
lost an interrupt, that sounds more like losing an IRQ would have broken
it completely but it's not -impossible- (especially if it's the external
GPIO or CB1 interrupt that notifies of an incoming ADB message).

I haven't managed to reproduce the problem yet here though. I'll see if
I can with a titanium powerbook I have somewhere in storage that might
be a bit closer to your machine than the wallstreet powerbook I've been
using to test at work :-) My other powerbook test machine uses a USB
trackpad. 

Cheers,
Ben.
