From: Kenneth Heitke <kheitke@codeaurora.org>
Subject: Re: Question about expected behavior when PM runtime is
 disabled
Date: Mon, 13 Jun 2011 12:42:18 -0600
Message-ID: <4DF65A0A.5030309@codeaurora.org>
References: <Pine.LNX.4.44L0.1106111204500.3439-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106111204500.3439-100000@netrider.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan,

Thanks for taking the time to answer my questions.  See inline for 
additional comments.


On 06/11/2011 10:12 AM, Alan Stern wrote:
> On Fri, 10 Jun 2011, Kenneth Heitke wrote:
>
>> Hi Rafael,
>>
>> Sorry if this question has been raised before.  I actually have two
>> questions here.  These questions are related to PM runtime being
>> disabled at runtime (i.e. call to pm_runtime_disable() )
>>
>> If I call pm_runtime_enabled() to first determine if PM runtime is
>> enabled followed conditionally by a call to pm_runtime_get_sync(), it
>> would be possible for PM runtime to be disabled between these two calls
>> and the get_sync() will fail.  Is there any reason to even use the
>> enabled() call?
>
> As a general rule, a device won't be enabled or disabled for runtime PM
> unless its driver or subsystem enables or disables it.  Since you
> should already know what the driver and subsystem are doing, there
> usually isn't any reason for using pm_runtime_enabled().
>
>>   My goal here was to use the enabled() call to determine
>> if PM runtime was configured/enabled in the kernel and then to manage my
>> resources, clocks etc, in a different way if PM runtime is not present.
>
> If runtime PM isn't present, why do you want to manage your clocks etc.
> at all?  The fact that it's not in the kernel means the system manager
> doesn't care about power usage.

I am trying to be backwards compatible.  There is likely a period of 
time from when the runtime PM feature was added to when it was turned on 
by default.  If the feature happens to be disabled, I think it makes 
sense for the driver to still do what it can to manage its resources. 
The power guys aren't going to let me off the hook that easily :)

  >> My second question then is what if PM runtime is enabled in the kernel
>> and then gets disabled at runtime.  What is the expected behavior for a
>> driver?  Should it fail all requests with EGAIN until PM runtime is
>> enabled again? (in suspend state, PM runtime gets disable, new i/o
>> request is made, power and clocks need to be turned on).
>
> It's up to the driver and the subsystem, since they are the entities
> that are responsible for disabling runtime PM.  If you think disabling
> runtime PM will cause problems, then don't do it.

I'm thinking about within runtime PM itself.  I believe during system 
suspend, disable() followed by enable() can be called.  If that happens, 
are there any scenarios that I need to be concerned about?  Can my 
autosuspend timer just happen to fire during that window between disable 
and enable resulting in a failure to suspend?  My driver is part of the 
i2c subsystem, do I know for a fact that disable() won't be used?

>
>> What about delayed autosuspend?  I believe that if PM runtime is
>> disabled while there is a delayed autosuspend pending, the suspend will
>> fail without notification (clocks and power will be left on).
>
> That's right.
>
>>   Will PM
>> runtime still be in the idle state once PM runtime is re-enabled?
>
> The device will be in the same state as it was when it was disabled,
> unless you explicitly call pm_runtime_set_active() or
> pm_runtime_set_suspended().
>
> Alan Stern
>
>

thanks,
Ken


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
