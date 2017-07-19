From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [patch v3 2/5] acpi / boot: correct address space of
 __acpi_map_table()
Date: Wed, 19 Jul 2017 16:56:01 +0300
Message-ID: <1500472561.29303.115.camel@linux.intel.com>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
         <20170718150420.61600-3-andriy.shevchenko@linux.intel.com>
         <20170719130636.apmaj5ya4obkhvga@yury-thinkpad>
         <20170719134051.zuf2rji46rfier64@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170719134051.zuf2rji46rfier64@yury-thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: "rafael j . wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, thomas gleixner <tglx@linutronix.de>, ingo molnar <mingo@redhat.com>, "h . peter anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, hanjun guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, geert uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-07-19 at 16:40 +0300, Yury Norov wrote:
> On Wed, Jul 19, 2017 at 04:06:36PM +0300, yury norov wrote:

> > I just found this patch in next tree, and it seems it breaks build
> > for
> > arm64, and probably for ia64:

I think you found previous version (v1). _This_ patch (v3 of it)
actually solves that.

> > the patch below fixes it. (Tested on arm64 only.)
> 
> Ah, sorry. This is correct version.

Thank you, I think Rafael might rebase with clean version (v3) his tree
which will fix this.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
