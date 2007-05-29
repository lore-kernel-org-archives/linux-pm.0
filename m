From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Tue, 29 May 2007 13:09:47 -0700
Message-ID: <200705291309.47559.david-b__31453.3209814273$1180470307$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0705281719200.10323-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705281719200.10323-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday 28 May 2007, Alan Stern wrote:

> This is a matter of one's philosophy.  In suspend-to-RAM, should tasks
> be frozen or should I/O queues be frozen?
> 
> With the USB subsystem I have followed the approach taken by the PM
> core, which is that tasks are frozen.  But one can -- and Linus has on
> at least one occasion -- make a good case that tasks should be left
> running while only I/O is frozen. 

In fact that makes a heck of a lot more sense to me from the
conceptual point of view.  From the hardware perspective, the
task of preparing to enter true suspend states (STR, or suspend
for ACPI; embedded systems have more options) focusses on what
I/O signals are disabled.

Once the relevant I/O signals are first idled, then disabled,
the CPU can do whatever it likes.  Whether it runs or not is
purely a workload decision...

Remember too that not all systems suffer from the constraints
that ACPI decrees.  In particular, it's not uncommon that some
parts of the system be active in certain suspend states.  The
whole point is to turn off as much of the system as possible,
especially the high power portions, while letting work proceed.

Turning off some clocks and peripherals doesn't need to imply
turning them all off, or disabling DMA ... and should not need
to be triggered by a user (or userspace tool) explicitly saying
"go into STR".


> This would require the subsystem to 
> distinguish between a selective device suspend and a system-wide
> suspend-to-RAM, so that selective resume could be enabled on demand in
> one case but not the other.

Exactly.  "Selective suspend" of parts of the system is a far
more general model.  It fits well with runtime power management,
degrades smoothly to states where memory goes into self-refresh
(maybe the system idle loop when NO_HZ is being effective) or
even hibernation (as discussed elsewhere).

- Dave

> It's quite doable in principle -- it's just not the technique I used.
> 
> Alan Stern
> 
>
