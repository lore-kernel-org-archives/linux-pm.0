From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 21:20:32 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912062110240.3560__10745.1393305839$1260163297$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 6 Dec 2009, Alan Stern wrote:
> 
> That's ridiculous.  Having gone to all the trouble of building a device
> tree, one which is presumably still almost entirely correct, why go to
> all the trouble of tearing it down only to rebuild it again?  (Note:
> I'm talking about resume-from-RAM here, not resume-from-hibernation.)

Hey, I can believe that it's worth keeping the USB device tree, and just 
validating it instead. However:

> If I understand correctly, what you're suggesting is impractical.  You
> would have each driver responsible for resuming the devices it
> registers.

The thing is, for 99% of all devices, we really _really_ don't care. 
Especially PCI devices. 

Your average laptop will have something like ten PCI devices on it, and 
99% of those have no delays at all outside of the millisecond-level ones 
that it takes for power management register writes etc to take place.

So what I'm suggesting is to NOT DO ANY ASYNC RESUME AT ALL by default. 
Because async device management is _hard_, and results in various nasty 
ordering problems that are timing-dependent etc. And it's totally 
pointless for almost all cases.

This is why I think it is so crazy to try to create those idiotic "this 
device depends on that other" lists etc - it's adding serious conceptual 
complexity for something that nobody cares about, and that just allows for 
non-deterministic behavior that we don't even want.

> So consider this suggestion: Let's define PM groups.

Let's not.

I can imagine that doing USB resume specially is worth it, since USB is 
fundamentally a pretty slow bus. But USB is also a fairly clear hierarchy, 
so there is no point in PM groups or any other information outside of the 
pure topology.

But there is absolutely zero point in doing that for devices in general. 
PCI drivers simply do not want concurrent initialization. The upsides are 
basically zero (win a few msecs?) and the downsides are the pointless 
complexity. We don't do PCI discovery asyncronously either - for all the 
same reasons.

Now, a PCI driver may then implement a bus that is slow (ie SCSI, ATA, 
USB), and that bus may itself then want to do something else. If it really 
is a good idea to add the whole hierarchical model to USB suspend/resume, 
I can live with that, but that is absolutely no excuse for then doing it 
for cases where the hierarchy is (a) known to be broken (ie the whole PCI 
multifunction thing, but also things like motherboard power management 
devices) and (b) don't have the same kind of slow bus issues.

				Linus
