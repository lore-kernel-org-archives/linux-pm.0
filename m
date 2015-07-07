From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in reverse
 order
Date: Tue, 07 Jul 2015 15:26:09 -0700
Message-ID: <559C5201.7080605@codeaurora.org>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com> <CAHp75VdGyfyfYV6q9vdqK5nYBMpPWFxr32eiXXn2ruUj4pg6BA@mail.gmail.com> <20150706160529.GC3182@x1> <3134535.L6At3I31FS@vostro.rjw.lan> <20150707065117.GE3182@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150707065117.GE3182@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 07/06/2015 11:51 PM, Lee Jones wrote:
> On Tue, 07 Jul 2015, Rafael J. Wysocki wrote:
>> So are there any ACKs missing from the last series posted by Andy?
> Yes, I have requested a Clk Ack, as there are some, lets say
> interesting code in the MFD driver which I am unsure about.  However,
> we have caught Mike at an awkward time, as he is in the middle of
> transitioning jobs.
>
> Perhaps Stephen Boyd (now Cc'ed) might have a look.
>

Context? I found the cover letter.

clkdev is maintained by Russell. You could get his ack for the usage of
the clkdev_create() API, but I'm not sure why it's needed. The API was
merged into Linus' tree so I think you have everything you need.

$ git tag -l --contains 2568999835d7797afce3dcc3a3f368051ffcaf1f v4*
v4.2-rc1


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

