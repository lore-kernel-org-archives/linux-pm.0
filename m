From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/9] i2c: designware: Fix system suspend
Date: Tue, 27 Jun 2017 10:33:33 +0300
Message-ID: <bca550fd-3821-fb14-c3b0-8f05c7a1fdff@linux.intel.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
 <20170622104933.GY629@lahna.fi.intel.com> <2842386.AFZiXzV2Sq@aspire.rjw.lan>
 <CAPDyKFo80QWYhU_SFexr_riPSZS3QEXDyBcywa5qBYa3sJXcjw@mail.gmail.com>
 <CAJZ5v0irHvYXHv1GykatTH+XROZyL0nR0c=KfdSrpH395s6V8g@mail.gmail.com>
 <CAPDyKFov=08AQw0PPPgcFbrerTskoPGfLZcJL9gjikfQfZUJpw@mail.gmail.com>
 <4324e2c8-ab79-5a21-a8ab-c660920cba59@ti.com>
 <CAJZ5v0i-AgTDTOX+O41abVsnahU9V=NV+HEW0vajhBqGfJuUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i-AgTDTOX+O41abVsnahU9V=NV+HEW0vajhBqGfJuUEg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/27/2017 12:11 AM, Rafael J. Wysocki wrote:
> On Mon, Jun 26, 2017 at 9:39 PM, Grygorii Strashko
>> Wouldn't it fix suspend for this driver if you will just replace
>> dw_i2c_plat_suspend() with pm_runtime_force_suspend() in SET_SYSTEM_SLEEP_PM_OPS() as
>> you've done in patch 9?
>>
>> And, I think, direct_complete path should still work after this also.
>
> That's a good point and I was about to mention that.
>
Unfortunately it will cause regression to platforms using 
drivers/acpi/acpi_lpss.c power domain:

http://www.spinics.net/lists/linux-i2c/msg29079.html

-- 
Jarkko
