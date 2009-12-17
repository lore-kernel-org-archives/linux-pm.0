From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Thu, 17 Dec 2009 21:36:36 +0100
Message-ID: <200912172136.36277.rjw__30153.4131904647$1261082225$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912171444040.2645-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912171444040.2645-100000@iolanthe.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 17 December 2009, Alan Stern wrote:
> On Thu, 17 Dec 2009, Rafael J. Wysocki wrote:
> 
> > That actually is correct.  On the nx6325 suspend is totally dominated by disk
> > spindown, almost everything else is negligible compared to it (well, except for
> > the audio), so we can't go down below 1 s during suspend on this box.
> > 
> > On the Wind, disk spindown time is comparable with serio suspend time,
> > so at least in principle we should be able to get .5 s suspend on this box - 
> > if the disk spindown in async.
> > 
> > In turn, the resume on the Wind is dominated by disk spinup, so we can't
> > go below 1.5 s on this box during resume (notice that the "async+extra"
> > approach brings us close to this limit, although we could save .5 s more in
> > principle by making more devices async).
> > 
> > Resume on the nx6325 is a different story, though, as it is dominated by USB
> > and PCI devices, so marking those as async would probably bring us close to
> > the limit.
> 
> The implications seem pretty clear.  If the following sorts of devices
> were async:
> 
> 	USB (devices and interfaces), PCI, serio, SCSI (hosts, targets,
> 	devices)

Plus ACPI battery.

> then we would reap close to the maximum benefit -- providing:
> 
> 	async threads are started in a first pass without waiting
> 	for synchronous devices, and

Agreed.
 
> It's not clear that making all these types of devices async will really 
> work, but it's worth testing.

I'm working on it.

Rafael
