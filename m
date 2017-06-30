From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 20:58:34 +0300
Message-ID: <CAHp75VffMTJeM4unCLGP3cEBxcPevTk7_P7Arv72Up8PrGzvnw@mail.gmail.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
 <20170630155706.GL26073@mail.corp.redhat.com> <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
 <7d8201bf-b05e-6235-7eb0-54b1a393f99f@redhat.com> <CAHp75VfWmAvaASLZOhmMBW7v+E10_7xvD11OSMKdQ0HbY_yHVg@mail.gmail.com>
 <eb6ad1a4-3538-a8f8-e8c2-c3781a90c37f@redhat.com> <CAHp75VdLkt4VJE_M51E66y3rhWtD0ALhorV3Kq=Y_Z_9GTbVLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33881 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdF3R6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 13:58:36 -0400
In-Reply-To: <CAHp75VdLkt4VJE_M51E66y3rhWtD0ALhorV3Kq=Y_Z_9GTbVLw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 30, 2017 at 8:55 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 30, 2017 at 8:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On 30-06-17 19:40, Andy Shevchenko wrote:
>>> On Fri, Jun 30, 2017 at 8:37 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>> On 30-06-17 18:37, Andy Shevchenko wrote:
>>>>> On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires
>
>> Care to share that? Between me and Benjamin one of us can hopefully
>> find the time to test / finish it (should be trivial really).
>
> Not tested at all.

Should have

Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed devices")

also.

-- 
With Best Regards,
Andy Shevchenko
