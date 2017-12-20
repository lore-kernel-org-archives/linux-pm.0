From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/3 v6] battery: Add the battery hooking API
Date: Wed, 20 Dec 2017 13:17:19 -0800
Message-ID: <20171220211617.GA14667@fury>
References: <20171215165654.GA6209@thinkpad>
 <CAJZ5v0icKSOsxFTRonW8xEt7=oXBvCsO84FMx4ECQHTYd0_SGw@mail.gmail.com>
 <CALgTWSuWoj6ecfNZmpn68uGV4m+Rz2adAWrw-Ng-7rU75SVtHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALgTWSuWoj6ecfNZmpn68uGV4m+Rz2adAWrw-Ng-7rU75SVtHQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 20, 2017 at 03:30:18PM +0100, Ognjen Galić wrote:
> On 18/12/2017, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > Also, what if someone attempts to add a hook when the ACPI battery

> > module is not loaded?  Will that still work?
> 
> The module that requests the hooks will fail to load with the following
> 
> > [  149.259127] thinkpad_acpi: Unknown symbol battery_hook_register (err 0)
> > [  149.259158] thinkpad_acpi: Unknown symbol battery_hook_unregister (err 0)

Will a synchronous request_module() address this concern?

-- 
Darren Hart
VMware Open Source Technology Center
