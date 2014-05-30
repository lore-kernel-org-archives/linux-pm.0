From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 0/2] cpufreq: opp: Add device tree based lookup of boost mode frequency
Date: Fri, 30 May 2014 23:17:51 +0200
Message-ID: <2191015.UTZ3UUDTTl@vostro.rjw.lan>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com> <1430270.VsBiDfiUL9@vostro.rjw.lan> <CAJuA9aiz8ipNXt0-9ybrTUdeH=boOp2BOo2KPsLMVAYUNBPRuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9aiz8ipNXt0-9ybrTUdeH=boOp2BOo2KPsLMVAYUNBPRuA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Friday, May 30, 2014 11:37:58 PM Thomas Abraham wrote:
> On Fri, May 30, 2014 at 8:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, May 30, 2014 02:19:06 PM Rafael J. Wysocki wrote:
> >> On Friday, May 30, 2014 02:31:15 PM Thomas Abraham wrote:
> >> > Changes since v5:
> >> > - Fixes for checkpatch warnings with --strict option as suggested by
> >> >   Nishanth Menon.
> >> >
> >> > Changes since v4:
> >> > - Code improvements suggested by Viresh Kumar.
> >> >
> >> > Changes since v3:
> >> > - Minor changes as suggested in the last version.
> >> >
> >> > Changes since v2:
> >> > - Reworked based on the "PM / OPP: move cpufreq specific helpers out of OPP
> >> >   layer" patch series posted by Nishanth Menon.
> >> >
> >> > Changes since v1:
> >> > - Boost mode frequencies are specfied as a set of frequencies instead of
> >> >   specifying them as OPPs. Thanks to Nishanth, Lukasz and Rob for the
> >> >   feedback.
> >> >
> >> > This series has been acked by authors and maintainers of the code
> >> > portions changed in this series. The new DT binding introduced in this
> >> > patch needs an ack from device tree binding maintainers as well.
> >> >
> >> > Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
> >> > support for CPU boost mode for CPUfreq drivers. To use the new boost
> >> > mode, CPUfreq drivers have to specify the boost mode frequency and
> >> > voltage within the CPUfreq driver, which is the case for Exynos4x12
> >> > CPUfreq driver.
> >> >
> >> > But for CPUfreq drivers which obtain the OPPs from cpus node, this
> >> > patch series adds support to specify boost mode frequencies in the
> >> > cpu device tree node. This requirement came up when Lukasz pointed
> >> > out the regression caused by the Exynos CPUfreq driver consolidation
> >> > patches.
> >>
> >> Both patches queued up for 3.16 in the linux-pm tree.
> >
> > But please address the Mark's comments or I'll drop them.
> 
> Hi Rafael,
> 
> Please drop this series for now. Both the patches have to reworked
> based on Mark's comments.

OK, dropped.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
