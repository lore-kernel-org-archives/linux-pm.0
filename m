From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Sun, 29 Nov 2009 13:26:17 +0100
Message-ID: <87skbx34ba.fsf__33923.8777444281$1259497649$gmane$org@tac.ki.iif.hu>
References: <87y6lxchwf.fsf@tac.ki.iif.hu>
	<20091123172451.GD17813@core.coreip.homeip.net>
	<87tywlcbyr.fsf@tac.ki.iif.hu>
	<20091124063711.GL17675@esdhcp04058.research.nokia.com>
	<87my2cp4h6.fsf@tac.ki.iif.hu>
	<20091124170249.GQ17675@esdhcp04058.research.nokia.com>
	<87k4xfojhb.fsf@tac.ki.iif.hu>
	<20091126063506.GM23244@core.coreip.homeip.net>
	<20091127105408.GV17675@esdhcp04058.research.nokia.com>
	<87tywe4zf3.fsf@tac.ki.iif.hu>
	<20091128132742.GC27249@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091128132742.GC27249@gw.healthdatacare.com> (Mika Westerberg's
	message of "Sat, 28 Nov 2009 15:27:42 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Mika Westerberg <mika.westerberg@iki.fi>, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Mika Westerberg <mika.westerberg@iki.fi> writes:

> On Sat, Nov 28, 2009 at 01:16:48PM +0100, Ferenc Wagner wrote:
>
>> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
>> 
>>> How about if we just add one field to struct gpio_keys_button?
>>> 	...
>>> 	bool can_disable;
>>>
>>> Then gpio_keys uses this field when it decides what irqflags it
>>> is going to pass to request_irq() (we don't allow platform data
>>> to pass exact flags). So in case of can_disable is set, we don't
>>> pass IRQF_SHARED to request_irq().
>>>
>>> When support for sharing single IRQ between multiple buttons arrives
>>> this field is still valid and we just need to take care of disable IRQ
>>> line only when all buttons that share it, are disabled.
>>>
>>> This won't break existing users of gpio_keys and allows future
>>> extension to support case of multiple buttons sharing single
>>> IRQ line, right?
>> 
>> Please don't shoot me, but I've got a different idea: what if we leave
>> this whole business to the generic kernel interrupt handling routines?
>> It would be as easy as requesting the IRQ on device open (I guess the
>> input layer can relay the open event down here) and freeing it on close.
>> The IRQ could stat shared all the time, and the kernel would
>> automatically disable it when all handlers are unregistered.  All this
>> means no need to extend the platform data, no need for a separate sysfs
>> interface, and still the application would have complete control of its
>> wakeup sources by opening/closing them as needed.  What do you think?
>
> Yeah, that would be nice. But it won't work for us :(
>
> This is because the actual input device might be open for several
> applications. Then we have single process which controls state of
> the device. Now if, for example the device is locked by user, this
> process just disables those buttons which are not allowed to wake
> up the device and blanks the screen.
>
> So the input device is still open but we just prevent GPIO lines
> from generating any interrupts while the device is locked. There
> are other use-cases also where different buttons are
> disabled/enabled.

Hi,

I thought we'd better ask our friends over at linux-pm, if they've got
some interface for this task.  To summarize: an embedded application
wants to go into a "locked" state, where some input devices (gpio keys
in this case) are "muted", ie. they don't even generate interrupts to
minimize power consumption.  This could be solved by adding a new
interface to gpio-keys, but the problem seems more general, so I wonder
if something like the USB selective runtime suspend is already available
(or preferable to develop) for such tasks.

(I hope I got the summary right; Mika will provide the missing bits if I
didn't.) 
-- 
Thanks,
Feri.
