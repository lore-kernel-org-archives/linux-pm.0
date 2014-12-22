From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/2] CPPC as a PID controller backend
Date: Mon, 22 Dec 2014 23:43:15 +0100
Message-ID: <4640372.HQvQivJWUf@vostro.rjw.lan>
References: <1416429381-3839-1-git-send-email-ashwin.chaugule@linaro.org> <4328753.Stv6XUNcFM@vostro.rjw.lan> <CAJ5Y-ebUct=nBNBAqKTMef6bn9EZeWPJyQkg8Z8jeFvE4gQrVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64574 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751606AbaLVWVW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Dec 2014 17:21:22 -0500
In-Reply-To: <CAJ5Y-ebUct=nBNBAqKTMef6bn9EZeWPJyQkg8Z8jeFvE4gQrVA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On Saturday, December 20, 2014 07:14:33 PM Ashwin Chaugule wrote:
> Hi Rafael,
> 
> On 15 December 2014 at 10:16, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, December 15, 2014 09:42:08 AM Ashwin Chaugule wrote:
> >> On 1 December 2014 at 09:56, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> >> > On 11/30/2014 10:26 PM, Viresh Kumar wrote:
> >> >>
> >> >> On 1 December 2014 at 11:53, Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >> >> wrote:
> >> >>>
> >> >>> On 19 November 2014 at 15:36, Ashwin Chaugule
> >> >>> <ashwin.chaugule@linaro.org> wrote:
> >> >>>>
> >> >>>> CPPC (Collaborative Processor Performance Control) is defined
> >> >>>> in the ACPI 5.0+ spec. It is a method for controlling CPU
> >> >>>> performance on a continuous scale using performance feedback
> >> >>>> registers. In contrast to the legacy "pstate" scale which is
> >> >>>> discretized, and tied to CPU frequency, CPPC works off of an
> >> >>>> abstract continuous scale. This lets the platforms freely interpret
> >> >>>> the abstract unit and optimize it for power and performance given
> >> >>>> its knowledge of thermal budgets and other constraints.
> >> >>>>
> >> >>>> The PID governor operates on similar concepts and can use CPPC
> >> >>>> semantics to acquire the information it needs. This information
> >> >>>> may be provided by various platforms via MSRs, CP15s or memory
> >> >>>> mapped registers. CPPC helps to wrap all these variations into a
> >> >>>> common framework.
> >> >>>>
> >> >>>> This patch introduces CPPC using PID as its governor for CPU
> >> >>>> performance management.
> >> >>>>
> >> >>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >> >>>> ---
> >> >>>>   drivers/cpufreq/Kconfig    |   12 +
> >> >>>>   drivers/cpufreq/Makefile   |    1 +
> >> >>>>   drivers/cpufreq/acpi_pid.c | 1156
> >> >>>> ++++++++++++++++++++++++++++++++++++++++++++
> >> >>>>   3 files changed, 1169 insertions(+)
> >> >>>>   create mode 100644 drivers/cpufreq/acpi_pid.c
> >> >>>
> >> >>>
> >> >>>
> >> >>> Ping.
> >> >>>
> >> >>> Any comments on these patches?
> >> >>
> >> >>
> >> >> Redirecting the Ping to Rafael/Dirk :)
> >> >>
> >> > Ashwin has incorporated my feedback.  I have no issues
> >>
> >> Thanks Dirk! I'll add your Reviewed-by to the patchset.
> >>
> >> Rafael, any comments from your side?
> >
> > I have a couple of quick ones (will post them shortly), but generally I need
> > more time to review the whole thing.
> 
> Thanks for the quick review. I've added those changes locally. Just
> this week we were able to run these drivers (CPPC + PCC) on an ARM64
> platform with some CPPC support in the firmware. This helped in
> catching a couple of bugs, which didn't show up on the X86 platform
> which I'd been using all this while. So, I'll send V4 with the new
> changes for your review at the earliest.

Please don't hurry, I most likely won't be able to review it in the next few
weeks anyway.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
