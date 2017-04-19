From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume when
 RT suspended
Date: Wed, 19 Apr 2017 22:24:49 +0200
Message-ID: <CAJZ5v0ja8_j-1bgN4+iiqrYskVMrrsN9S1mM1JY9pRUzGBRSzw@mail.gmail.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com> <20170419185909.dl5h6xhkd6f72na3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170419185909.dl5h6xhkd6f72na3@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 19, 2017 at 8:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Mar 30, 2017 at 03:04:44PM +0300, Jarkko Nikula wrote:
>> There is possibility to enter dw_i2c_plat_suspend() callback twice
>> during system suspend under certain cases which is causing here warnings
>> from clk_core_disable() and clk_core_unprepare() as well as accessing the
>> registers that can be power gated.
>>
>> Commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming during
>> system suspend") implemented a prepare callback that checks for runtime
>> suspended device which allow PM core to set direct_complete flag and
>> skip system suspend and resume callbacks.
>>
>> However it can still happen if nothing resumes the device prior system
>> syspend (e.g. acpi_subsys_suspend()) and there is a slave device which
>> unsets the direct_complete flag of the parent in __device_suspend() thus
>> causing PM code to not skip the system suspend/resume callbacks.
>>
>> Avoid this by checking runtime status in suspend and resume callbacks
>> and return directly if device is runtime suspended. This affects only
>> system suspend/resume since during runtime suspend/resume runtime status
>> is suspending (not suspended) or resuming.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> I'm able to trigger system suspend callback while device is runtime
>> suspended by removing the pm_runtime_resume() call from
>> drivers/mfd/intel-lpss.c: resume_lpss_device() and having unbound I2C
>> slave (ACPI enumerated but doesn't bind due an error in probe function).
>> In that case __device_suspend() for that unbound device has NULL suspend
>> callback, and thus doesn't cause any runtime resume chain but still unsets
>> the parent's direct_complete flag.
>> John Stult <john.stultz@linaro.org> has reported he can trigger this on
>> HiKey board too.
>>
>> I'm not sure is this the right thing to do. It feels something the PM core
>> should do but I'm not sure that either. One alternative could be to resume
>> runtime suspended parent in in __device_suspend() right after where
>> parent's direct_complete flag is unset.
>
> Because of the last paragraph, I'd like a positive comment or tag from
> one of the PM people before I apply this one.

No, sorry.
