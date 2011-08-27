From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: Issue: Runtime API usage in wake-up device
 irq_handler during wakeup from system-wide-suspend.
Date: Sat, 27 Aug 2011 20:19:30 +0530
Message-ID: <4E5903FA.5050101__12495.0725156397$1314456648$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1108270958320.17264-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1108270958320.17264-100000@netrider.rowland.org>
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
Cc: Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 27 August 2011 07:31 PM, Alan Stern wrote:
> On Sat, 27 Aug 2011, Santosh wrote:
>
>> I might be wrong here, but after discussion with Govindraj on this
>> issue, it seems there is a flaw in the way OMAP chain handler
>> handling the child interrupts.
>>
>> On OMAP, we have special interrupt wakeup source at PRCM level and
>> many devices can trigger wakeup from low power via this common
>> interrupt source. The common interrupt source upon wakeup from low
>> power state, decodes the source of interrupt and based on that
>> source, calls the respective device ISR directly.
>>
>> The issue I see here is, the ISR on _a_ device (UART in this case)
>> is happening even before UART resume and DPM resume has been completed.
>> If this is the case, then it is surely asking for trouble. Because not
>> just clocks, but even driver state machine is already in suspend state
>> when the ISR is called.
>
> If the driver state machine is in the suspend state when the ISR is
> called, then the ISR should realize it is handling a wakeup event
> instead of a normal I/O event.  All it needs to do is turn off the
> interrupt source; the event itself will be taken care of during the
> device's resume callback.
>
Good point but the ISR is called as a function call and not real
hardware event so no need to turn-off the source in the child
ISR. Parent ISR will clear the source anyways.

But the intention here is to record the event for the child.
I mean for UART wakeup, the received character should be
extracted. If not done, UART will loose that character because
the event is lost. So not sure how the event will be taken
care during resume callback. Could you elaborate bit more on
last comment please?

Regards
Santosh
