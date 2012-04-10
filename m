From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Tue, 10 Apr 2012 15:42:33 -0700
Message-ID: <CAJiQ=7A=744EZ1pW0vmpW=+CgdoDBYT0vc-=182Y8eU-3pZqvg@mail.gmail.com>
References: <CAJiQ=7AL24L2-KJ405jOkFutti5QcGfMEzp2rKbcrMY=5TuJzg@mail.gmail.com>
	<Pine.LNX.4.44L0.1204101535090.1605-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204101535090.1605-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 10, 2012 at 12:48 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On my systems, it would take a lot of extra power to maintain the
>> ability to detect device hotplug.  I am wondering if the PCI based
>> controller has a better way of handling it in the hardware than we do,
>> or if the power savings from D3hot are just very small.
>
> PCI devices have two different power wells, one for normal use and one
> for use during suspend.  As far as I know, there is no way to turn off
> power to the auxiliary well short of turning off the entire computer.
> Rafael may have a more complete picture.

That may be the case on PCs, but on many embedded systems (mine
included), entire hardware blocks can be clock-gated or power-gated
without shutting off the rest of the system.

>> > If it does not
>> > involve any such loss then no "user-initiated suspend" should be
>> > needed, because the existing runtime suspend methods will do the job.
>>
>> Right.  Unfortunately I don't really have any devices that work this
>> way.  Most are "all or nothing."
>
> Is the loss of functionality you're talking about essentially the same
> as removing the driver?

>From a hardware perspective, yes.

> I don't think anybody would object to a
> driverless device being put into a non-functional low-power mode, since
> without a driver, it's pretty non-functional anyway.  It's easy for
> userspace to unbind a device from its driver; would that then do what
> you want?

Probably, but it seems a little clunky when we have a "runtime
suspend" framework already in place...

Unbinding/binding the device is slower than suspending it, and might
be a problem if there are mounted filesystems involved.

Going back to the NAS example I mentioned earlier - I would imagine
that merely resuming the USB/SATA controller + HDD when a new request
arrives is going to provide a much faster recovery time than rebinding
+ redetecting + remounting.

(Of course that raises issues like: what if somebody unplugs the
current HDD, then plugs in a different HDD, while the USB/SATA core is
asleep?)

>> >> This is not a very clean way of doing things, so I would prefer to use
>> >> runtime PM if at all possible.  But I don't think my hardware is
>> >> designed in a way that is compatible with "opportunistic suspend."
>> >
>> > In what way is it incompatible?
>>
>> My devices lose functionality when they are put into low-power modes.
>
> What functionality do they lose?

Everything, including register access, PHY links, and hotplug detection.
