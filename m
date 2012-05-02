From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv3 0/5] coupled cpuidle state support
Date: Tue, 1 May 2012 17:11:27 -0700
Message-ID: <CAMbhsRRhJ-7Am0k0OCJG0E9C=w+ApVi2Ce4b-BfV_6frJfTh=Q@mail.gmail.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<201204302325.09505.rjw@sisk.pl>
	<CAMbhsRRReyiv2LgUNgp6XiW07V8Eb0gd4fb7W6nBjMZ1FpmOBQ@mail.gmail.com>
	<20120501104310.GB28930@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120501104310.GB28930@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 1, 2012 at 3:43 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Colin,
>
> On Mon, Apr 30, 2012 at 10:37:30PM +0100, Colin Cross wrote:
<snip>

>> On Tegra3, the deepest individual cpu state for cpus 1-3 is OFF, the
>> same state the cpu would go into as the first step of a transition to
>> a deeper power state (cpus 0-3 OFF). =A0It would be more optimal in that
>> case to bypass the SMP cross call, and leave the cpu in OFF, but that
>> would require some way of disabling all wakeups for the secondary cpus
>> and then verifying that they didn't start waking up just before the
>> wakeups were disabled. =A0I have just started considering this
>> optimization, but I don't see anything in the existing code that would
>> prevent adding it later.
>
> I agree it is certainly an optimization that can be added later if benchm=
arks
> show it is needed (but again it is heavily platform dependent, ie technol=
ogy
> dependent).
> On a side note, disabling (or move to the primary) wake-ups for "secondar=
ies"
> on platforms where every core is in a different power domain is still nee=
ded
> to avoid having a situation where a CPU can independently get out of idle=
, ie
> abort idle, after hitting the coupled barrier.
> Still do not know if for those platforms coupled C-states should be used,=
 but
> it is much better to have a choice there IMHO.

Yes, that is the primary need for the coupled_cpuidle_parallel_barrier
function - secondary cpus need to disable their wakeup sources, then
check that a wakeup was not already pending and abort if necessary.

> I have also started thinking about a cluster or multi-CPU "next-event" th=
at
> could avoid triggering heavy operations like L2 cleaning (ie cluster shut=
down)
> if a timer is about to expire on a given CPU (as you know CPUs get in and=
 out
> of idle independently so the governor decision at the point the coupled s=
tate
> barrier is hit might be stale).

It would be possible to re-check the governor to decide the next state
(maybe only if the previous decision is out of date by more than the
target_residency?), but I left that as an additional optimization.

> I reckon the coupled C-state concept can prove to be an effective one for
> some platforms, currently benchmarking it.
>
>> A simple measurement using the tracing may show that it is
>> unnecessary. =A0If the wakeup time for CPU1 to go from OFF to active is
>> small there might be no need to optimize out the extra wakeup.
>
> Indeed, it is all about resetting the CPU and getting it started, with
> inclusive L2 the power cost of shutting down a CPU and resuming it should=
 be
> low (and timing very fast) for most platforms.

The limiting factor may be the amount of time spent in ROM/Trustzone
code when bringing a cpu back online.
