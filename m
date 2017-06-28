From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] i2c: designware: Fix system suspend
Date: Wed, 28 Jun 2017 17:06:07 +0200
Message-ID: <CAPDyKFqJ5y0wnu8r=J+d0K=6K3N-bhbGUKwtCkBCMP4zsO_fdg@mail.gmail.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <a7881812-0da6-478c-7eed-faf8a6e30891@linux.intel.com> <CAPDyKFqShg+9rYfjMwKU6ri7nWt3nAqv_A+N-hHitRLwDi0_5g@mail.gmail.com>
 <2931814.Q2Ytvoipjr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <2931814.Q2Ytvoipjr@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, stable@vger.linux.org
List-Id: linux-pm@vger.kernel.org

On 28 June 2017 at 16:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 28, 2017 04:01:39 PM Ulf Hansson wrote:
>> On 27 June 2017 at 09:55, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
>> > On 06/22/2017 02:16 PM, Jarkko Nikula wrote:
>> >>
>> >> On 06/22/2017 01:49 PM, Mika Westerberg wrote:
>> >>>
>> >>> On Thu, Jun 22, 2017 at 01:31:51AM +0200, Rafael J. Wysocki wrote:
>> >>>>
>> >>>> On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org>
>> >>>> wrote:
>> >>>
>> >>> Thanks Ulf for taking care of this!
>> >>>
>> >> Indeed!
>> >>
>> >>> I tested this series on Dell XPS 9350 which has touch panel connected to
>> >>> I2C and suspend/resume still works fine and I can see the controller
>> >>> going to D3 when the touch panel is idle.
>> >>>
>> >>> I can perform more comprehensive testing next week.
>> >>>
>> >> Unfortunately I'm seeing interrupt storm during suspend/resume on
>> >> platform using PM domain from drivers/acpi/acpi_lpss.c straight after
>> >> this patch. Maybe some timing related as I see it only if I have debug
>> >> messages on (i2c_designware_core.dyndbg=+p). But it occurs only after
>> >> this patch.
>> >>
>> > Sorry the noise, this was bogus. That platform is doing this interrupt storm
>> > randomly and it occurs also without the patch.
>>
>>
>> Okay, then it seems like we should go with $subject patch, although
>> allow me to update the changelog and post a new version.
>
> But as I said, it would be better to do the pm_runtime_resume() in ->resume
> (unless that breaks something), for two reasons.
>
> The first reason is that ->complete is synchronous and ->resume can be done
> in parallel with other devices which potentially saves time.  The second reason
> is that it wouldn't interfere with direct_complete on systems where that
> actually works.

Yes, that's good points - and I don't see any obvious reasons to why
it shouldn't work.

Kind regards
Uffe
