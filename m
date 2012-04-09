From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Mon, 9 Apr 2012 14:14:57 -0700
Message-ID: <CAJiQ=7CVzOpRdKWMzLwtYznjOno-GQjOZ8Jm7EiEzs9icWwnHw@mail.gmail.com>
References: <CAJiQ=7D8QbV45euE1VN0ENpCMUESMMgeUr6gKwK3g+8-PUyTcQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1204091007350.1429-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204091007350.1429-100000@iolanthe.rowland.org>
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

On Mon, Apr 9, 2012 at 7:14 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> USB runtime PM seems to focus on the individual USB devices, and does
>> not allow for dynamically suspending the entire host controller
>> AFAICT.
>
> That is not correct.  USB host controllers _can_ be suspended.  (Not
> all of them; many of the platform drivers don't implement controller
> suspend.  But some of them do, and almost all of the PCI-based drivers
> do.)

I am not clear on what is actually happening at the chip level in these cases?

i.e. is the entire USB core getting clock gated or power gated, such
that it is completely non-responsive to register accesses or device
hotplug?  Or is the driver just shutting down a few tiny pieces of the
hardware?

Is there a way to initiate USB runtime suspend on the host controller
even if there are devices plugged into the downstream ports?

>>  In general I don't
>> see any facility where the application can explicitly tell the PM core
>> to suspend a device (incurring a potential loss of functionality, such
>> as hot plug/unplug detection).
>
> Right; there is no way to do this.  The OS will suspend a device only
> when it believes it is safe to do so.

Assuming that somebody is able to come up with a satisfactory
implementation, are you open to allowing a "user-initiated suspend"
mode, in addition to "opportunistic suspend"?

>> d) Or should I just go back to using "rmmod"?
>
> I don't see how rmmod will save any power.

rmmod allows me to forcibly shut down the controller, cleanly (in
theory) disconnecting any active devices and preventing the kernel
from touching the registers.

After rmmod, I can then tell the SoC to put the whole core into an
unresponsive, low power state.

This is not a very clean way of doing things, so I would prefer to use
runtime PM if at all possible.  But I don't think my hardware is
designed in a way that is compatible with "opportunistic suspend."


Thanks.
