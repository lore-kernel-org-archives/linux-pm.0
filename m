From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Thu, 09 Jul 2015 00:21:19 +0200
Message-ID: <36832814.6sPr1fbHHF@vostro.rjw.lan>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org> <CAJZ5v0iGGgvzdcvAfS9ZiQTWMhqF9GWfZ7Fx6_rF1BGZmACpXw@mail.gmail.com> <CAJ5Y-eZCWF8fsfwtJFAS9wyz8ttpGVTZKhoboCudLhUHw80qkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61832 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750798AbbGHVyv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 17:54:51 -0400
In-Reply-To: <CAJ5Y-eZCWF8fsfwtJFAS9wyz8ttpGVTZKhoboCudLhUHw80qkg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On Wednesday, July 08, 2015 05:46:45 PM Ashwin Chaugule wrote:
> On 8 July 2015 at 16:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > Hi Ashwin,
> 
> Hi,
> 
> > On Wed, Jul 8, 2015 at 10:28 PM, Ashwin Chaugule
> > <ashwin.chaugule@linaro.org> wrote:
> >> On 8 July 2015 at 16:05, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> >>> On 8 July 2015 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>> Hi Ashwin,
> >>>>
> >>>> On Wed, Jul 8, 2015 at 9:16 PM, Ashwin Chaugule
> >>>> <ashwin.chaugule@linaro.org> wrote:
> >>>>> Hi Rafael,
> >>>>>
> >
> > [cut]
> >
> >>>>
> >>>> Also I'm still unsure what the connection between _CST and CPPC is.
> >>>>
> >>>
> >>> There isnt. But I'm missing where I've implied the dependency?
> >>
> >> Perhaps the confusion is coming from the introduction of ACPI_CST in
> >> this file. I could leave it as it is and just separate out the
> >> ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CST,
> >> since we know the LPI stuff is coming up soon as a CST alternative
> >> anyway. So if you prefer, I can drop the CST bits and maybe Sudeep can
> >> address that as part of his LPI patchset?
> >
> > Yes, please.  That would be much less confusing.
> 
> Deja Vu. :)
> 
> When I let processor_driver and processor_idle compile on ARM64, I get
> a bunch of errors because processor_idle.c contains a lot of X86
> specific defines. That is why I'd created the ACPI_CST option which
> we'd enable only on X86.
> 
> I'm not entirely sure what these enums and functions should default
> to, or what they should be on ARM specifically. Given that on ARM64
> we're likely to use LPI as against CST, it seems the original approach
> is better. Thoughts?

Before we go anywhere deeper, have you checked what happens on ia64?

Rafael

