From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/6] ACPI: Make ACPI processor driver more extensible
Date: Sat, 13 Jun 2015 03:06:22 +0200
Message-ID: <7281162.f7BYVWdGtd@vostro.rjw.lan>
References: <1432590659-9016-1-git-send-email-ashwin.chaugule@linaro.org> <CAJ5Y-eZDmfhRpzeEv_+oxEc8L2EvqPiJRJG455tW8D9a1TgV2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54025 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753559AbbFMAka (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 20:40:30 -0400
In-Reply-To: <CAJ5Y-eZDmfhRpzeEv_+oxEc8L2EvqPiJRJG455tW8D9a1TgV2g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On Friday, June 12, 2015 01:53:36 PM Ashwin Chaugule wrote:
> On 25 May 2015 at 17:50, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> > The ACPI processor driver is currently tied too closely
> > to the ACPI C-states (CST), P-states (PSS) and other related
> > constructs for controlling CPU idle and CPU performance.
> >
> > The newer ACPI specification (v5.1 onwards) introduces
> > alternative methods to CST and PSS. These new mechanisms
> > are described within each ACPI Processor object and so they
> > need to be scanned whenever a new Processor object is detected.
> > This patch introduces two new Kconfig symbols to allow for
> > finer configurability among the various options for controlling
> > CPU idle and performance states. There is no change in functionality
> > and these options are defaulted to enabled to maintain previous
> > behaviour.
> >
> > The following patchwork introduces CPPC: A newer method of
> > controlling CPU performance. The OS is not expected to support CPPC
> > and PSS at runtime. So the kconfig option lets us make these two
> > mutually exclusive at compile time.
> >
> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > ---
> >  drivers/acpi/Kconfig            |  41 +++++++++++----
> >  drivers/acpi/Makefile           |   7 +--
> >  drivers/acpi/processor_driver.c |  85 ++++++++++++++++++++-----------
> >  drivers/cpufreq/Kconfig         |   2 +-
> >  drivers/cpufreq/Kconfig.x86     |   2 +
> >  include/acpi/processor.h        | 109 ++++++++++++++++++++++++++++++++++------
> >  6 files changed, 187 insertions(+), 59 deletions(-)
> 
> 
> Gentle reminder.. I'll address the function name as Srinivas
> suggested. Any other comments here and the other patches in this
> series?

Can you please resend the patches with CCs to linux-acpi too, just in case the
people on that list have any comments?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
