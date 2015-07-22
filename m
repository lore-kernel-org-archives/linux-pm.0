From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Wed, 22 Jul 2015 03:28:04 +0200
Message-ID: <1583446.GxfV2z2IW5@vostro.rjw.lan>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <CAJZ5v0j-_QB1U-A0F2YSoDa_71nyEGR=yn8Kb5qe-FSqDPevOA@mail.gmail.com> <55AE652B.7030409@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55AE652B.7030409@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 21, 2015 04:28:43 PM Sudeep Holla wrote:
> Hi Rafael,
> 
> On 21/07/15 15:34, Rafael J. Wysocki wrote:
> > Hi Sudeep,
> >
> > On Tue, Jul 21, 2015 at 11:23 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>
> >>
> >> On 20/07/15 23:04, Rafael J. Wysocki wrote:
> >>>
> >>> On Monday, July 20, 2015 03:22:37 PM Sudeep Holla wrote:
> >>>>
> >>>>
> >>>> On 09/07/15 19:04, Ashwin Chaugule wrote:
> >>>>>
> >>>>> CPPC is the first client to make use of the PCC Mailbox channel. So
> >>>>> enable it only when CPPC is also enabled.
> >>>>>
> >>>> This sounds like a reverse dependency to me. So if there's some client
> >>>> unrelated to CPPC using PCC, CPPC_LIB needs to be selected to enable PCC
> >>>> ?
> >>>
> >>>
> >>> No.  The other client will need to select PCC too.
> >>
> >>
> >> Yes the PCC users/clients selecting PCC is fine and that's already
> >> done(i.e. ACPI_CPPC_LIB selects PCC). I still don't understand the need
> >> for this change, also how will other clients possibly select PCC which
> >> now depends on CPPC_LIB ? e.g. if we have
> >>
> >> config ACPI_XYZ_LIB
> >>          select PCC
> >>
> >> config ACPI_XYZ
> >>          select ACPI_XYZ_LIB
> >>
> >> Won't this shout warning: (ACPI_XYZ_LIB && ACPI_CPPC_LIB) selects PCC
> >> which has unmet direct dependencies (MAILBOX && ACPI && ACPI_CPPC_LIB)
> >> if ACPI_CPPC_LIB is not selected ?
> >
> > That depends on the "depends on" clauses used.  Selecting itself
> > doesn't cause any dependencies to appear.
> >
> 
> Agreed and I am absolutely fine with that. But if you look at this 
> patch, it does
> 
> config PCC
> 	bool "Platform Communication Channel Driver"
> 	depends on ACPI && ACPI_CPPC_LIB

My bad, I've evidently overlooked that.

If PPC is selected from ACPI_CPPC_LIB, the "depends on" above is
obviously not needed.

> I am fine with ACPI_CPPC_LIB selecting PCC which is already done in
> earlier patch. I am against making PCC depend on ACPI_CPPC_LIB.

OK, makes sense.  Sorry for the misunderstanding.

Thanks,
Rafael

