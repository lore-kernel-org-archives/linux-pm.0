From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
	suspending devices
Date: Mon, 25 Jan 2010 22:37:42 +0100
Message-ID: <201001252237.42545.rjw__19642.0599161231$1264455473$gmane$org@sisk.pl>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201001222148.23945.rjw@sisk.pl>
	<alpine.LFD.2.00.1001251601440.2100@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1001251601440.2100@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 25 January 2010, Sebastian Ott wrote:
> Hi.
> 
> On Fri, 22 Jan 2010, Rafael J. Wysocki wrote:
> 
> > On Friday 22 January 2010, Sebastian Ott wrote:
> > > 
> > > a possible fix would be to call disable_nonboot_cpus before suspending the
> > > devices..
> > 
> > This is going against the changes attempting to speed-up suspend and resume,
> > such as the asynchronous suspend/resume patchset, so I don't agree with it.
> 
> Isn't the main benefit for this scenario that while a driver starts io and
> waits for interrupts, the callback for the next device can be called? And
> this can be done with one cpu as well.

That's the basic idea, but the additional CPUs help quite a bit.

> > The real solution would be to remove the memory allocations from the
> > _cpu_down() call path.
> 
> So you have to also ban allocations from all registered notifiers at the
> cpu_chain. And since enable_nonboot_cpus is called before the devices are
> woken up, the same would be true for _cpu_up() which may not be done
> easily.

That's correct.  BTW, that's what the CPU_TASKS_FROZEN bit is for among other
things (perhaps it may be used to fix this particular issue).

> > BTW, this is one of the cases I and Ben are talking about where it's not
> > practical to rework the code just to avoid memory allocation problems during
> > suspend/resume.
> 
> Ok. All i'm saying is that in hibernation_snapshot/create_image memory
> allocations are directely triggered after all devices were put to sleep /
> before woken up - and this looks like a bug.

I agree, but that's because people don't remember that CPU hotplug is also
used for suspend/hibernation.  I don't know at the moment how much effort
it would take to fix all of these problems appropriately, but I _guess_ that
would be quite some work.  That, among other things, is why I sent the patch
to modify gfp_allowed_mask before suspending devices.

> For the driver case - what about using your patch to not modify the gfp
> mask but print a warning instead so that these drivers can be identified
> and fixed.

We'd get a lot of warnings and there are cases where we know they would
trigger (eg. ACPI internals).  So, I'd rather like to reduce the users' pain
(by changing gfp_allowed_mask) than add to it (by adding a warning that's
guaranteed to show up).

Rafael
