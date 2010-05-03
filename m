From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 3 May 2010 23:18:35 +0200
Message-ID: <201005032318.35383.rjw__14429.4849633754$1272921841$gmane$org@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100503180741.GB2098@rakim.wolfsonmicro.main>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 03 May 2010, Mark Brown wrote:
> On Mon, May 03, 2010 at 09:40:26AM -0700, Kevin Hilman wrote:
> 
> > At least from the kernel perspective, both suspend blockers and
> > runtime PM have the same goal.  Given that, which framework should the
> > driver writer target?  Both?  Seems like duplicate effort.  Using
> > suspend blockers assumes the system is in opportunitstic suspend mode
> > and (at least in the keypad example given) assumes a suspend-blocker
> > aware userspace (Android.) Without both, targeted power savings will
> > not be acheived.
> 
> The other concern here is that for many mobile systems the actual
> semantic intended by "suspend" as it's currently used is more runtime PM
> like than full suspend - the classic example of this is that when
> suspending while on a call in a phone you don't want to suspend the
> modem or audio CODEC, you want to leave them running.  If you use a full
> system suspend then the drivers for affected components have to play
> guessing games (or add currently non-standard knobs for apps to twiddle)
> to decide if the system intends them to actually implement the suspend
> or not but with runtime PM it all falls out very naturally without any
> effort on the part of the driver.
> 
> > To me, runtime PM is a generic and flexible approach that can be used
> > with any userspace.  Driver writers should not have to care whether
> > the system is in "opportunistic" mode or about whether userspace is
> > suspend blocker capable.  They should only have to think about when
> > the device is (or should be) idle.
> 
> I fully agree with this.  We do need to ensure that a runtime PM based
> system can suspend the CPU core and RAM as well as system suspend can
> but that seems doable.

I _think_ it would be hard at least.  On ACPI-based systems it's not doable at
all AFAICS.

However, the real question is whether or not the opportunistic suspend feature
is worth adding to the kernel as such and I think it is.

To me, it doesn't duplicate the runtime PM framework which is aimed at the power
management of individual devices rather than the system as a whole.

Thanks,
Rafael
