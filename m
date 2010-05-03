From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 03 May 2010 11:17:52 -0700
Message-ID: <87vdb4zw6n.fsf__38574.1621991203$1272910732$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1005031301400.1651-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005031301400.1651-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon\,
	3 May 2010 13\:12\:02 -0400 \(EDT\)")
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Oleg Nesterov <oleg@redhat.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 3 May 2010, Kevin Hilman wrote:
>
>> Suspend blockers vs runtime PM
>> ------------------------------
>> 
>> My primary concern is that suspend blockers attempt to address the
>> same problem(s) as runtime PM, but with a very different approach.
>> Suspend blockers use one very large hammer whereas runtime PM hands
>> out many little hammers.  Since I believe power management to be a
>> problem of many little nails, I think many little hammers are better
>> suited for the job.
>
> There is a major difference between suspend blockers and runtime PM 
> which was not discussed in your email.  Namely: Runtime PM is aimed at 
> suspending individual devices and not the system as a whole (in 
> particular, not CPUs), whereas suspend blockers are aimed at suspending 
> -- or more accurately, blocking suspends -- of the system as a whole 
> and not individual devices.
>
> So for example, runtime PM cannot be used to put the system into an S3 
> sleep state.  But suspend blockers _are_ used to keep the system from 
> going into S3.

Good point.  However, adding CPUidle to runtime PM you indeed achieve
a dynamic PM that affects the whole system. 

The main difference then comes down to what prevents system-wide
low-power state: activity vs. suspend blocker held.

>> Currently in the kernel, we have two main forms of PM
>> 
>> - static PM (system PM, traditional suspend/resume etc.)
>> - dynamic PM (runtime PM, CPUfreq, CPUidle, etc.)
>> 
>> And with the addition of suspend blockers we have something in
>> between.  In my simple world, I think of suspend_blockers as static PM
>> with a retrofit of some basic dynamic capabilities.  In my view, a
>> poor man's dynamic PM.
>
> I wouldn't describe it like that.  Consider dividing PM along a 
> different axis:
>
> - entire system (ACPI sleep states, CPUs turned off, etc.)
> - single, independent devices (e.g., USB autosuspend)
>
> Then system PM combines static + entire, whereas runtime PM combines 
> dynamic + single.  By contrast, suspend blockers are aimed at the 
> dynamic + entire combination.  This makes them different from anything 
> already present in the kernel.

Adding CPUidle to runtime PM (dynamic + single), you add 'entire' as
well, as CPUidle manages the CPU states.

However, one problem I have with your proposed division is it doesn't
seem to match well to the hardware available on modern embedded SoCs,
mainly because these are not ACPI devices.  The CPU is just another
"independent" device whose runtime PM is managed by CPUidle.

IOW, The 'entire system' state is just a function of the CPU state
and the state of all the on- and off-chip devices.  With CPUidle
managing the CPUs, and runtime PM managing the rest of the devices,
you have a fully flexible dynamic PM for the entire system.

>> The current design of suspend blockers was (presumably) taken due to
>> major limitations and/or problems in dynamic PM when it was designed.
>> However, since then, some very signifcant improvements in dynamic PM
>> have come along, particularily in the form of runtime PM.  What I
>> still feel is missing from this discussion are details about why the
>> issues addressed by suspend blockers cannot be solved with runtime PM.
>
> The simplest example is that suspend blockers can be used to control 
> whether or not the CPU shuts down, whereas runtime PM can't.

True, by iteslf, runtime PM does not shut down CPUs, but in
combination with CPUidle the CPU(s) can be shut down based on
activity.  In a way, you could think of CPUidle as runtime PM for the
CPU(s).

Again, the primary difference comes down to: why should I not enter a
low-power state?  activity (runtime PM + CPUidle) or suspend blocker.

>> To me, runtime PM is a generic and flexible approach that can be used
>> with any userspace.  Driver writers should not have to care whether
>> the system is in "opportunistic" mode or about whether userspace is
>> suspend blocker capable.  They should only have to think about when
>> the device is (or should be) idle.
>> 
>> From my experience with OMAP, we *really* do not want to care about
>> what userspace is or isn't capable of, or what suspend-mode the kernel
>> is in.  Among other things, the OMAP linux kernel is used in the Nokia
>> N900 (Maemo), the Motorola Droid (Android) and the Palm Pre (webOS).
>> Comments on the future of each SW stack aside, we really want to run
>> the same kernel and drivers across all of those platforms as well as
>> whatever comes next.
>
> That is indeed a weak point of the proposal.  Kernel drivers' use of
> suspend blockers appears to be somewhat arbitrary and directed by the
> needs of userspace.  It's not at all clear how drivers can use suspend
> blockers in a way that will work on all systems.

Nor is it clear (to me) what drivers would/should look like that would
need to do suspend blockers in addition to runtime PM.  

Kevin
