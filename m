From: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Subject: Re: [PATCH 1/3 v6] battery: Add the battery hooking API
Date: Wed, 20 Dec 2017 22:23:30 +0100
Message-ID: <CALgTWSvEg3EfjSJqAp5nRuxRceBpg92=x3FPFEW9PThBmizQEA@mail.gmail.com>
References: <20171215165654.GA6209@thinkpad> <CAJZ5v0icKSOsxFTRonW8xEt7=oXBvCsO84FMx4ECQHTYd0_SGw@mail.gmail.com>
 <CALgTWSuWoj6ecfNZmpn68uGV4m+Rz2adAWrw-Ng-7rU75SVtHQ@mail.gmail.com> <20171220211617.GA14667@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43292 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756341AbdLTVXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 16:23:33 -0500
In-Reply-To: <20171220211617.GA14667@fury>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>

On 20/12/2017, Darren Hart <dvhart@infradead.org> wrote:
> On Wed, Dec 20, 2017 at 03:30:18PM +0100, Ognjen Gali=C4=87 wrote:
>> On 18/12/2017, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > Also, what if someone attempts to add a hook when the ACPI battery
>
>> > module is not loaded?  Will that still work?
>>
>> The module that requests the hooks will fail to load with the following
>>
>> > [  149.259127] thinkpad_acpi: Unknown symbol battery_hook_register (er=
r
>> > 0)
>> > [  149.259158] thinkpad_acpi: Unknown symbol battery_hook_unregister
>> > (err 0)
>
> Will a synchronous request_module() address this concern?
>

I don't know, that check seems like a pre-load check. Like metadata
checking about
the module. modprobe handles the module loading just fine.

> --
> Darren Hart
> VMware Open Source Technology Center
>
