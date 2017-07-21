From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/5] ACPI / boot: Not all platform require acpi_reduced_hw_init()
Date: Sat, 22 Jul 2017 00:25:01 +0200
Message-ID: <1535497.HrG5Hi31l1@aspire.rjw.lan>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com> <20170718150420.61600-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170718150420.61600-5-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 18, 2017 06:04:19 PM Andy Shevchenko wrote:
> Some platform might take care of legacy devices on theirs own.
> Let's allow them to do that by exporting a weak function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'd rather do it at the time when acpi_reduced_hw_init() actually needs to be
overridden by at least one platform.

Thanks,
Rafael

