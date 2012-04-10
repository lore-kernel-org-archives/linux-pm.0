From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Tue, 10 Apr 2012 12:21:08 -0700
Message-ID: <CAJiQ=7AL24L2-KJ405jOkFutti5QcGfMEzp2rKbcrMY=5TuJzg@mail.gmail.com>
References: <CAJiQ=7CVzOpRdKWMzLwtYznjOno-GQjOZ8Jm7EiEzs9icWwnHw@mail.gmail.com>
	<Pine.LNX.4.44L0.1204100949390.1605-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204100949390.1605-100000@iolanthe.rowland.org>
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

On Tue, Apr 10, 2012 at 7:15 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> I am not clear on what is actually happening at the chip level in these cases?
>>
>> i.e. is the entire USB core getting clock gated or power gated, such
>> that it is completely non-responsive to register accesses or device
>> hotplug?  Or is the driver just shutting down a few tiny pieces of the
>> hardware?
>
> The entire controller goes into a low-power mode.  For example, a PCI
> controller would go into D3hot.  The hardware is no longer responsive
> to register accesses, but it can generate a wakeup signal in response
> to device hotplug.

Do you have any estimates of power savings on the host controller side?

On my systems, it would take a lot of extra power to maintain the
ability to detect device hotplug.  I am wondering if the PCI based
controller has a better way of handling it in the hardware than we do,
or if the power savings from D3hot are just very small.

>> Is there a way to initiate USB runtime suspend on the host controller
>> even if there are devices plugged into the downstream ports?
>
> Yes, provided all those devices are themselves already suspended.

But a lot of the drivers for USB devices do not even support suspend,
correct?  And many of them become unreliable if you turn it on?

What if I just want to forcibly suspend the entire USB subsystem?

>> >>  In general I don't
>> >> see any facility where the application can explicitly tell the PM core
>> >> to suspend a device (incurring a potential loss of functionality, such
>> >> as hot plug/unplug detection).
>> >
>> > Right; there is no way to do this.  The OS will suspend a device only
>> > when it believes it is safe to do so.
>>
>> Assuming that somebody is able to come up with a satisfactory
>> implementation, are you open to allowing a "user-initiated suspend"
>> mode, in addition to "opportunistic suspend"?
>
> I'm not sure what you are asking.  If "use-initiated suspend"
> involves loss of functionality (such as loss of hotplug/unplug
> detection) then no, it is generally not acceptable -- although the
> final decision rests with the subsystem's maintainer.

Who is the right person to make the call?  Rafael?

> If it does not
> involve any such loss then no "user-initiated suspend" should be
> needed, because the existing runtime suspend methods will do the job.

Right.  Unfortunately I don't really have any devices that work this
way.  Most are "all or nothing."

>> rmmod allows me to forcibly shut down the controller, cleanly (in
>> theory) disconnecting any active devices and preventing the kernel
>> from touching the registers.
>>
>> After rmmod, I can then tell the SoC to put the whole core into an
>> unresponsive, low power state.
>>
>> This is not a very clean way of doing things, so I would prefer to use
>> runtime PM if at all possible.  But I don't think my hardware is
>> designed in a way that is compatible with "opportunistic suspend."
>
> In what way is it incompatible?

My devices lose functionality when they are put into low-power modes.
