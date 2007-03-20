From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Tue, 20 Mar 2007 16:44:58 -0700
Message-ID: <200703201644.59046.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320102551.GB19283@elf.ucw.cz>
	<1174388812.3770.29.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174388812.3770.29.camel@johannes.berg>
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
To: linux-pm@lists.linux-foundation.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 4:06 am, Johannes Berg wrote:
> Almost all users of pm_ops only support mem sleep, don't check in .valid
> and don't reject any others in .prepare so users can be confused if they
> check /sys/power/state, especially when new states are ever added.

By the way ... as a note to implementors, it should be trivial to
implement a basic "standby" state that suspends drivers, disables
many clocks, and probably puts DRAM into self-refresh mode, but
uses only the wait-for-interrupt CPU lowpower mode.

A key difference between that and STR would then be that STR does
extra magic, like switching the CPU to a slow clock and then turning
off all the clocks that drive the chip "fast".  Also, that because
it disables so many clocks, the SOC probably can't support as many
types of wakeup events in STR.


I mention this because implementing such a "standby" mode means
that all the platform drivers can start to make their suspend()
and resume() code behave, and userspace tools can be put into
place, before all that tricky/painful STR work gets done.  Also,
because driver wakeup events in such a "standby" mode tend to be
a lot more powerful ... pretty much how a driver using runtime
PM models would work (instead of user-visible "goto sleep").

That is, support for such a "standby" mode is the easiest way
to seed all the PM work on a given platform.  Even though it
doesn't save as much power, it's a useful step towards deeper
power saving modes.

And thus endeth the lesson for today.  I look forward to seeing
a lot more platforms supporting at least minimal PM, now.  ;)

- Dave



 =
