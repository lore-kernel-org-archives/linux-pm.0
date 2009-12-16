From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 22:57:00 +0100
Message-ID: <200912162257.00771.rjw__43269.2773444161$1261000660$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912162027.16574.rjw@sisk.pl>
	<alpine.LFD.2.00.0912161255080.3556@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912161255080.3556@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 16 December 2009, Linus Torvalds wrote:
> 
> On Wed, 16 Dec 2009, Rafael J. Wysocki wrote:
> > > 
> > > Do you have any sample timing output with devices listed?
> > 
> > I'm going to generate one shortly.

I've just put the first set of data, for the HP nx6325 at:
http://www.sisk.pl/kernel/data/nx6325/
 
The *-dmesg.log files contain full dmesg outputs starting from a cold boot and
including one suspend-resume cycle in each case, with debug_initcall enabled.

The *-suspend.log files are excerpts from the *-dmesg.log files containing
the suspend messages only, and analogously for *-resume.log.

The *-times.txt files contain suspend/resume time for every device sorted
in the decreasing order.

> From my bootup timings, I have this memory of SATA link bringup being 
> noticeable. I wonder if that is the case on resume too...

There's no SATA in the nx6325, only IDE, so we'd need to wait for the Wind data
(in the works).

The slowest suspending device in the nx6325 is the audio chip (surprise,
surprise), it takes ~220 ms alone.  Then - serio, but since i8042 was not
async, the async suspend of serio didn't really help (another ~140 ms).
Then network, FireWire, MMC, USB, SD host (~15 ms each).  [I think we can
help suspend a bit by making i8042 async, although I'm not sure that's going
to be safe.]

The slowest resuming are USB (by far) and then CardBus, audio, USB controllers,
FireWire, network and IDE (but that only takes about 7 ms).

But the main problem with async resume is that the USB devices are at the
beginning of dpm_list, so the resume of them is not even started until _all_ of
the slow devices behind them are woken up.  That's why the extra patch helps so
much IMO.

Rafael
