From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 3 May 2010 13:12:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005031301400.1651-100000__19796.5392530479$1272906847$gmane$org@iolanthe.rowland.org>
References: <87wrvl5479.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87wrvl5479.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Oleg Nesterov <oleg@redhat.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 May 2010, Kevin Hilman wrote:

> Suspend blockers vs runtime PM
> ------------------------------
> 
> My primary concern is that suspend blockers attempt to address the
> same problem(s) as runtime PM, but with a very different approach.
> Suspend blockers use one very large hammer whereas runtime PM hands
> out many little hammers.  Since I believe power management to be a
> problem of many little nails, I think many little hammers are better
> suited for the job.

There is a major difference between suspend blockers and runtime PM 
which was not discussed in your email.  Namely: Runtime PM is aimed at 
suspending individual devices and not the system as a whole (in 
particular, not CPUs), whereas suspend blockers are aimed at suspending 
-- or more accurately, blocking suspends -- of the system as a whole 
and not individual devices.

So for example, runtime PM cannot be used to put the system into an S3 
sleep state.  But suspend blockers _are_ used to keep the system from 
going into S3.

> Currently in the kernel, we have two main forms of PM
> 
> - static PM (system PM, traditional suspend/resume etc.)
> - dynamic PM (runtime PM, CPUfreq, CPUidle, etc.)
> 
> And with the addition of suspend blockers we have something in
> between.  In my simple world, I think of suspend_blockers as static PM
> with a retrofit of some basic dynamic capabilities.  In my view, a
> poor man's dynamic PM.

I wouldn't describe it like that.  Consider dividing PM along a 
different axis:

- entire system (ACPI sleep states, CPUs turned off, etc.)
- single, independent devices (e.g., USB autosuspend)

Then system PM combines static + entire, whereas runtime PM combines 
dynamic + single.  By contrast, suspend blockers are aimed at the 
dynamic + entire combination.  This makes them different from anything 
already present in the kernel.

> The current design of suspend blockers was (presumably) taken due to
> major limitations and/or problems in dynamic PM when it was designed.
> However, since then, some very signifcant improvements in dynamic PM
> have come along, particularily in the form of runtime PM.  What I
> still feel is missing from this discussion are details about why the
> issues addressed by suspend blockers cannot be solved with runtime PM.

The simplest example is that suspend blockers can be used to control 
whether or not the CPU shuts down, whereas runtime PM can't.

> To me, runtime PM is a generic and flexible approach that can be used
> with any userspace.  Driver writers should not have to care whether
> the system is in "opportunistic" mode or about whether userspace is
> suspend blocker capable.  They should only have to think about when
> the device is (or should be) idle.
> 
> From my experience with OMAP, we *really* do not want to care about
> what userspace is or isn't capable of, or what suspend-mode the kernel
> is in.  Among other things, the OMAP linux kernel is used in the Nokia
> N900 (Maemo), the Motorola Droid (Android) and the Palm Pre (webOS).
> Comments on the future of each SW stack aside, we really want to run
> the same kernel and drivers across all of those platforms as well as
> whatever comes next.

That is indeed a weak point of the proposal.  Kernel drivers' use of
suspend blockers appears to be somewhat arbitrary and directed by the
needs of userspace.  It's not at all clear how drivers can use suspend
blockers in a way that will work on all systems.

Alan Stern
