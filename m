From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume when
 RT suspended
Date: Mon, 24 Apr 2017 17:27:34 +0300
Message-ID: <6493e93c-57e1-c378-7a91-7fc4a9a61acf@linux.intel.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
 <CAJZ5v0hiGSS+bZWwzz7XgjFr8ckARn9ehaO9q1-76qo4d-76tg@mail.gmail.com>
 <2a548d9c-fb05-977d-c063-3b481a191a41@linux.intel.com>
 <CAJZ5v0jwZeTy=fNdfBOjLCcGec=vQWVs+1sBktecmfG40vaGjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jwZeTy=fNdfBOjLCcGec=vQWVs+1sBktecmfG40vaGjA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 04/20/2017 01:33 PM, Rafael J. Wysocki wrote:
> On Thu, Apr 20, 2017 at 9:25 AM, Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>> Hi
>>
>>
>> On 04/19/2017 11:24 PM, Rafael J. Wysocki wrote:
>>>
>>> On Thu, Mar 30, 2017 at 2:04 PM, Jarkko Nikula
>>> <jarkko.nikula@linux.intel.com> wrote:
>>>>
>>>> There is possibility to enter dw_i2c_plat_suspend() callback twice
>>>> during system suspend under certain cases which is causing here warnings
>>>> from clk_core_disable() and clk_core_unprepare() as well as accessing the
>>>> registers that can be power gated.
>>>>
>>>> Commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming during
>>>> system suspend") implemented a prepare callback that checks for runtime
>>>> suspended device which allow PM core to set direct_complete flag and
>>>> skip system suspend and resume callbacks.
>>>>
>>>> However it can still happen if nothing resumes the device prior system
>>>> syspend (e.g. acpi_subsys_suspend()) and there is a slave device which
>>>> unsets the direct_complete flag of the parent in __device_suspend() thus
>>>> causing PM code to not skip the system suspend/resume callbacks.
>>>>
>>>> Avoid this by checking runtime status in suspend and resume callbacks
>>>> and return directly if device is runtime suspended. This affects only
>>>> system suspend/resume since during runtime suspend/resume runtime status
>>>> is suspending (not suspended) or resuming.
>>>>
>>>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>>> ---
>>>> I'm able to trigger system suspend callback while device is runtime
>>>> suspended by removing the pm_runtime_resume() call from
>>>> drivers/mfd/intel-lpss.c: resume_lpss_device() and having unbound I2C
>>>> slave (ACPI enumerated but doesn't bind due an error in probe function).
>>>> In that case __device_suspend() for that unbound device has NULL suspend
>>>> callback, and thus doesn't cause any runtime resume chain but still
>>>> unsets
>>>> the parent's direct_complete flag.
>>>> John Stult <john.stultz@linaro.org> has reported he can trigger this on
>>>> HiKey board too.
>>>>
>>>> I'm not sure is this the right thing to do. It feels something the PM
>>>> core
>>>> should do but I'm not sure that either. One alternative could be to
>>>> resume
>>>> runtime suspended parent in in __device_suspend() right after where
>>>> parent's direct_complete flag is unset.
>>>
>>>
>>> In that case the core expects that the ->prepare callback for the
>>> slave will also return 1 (or a positive number in general).
>>>
>>> If that doesn't happen, then from the core's perspective it is not
>>> safe to allow the master's system PM callbacks to be skipped and
>>> that's why direct_complete is unset for it.
>>>
>> So it's then right thing to check runtime PM status in driver as patch does
>> below?
>
> If you know for a fact that none of the device's children and none of
> the children thereof and so on and nothing that may depend on the
> device via a device_link, either directly or indirectly, will ever
> need to be resumed during system suspend, then yes, it is.
>
> Otherwise, no, it isn't.
>
If you were wondering the pm_runtime_suspended() check in 
dw_i2c_plat_resume() that too was for skipping double callback by system 
resume followed by later runtime resume leading to ever increasing clock 
enable count over repeated system suspend/resume cycles.

Anyway, normal case here is we do runtime resume during system suspend 
from a few places. E.g. ACPI enumerated slave does suspend through 
acpi_subsys_suspend() chain and for Intel platforms i2c-designware is 
resumer either from drivers/acpi/acpi_lpss.c or drivers/mfd/intel-lpss.c.

If we are doing expected suspend/resume callback then our runtime_status 
is other than RPM_SUSPENDED and pm_runtime_suspended() returns false.

-- 
Jarkko
