From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / sleep: fix unbalanced pm runtime disable in
 __device_suspend_late()
Date: Thu, 19 May 2016 20:11:34 +0300
Message-ID: <573DF3C6.7080503@ti.com>
References: <1463162628-16976-1-git-send-email-grygorii.strashko@ti.com>
 <CAJZ5v0ja-poNq0J+giAJJb+pPFyGg1a7rUcUfFyhcn9qPnaieQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ja-poNq0J+giAJJb+pPFyGg1a7rUcUfFyhcn9qPnaieQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/19/2016 04:38 PM, Rafael J. Wysocki wrote:
> On Fri, May 13, 2016 at 8:03 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> The PM runtime will be left disabled for the device if its .suspend_late()
>> callback fails and async suspend is not allowed for this device. In
>> this case device will not be added in dpm_late_early_list and
>> dpm_resume_early() will ignore this device, as result PM runtime will
>> be disabled for it forever (side effect: after 8 subsequent failures
>> for the same device the PM runtime will be reenabled due to
>> disable_depth overflow).
>>
>> Hence, re-enable PM runtime in __device_suspend_late() if
>> .suspend_late() callback fails and async suspend is not allowed for
>> this device.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/base/power/main.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 6e7c3cc..9b266e5 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1207,10 +1207,13 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>>          }
>>
>>          error = dpm_run_callback(callback, dev, state, info);
>> -       if (!error)
>> +       if (!error) {
>>                  dev->power.is_late_suspended = true;
>> -       else
>> +       } else {
		Point [1]
>>                  async_error = error;
>> +               if (!is_async(dev))
> 
> Why is the is_async() check necessary here?
			
A: deviceX is suspended *async* and reached point [1], in this case:
- deviceX has been added in dpm_late_early_list already
- dpm_suspend_late() will detect async_error and call dpm_resume_early()
- dpm_resume_early() will call device_resume_early() for deviceX
- device_resume_early() will re-enable PM runtime
{
...
	if (!dev->power.is_late_suspended)
		goto Out;

	...
 Out:
	TRACE_RESUME(error);

	pm_runtime_enable(dev);
^^^^^^^^^^^^
	complete_all(&dev->power.completion);
	return error;
}	
	

B: deviceX is suspended *sync* and reached point [1], in this case:
- deviceX has not been added in dpm_late_early_list yet
- dpm_suspend_late() will detect sync_error and call dpm_resume_early()
- dpm_resume_early() will ignore deviceX

if i'll not check for !is_async(dev) then pm_runtime_enable(dev)
will be called twice for deviceX with this patch.

> 
>> +                       pm_runtime_enable(dev);
>> +       }
>>
>>   Complete:
>>          TRACE_SUSPEND(error);
>> --


-- 
regards,
-grygorii
