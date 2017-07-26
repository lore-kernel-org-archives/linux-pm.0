From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/5] ACPI / boot: Not all platform require acpi_reduced_hw_init()
Date: Wed, 26 Jul 2017 20:53:10 +0200
Message-ID: <5814320.0Xa8vJDJkv@aspire.rjw.lan>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com> <CAHp75Ve=7HsNHZ443Fs08O7Ya4mMfgtq3nD-6znkeKCjQtGe3w@mail.gmail.com> <CAJZ5v0hwg5Y3UeGpnM24HXVrJbmDm7ipX-1R9OSgo3wRR50mYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hwg5Y3UeGpnM24HXVrJbmDm7ipX-1R9OSgo3wRR50mYQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, July 23, 2017 12:14:27 AM Rafael J. Wysocki wrote:
> On Sun, Jul 23, 2017 at 12:13 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jul 23, 2017 at 1:02 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Saturday, July 22, 2017 04:53:52 AM Andy Shevchenko wrote:
> >>> On Sat, Jul 22, 2017 at 1:25 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> > On Tuesday, July 18, 2017 06:04:19 PM Andy Shevchenko wrote:
> >
> >>> > I'd rather do it at the time when acpi_reduced_hw_init() actually needs to be
> >>> > overridden by at least one platform.
> >>>
> >>> Do you mean as folded into some other patch or just as a preparatory
> >>> patch in some future series?
> >
> >> Any of the above would work for me.
> >
> > Logically it should be a separate change as I can see (I have already
> > locally prepared patches for that one platform).
> >
> > Thanks for review.
> >
> > P.S. Are you going to apply first 3 then from this series?
> 
> Yes, I am.

So applied now, thanks!

