From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 6 May 2010 00:40:26 +0100
Message-ID: <20100505234025.GB4838__35618.6417666779$1273102941$gmane$org@opensource.wolfsonmicro.com>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 01:56:07PM -0700, Brian Swetland wrote:

> From my point of view, the codec should be powered up while audio is
> playing and powered down when it's not -- that's the approach I've

This is what we've got already with Linux - we've had rather aggressive
runtime PM for embedded audio as standard for years now.  It's only very
recently that mobile hardware has got to the point where you can
actually totally kill the power without introducing problems but it's
been getting pretty much as close as possible.

> taken on MSM, regardless of suspend state.  I don't view suspend as
> something that stops audio playback in progress.  Sort of similar to
> how the modem doesn't power off down when the system is in suspend,
> etc.

This really does depend heavily on system design and the intended
function of the suspend on the part of the initiator.  In many systems
suspend will remove sufficient power to stop audio running even if it
were desired, and there's the idea with existing manually initiated
suspends that the system should stop what it's doing and go into a low
power, low responsiveness state.  Some systems will initiate a suspend
with active audio paths (especially those to or from the AP) which they
expect to be stopped.

> In effect, we have followed a sort of runtime pm model of
> clocking/powering peripherals at the lowest possible level at all
> times, which is why I've never viewed suspend_block as somehow
> competing with runtime pm -- we always want all drivers/peripherals in

Right, and this will work well on systems like your current devices
because the problem hardware is not directly visible to the AP (the
actual audio hardware is hidden behind the DSP which functions as
autonomously as the modem does) so it's not affected by the Linux
suspend process in the first place.  It causes confusion when the power
for the audio device is managed by Linux since the opportunistic suspend
will include suspending the audio device and so the code handling the
suspend then has to decide what exactly it's being asked to do.

> the lowers power state.  Sometimes the lowest power state possible is
> higher than "full suspend" (for example when we can't meet latency
> requirements on audio on 7201A) and suspend_blockers cover that case.

In this situation there's no physical reason why the lower power state
is not achievable so blocking the suspend would just waste power, it's
just that our way of getting into it is creating some confusion.
