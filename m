From: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Subject: Re: [PATCH 1/3 v6] battery: Add the battery hooking API
Date: Wed, 20 Dec 2017 15:30:18 +0100
Message-ID: <CALgTWSuWoj6ecfNZmpn68uGV4m+Rz2adAWrw-Ng-7rU75SVtHQ@mail.gmail.com>
References: <20171215165654.GA6209@thinkpad> <CAJZ5v0icKSOsxFTRonW8xEt7=oXBvCsO84FMx4ECQHTYd0_SGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0icKSOsxFTRonW8xEt7=oXBvCsO84FMx4ECQHTYd0_SGw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18/12/2017, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> What if a module registering the hook is loaded after
> sysfs_add_battery() has run for the battery object in question?

The battery module keeps track of the batteries that get added or removed
from the system. When a hook is registered, it will always get a list
of currently
present batteries not matter of the time when the hook is loaded.

> What if it attempts to register a hook while this code is running?

If was not able to produce any race conditions, but I have added some locking
mechanisms in the new, 7th revision of the patch.

> What if two entities try to add or remove hooks simultaneously?

This has been solved in version 7 with mutual exclusions.

> Don't you think any locking or other synchronization is necessary?

I have implemented mutual exclusions.

> Also, what if someone attempts to add a hook when the ACPI battery
> module is not loaded?  Will that still work?

The module that requests the hooks will fail to load with the following

> [  149.259127] thinkpad_acpi: Unknown symbol battery_hook_register (err 0)
> [  149.259158] thinkpad_acpi: Unknown symbol battery_hook_unregister (err 0)

> Thanks,
> Rafael
>
