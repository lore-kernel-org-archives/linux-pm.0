From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt	handlers
Date: Mon, 11 Apr 2011 19:20:47 +0200
Message-ID: <4DA3386F.8090609@samsung.com>
References: <Pine.LNX.4.44L0.1104111202470.1975-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.1104111202470.1975-100000@iolanthe.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/11/2011 06:08 PM, Alan Stern wrote:
> On Mon, 11 Apr 2011, Sylwester Nawrocki wrote:
> 
>>> +  void pm_runtime_irq_safe(struct device *dev);
>>> +    - set the power.irq_safe flag for the device, causing the runtime-PM
>>> +      callbacks to be invoked with interrupts disabled
>>> +
>>>    void pm_runtime_mark_last_busy(struct device *dev);
>>>      - set the power.last_busy field to the current time
>>>  
>>> @@ -438,6 +454,16 @@ pm_runtime_suspended()
>>>  pm_runtime_mark_last_busy()
>>>  pm_runtime_autosuspend_expiration()
>>>  
>>> +If pm_runtime_irq_safe() has been called for a device then the following helper
>>> +functions may also be called in interrupt context:
>>
>> I was wondering what is the proper usage of this API. From a point of view of
>> a driver, does it mean that in runtime_resume/runtime_suspend helpers any
>> blocking calls cannot be used, so the device driver is prepared for situations
>> when some other subsystem invokes pm_runtime_irq_safe() on its device?
> 
> I should have mentioned this in the documentation.  Yes, if 
> pm_runtime_irq_safe() has been called for a device then that device's 
> runtime_resume and runtime_suspend helpers must be able to run in 
> interrupt context.  Hence they must not make any blocking calls.
> 
> However, this doesn't mean _all_ runtime_resume/runtime_suspend methods 
> have to be IRQ-safe.  Only those for which pm_runtime_irq_safe() has 
> been called.

Thank you for the clarification.

OK, my main concerns was, who decides whether the specific runtime PM
helpers are IRQ-safe or not. But indeed, it now makes a little sense
to me to impose such a requirement on all runtime_suspend/resume helpers.

> 
> A driver shouldn't worry about some other subsystem calling
> pm_runtime_irq_safe() for one of its devices.  If that ever happened,
> it would be a gross violation of proper layering.

Ok, that's good news.

> 
>> Or is pm_runtime_irq_safe() intended to be called only by the device driver
>> in such case?
> 
> Yes, that's right.
> 
>> I'd like to use blocking calls for a voltage regulator control within
>> the runtime PM helpers in the driver but I'm not sure whether this wouldn't
>> violate the API.
> 
> You should be okay.  Just bear in mind that it means the voltage 
> regulator's parent won't be able to runtime suspend.  If the regulator 
> is a platform device with no meaningful parent then of course this 
> won't matter.

The regulator driver is a PMIC that uses I2C communication to control
the voltage regulators. So to be able to control the regulator supplying
the device, the runtime_resume/suspend callbacks need to be called with 
interrupts enabled. Otherwise the I2C communication wouldn't work.

I don't really need runtime_suspend/resume to be IRQ-safe, just wanted 
to make sure that in some conditions some other subsystem does not request that.

As I have seen there is no runtime PM call to clear the power.irq_safe
flags once it is set, so it looked like pm_runtime_irq_safe() is a basically 
a "one-time" call.


Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
