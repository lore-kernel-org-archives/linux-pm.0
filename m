From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I
 on recent Dell laptops
Date: Thu, 01 Jun 2017 13:43:23 +0300
Message-ID: <1496313803.28981.45.camel@linux.intel.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
         <3454366.uzaJljlWGm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3454366.uzaJljlWGm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-06-01 at 01:23 +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a follow-up for a patch series posted some time ago:
> 
> http://marc.info/?l=linux-kernel&m=149324246701378&w=2
> 
> The first two patches from that series are in 4.12-rc already and the
> rest
> have been rearranged.
> 

...

> The first two patches in the current series  update the drivers used
> for button
> events processing on the affected systems so that they signal wakeup
> as
> expected and avoid propagating the wakeup events as button events to
> user
> space.

...

> There is no code dependency between patches [1-2/3] and patch [3/3],
> but all
> of them together are necessary for the feature in question to work on
> both the
> affected systems, so IMO they should be applied together.
> 
> The series is available from a git branch at
>  
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> s2idle-dell-test
>  
> and has been included into the testing branch thereof.
>  
> If there are any concerns regarding this series, please let me know.

Is this supposed to go via linux PM tree?

I'm fine with the first two:
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
