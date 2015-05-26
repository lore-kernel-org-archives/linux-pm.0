From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Tue, 26 May 2015 09:51:37 +0300
Message-ID: <CAHp75Vej=LZpP3fBBaO56p4D6rN2w2h=8kSUQYW7OO62W5Cw3Q@mail.gmail.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<20150526035155.GN3140@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36205 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbEZGvj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 02:51:39 -0400
In-Reply-To: <20150526035155.GN3140@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, May 26, 2015 at 6:51 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, May 25, 2015 at 07:09:24PM +0300, Andy Shevchenko wrote:
>> The new coming Intel platforms such as Skylake will contain Sunrisepoint PCH.
>>
>> The driver is based on MFD framework since the main device, i.e. serial bus
>> controller, contains register space for itself, DMA part, and an additional
>> address space (convergence layer).
>>
>> The public specification of the register map is avaiable in [3].
> or [1]...?

You are correct!

>> This is second generation of the patch series to bring support LPSS devices
>> found on Intel Sunrisepoint (Intel Skylake PCH). First one can be found here
>> [2].
>>
>> The series has few logical parts:
>> - patches 1-3 prepares PM core, ACPI, and driver core (PM) to handle our case
>> - patches 4-6 introduce unregistering platform devices in MFD in reversed
>>   order
>> - patch 7 implements iDMA 64-bit driver
>> - patch 8 introduces an MFD driver for LPSS devices
>>
>> The patch 8 depends on clkdev_create() helper that has been introduced by
>> Russel King in [3].
>>
>> The driver has been tested with SPI and UART on Intel Skylake PCH.
>>
>> [1] https://download.01.org/future-platform-configuration-hub/skylake/register-definitions/332219_001_Final.pdf
>> [2] https://lkml.org/lkml/2015/3/31/255
>> [3] https://patchwork.linuxtv.org/patch/28464/

-- 
With Best Regards,
Andy Shevchenko
