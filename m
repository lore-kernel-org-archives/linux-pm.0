From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks
 to late/early stages
Date: Tue, 3 Oct 2017 01:58:04 +0200
Message-ID: <CAJZ5v0gvn=JMGzCEUr750zXDQAHEEcnGzpJQ-_BBwTa1-2L4nw@mail.gmail.com>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan>
 <65494652.vEfz4tCBDb@aspire.rjw.lan> <4332008.kXBLY0K23i@aspire.rjw.lan> <20170925072847.nl2a6feqzrzdcxwz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170925072847.nl2a6feqzrzdcxwz@ninjato>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 25, 2017 at 9:28 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Sep 25, 2017 at 01:20:35AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Push the system suspend/resume callbacks of intel-lpss to the late
>> suspend/early resume stages to allow child device callbacks to be
>> pushed to the late/early stages of suspend/resume too, so as to
>> make it possible to avoid resuming the children if they are runtime-
>> suspended during system suspend going forward.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Tested-by: Johannes Stezenbach <js@sig21.net>
>> Tested-by: Rajat Jain <rajatja@google.com>
>
> If this series shall go in via I2C, I'd need an ack from Lee for this
> one.

So this one has been ACKed now, so the series should be good to go.

Do you need me to resend it (because of the v5 of patch [1/3])?

Thanks,
Rafael
