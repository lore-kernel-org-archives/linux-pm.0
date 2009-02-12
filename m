From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state	interface
Date: Thu, 12 Feb 2009 11:16:01 +0000
Message-ID: <20090212111600.GA28176@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902072337.40046.rjw@sisk.pl>
	<20090208103355.GC14143@elf.ucw.cz>
	<200902081450.46584.rjw@sisk.pl>
	<20090208140404.GA22084@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090208140404.GA22084@bulgaria.corp.google.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 08, 2009 at 06:04:04AM -0800, Brian Swetland wrote:

> Being in suspend, where periodic user and kernel timers aren't running,
> and random userspace threads aren't possibly spinning, rather than just 
> being in idle in the lowest power possible state, represent a pretty 
> significant power savings.

Nokia have produced a Linux-based device that runs off a phone battery 
and has roughly a week of standby time without entering an explicit 
suspend state at any time, so dealing with this is clearly possible. 
What we need is to ensure that driver interfaces allow the kernel to 
know when a given piece of hardware is required and place it in an 
appropriate power state - the USB autosuspend code is probably the best 
kernelwide example of this right now.

Part of the reason you're getting pushback is that your solution to the 
problem of shutting down unused hardware is tied to embedded-style 
systems with very low resume latencies. You can afford to handle the 
problem by entering an explicit suspend state. In the x86 mobile world, 
we don't have that option. It's simply too slow and disruptive to the 
user experience. As a consequence we're far more interested in hardware 
power management that doesn't require an explicit system-wide suspend.

A solution that's focused on powering down as much unused hardware as 
possible regardless of the system state benefits the x86 world as well 
as the embedded world, so I think there's a fairly strong argument that 
it's a better solution than one requiring an explicit system state 
change. Arve mentioned that your hardware enters the same power state in 
idle as in suspend, so the only real difference here is that in the 
"better" solution you're inferring that the hardware is idle based on 
the demands of userspace rather than explicitly shutting it down.

At least, from the kernel side. The userspace side is more awkward - as 
Pavel suggested you could obtain a pretty similar outcome by just 
sending SIGSTOP to pretty much everything, which is kind of ugly but 
would probably work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
