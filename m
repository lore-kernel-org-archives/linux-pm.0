From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Tue, 14 May 2019 10:04:22 +0200
Message-ID: <CAJZ5v0g3cCYK3rAQn09pCr7LMrRr=zQy_ceaEB5AKhVx604YgA@mail.gmail.com>
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de> <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain> <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
 <20190513150458.GA15437@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513150458.GA15437@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <kbusch@kernel.org>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 5:10 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, May 13, 2019 at 03:05:42PM +0000, Mario.Limonciello@dell.com wrote:
> > This system power state - suspend to idle is going to freeze threads.
> > But we're talking a multi threaded kernel.  Can't there be a timing problem going
> > on then too?  With a disk flush being active in one task and the other task trying
> > to put the disk into the deepest power state.  If you don't freeze the queues how
> > can you guarantee that didn't happen?
>
> But if an active data flush task is running, then we're not idle and
> shouldn't go to low power.

To be entirely precise, system suspend prevents user space from
running while it is in progress.  It doesn't do that to kernel
threads, at least not by default, though, so if there is a kernel
thread flushing the data, it needs to be stopped or suspended somehow
directly in the system suspend path.  [And yes, system suspend (or
hibernation) may take place at any time so long as all user space can
be prevented from running then (by means of the tasks freezer).]

However, freezing the queues from a driver ->suspend callback doesn't
help in general and the reason why is hibernation.  Roughly speaking,
hibernation works in two steps, the first of which creates a snapshot
image of system memory and the second one writes that image to
persistent storage.  Devices are resumed between the two steps in
order to make it possible to do the write, but that would unfreeze the
queues and let the data flusher run.  If it runs, it may cause the
memory snapshot image that has just been created to become outdated
and restoring the system memory contents from that image going forward
may cause corruption to occur.

Thus freezing the queues from a driver ->suspend callback should not
be relied on for correctness if the same callback is used for system
suspend and hibernation, which is the case here.  If doing that
prevents the system from crashing, it is critical to find out why IMO,
as that may very well indicate a broader issue, not necessarily in the
driver itself.

But note that even if the device turns out to behave oddly, it still
needs to be handled, unless it may be prevented from shipping to users
in that shape.  If it ships, users will face the odd behavior anyway.
