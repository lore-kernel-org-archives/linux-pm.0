From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Thu, 17 Dec 2009 15:06:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912171444040.2645-100000__6260.55960678986$1261080560$gmane$org@iolanthe.rowland.org>
References: <200912170249.00676.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912170249.00676.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Dec 2009, Rafael J. Wysocki wrote:

> That actually is correct.  On the nx6325 suspend is totally dominated by disk
> spindown, almost everything else is negligible compared to it (well, except for
> the audio), so we can't go down below 1 s during suspend on this box.
> 
> On the Wind, disk spindown time is comparable with serio suspend time,
> so at least in principle we should be able to get .5 s suspend on this box - 
> if the disk spindown in async.
> 
> In turn, the resume on the Wind is dominated by disk spinup, so we can't
> go below 1.5 s on this box during resume (notice that the "async+extra"
> approach brings us close to this limit, although we could save .5 s more in
> principle by making more devices async).
> 
> Resume on the nx6325 is a different story, though, as it is dominated by USB
> and PCI devices, so marking those as async would probably bring us close to
> the limit.

The implications seem pretty clear.  If the following sorts of devices
were async:

	USB (devices and interfaces), PCI, serio, SCSI (hosts, targets,
	devices)

then we would reap close to the maximum benefit -- providing:

	async threads are started in a first pass without waiting
	for synchronous devices, and

It's not clear that making all these types of devices async will really 
work, but it's worth testing.

Alan Stern
