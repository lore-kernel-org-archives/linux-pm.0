From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Thu, 09 Jul 2015 01:33:25 +0200
Message-ID: <2101129.y5YCnQeajv@vostro.rjw.lan>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org> <CAJ5Y-eb00m6DE_4mHXnGha4j6PwTNeV8x0eroMe_JZy7NVowow@mail.gmail.com> <1623587.PclZFH5dDd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1623587.PclZFH5dDd@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 09, 2015 01:29:21 AM Rafael J. Wysocki wrote:
> On Wednesday, July 08, 2015 05:57:11 PM Ashwin Chaugule wrote:
> > On 8 July 2015 at 18:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Wednesday, July 08, 2015 05:46:45 PM Ashwin Chaugule wrote:
> > >> On 8 July 2015 at 16:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >> >>
> > >> >> Perhaps the confusion is coming from the introduction of ACPI_CST in
> > >> >> this file. I could leave it as it is and just separate out the
> > >> >> ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CST,
> > >> >> since we know the LPI stuff is coming up soon as a CST alternative
> > >> >> anyway. So if you prefer, I can drop the CST bits and maybe Sudeep can
> > >> >> address that as part of his LPI patchset?
> > >> >
> > >> > Yes, please.  That would be much less confusing.
> > >>
> > >> Deja Vu. :)
> > >>
> > >> When I let processor_driver and processor_idle compile on ARM64, I get
> > >> a bunch of errors because processor_idle.c contains a lot of X86
> > >> specific defines. That is why I'd created the ACPI_CST option which
> > >> we'd enable only on X86.
> > >>
> > >> I'm not entirely sure what these enums and functions should default
> > >> to, or what they should be on ARM specifically. Given that on ARM64
> > >> we're likely to use LPI as against CST, it seems the original approach
> > >> is better. Thoughts?
> > >
> > > Before we go anywhere deeper, have you checked what happens on ia64?
> > 
> > I dont have access, but I'm really not changing anything functionally.
> 
> I mean ia64 is a non-x86 architecture using ACPI.  It very well may be doing
> things that you want to be doing.
> 
> It looks like the only reason you want ACPI_CST for is to avoid building
> processor_idle.c on ARM64.  Then add something like this to the ACPI Kconfig:
> 
> config ACPI_PROCESSOR_IDLE
> 	def_bool Y
> 	depends on X86 || IA64
> 
> and don't make it user-selectable *and* under the ACPI_PROCESSOR config do
> 
> 	select CPU_IDLE if ACPI_PROCESSOR_IDLE
> 
> Then, make processor_idle.c conditional on ACPI_PROCESSOR_IDLE.  That should
> do the trick and it may be changed by the LPI series as needed.

And do that in a separate patch with a clear changelog explaining why you're
doing it.

Thanks,
Rafael

