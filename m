From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
Date: Thu, 11 Jan 2018 14:54:37 +0200
Message-ID: <1515675277.7000.917.camel@linux.intel.com>
References: <4046497.JI7UjL75gC@aspire.rjw.lan>
         <12541194.33112yYDjW@aspire.rjw.lan>
         <1515590661.7000.855.camel@linux.intel.com>
         <CAJZ5v0gg8Pn8AU8auPMT+DYVoUK6TmsRUfK+E8RWfThbLPQ+PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gg8Pn8AU8auPMT+DYVoUK6TmsRUfK+E8RWfThbLPQ+PQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-01-10 at 23:25 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 10, 2018 at 2:24 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, 2018-01-10 at 13:26 +0100, Rafael J. Wysocki wrote:

> > Just a nitpick: Can we leave S2IDLE instead of S2I?
> > Would it make sense for potential code readers?
> 
> I wanted it to be shorter, but if that is a problem, I'd rather call
> it PLATFORM than S2IDLE (as technically they are related to the
> low-power mode of the platform).

It's not problem per se, though without a context it would take time to
get into S2I acronym from the code for not familiar reader.

> I'll send an update shortly.

Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
