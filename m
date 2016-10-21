From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/8] PM / OPP: Multiple regulator support
Date: Fri, 21 Oct 2016 21:10:45 +0530
Message-ID: <CAKohpon8f-7ppaFsb+wZH4Dj527HXRF73E8taYN9QfcojjJa3g@mail.gmail.com>
References: <cover.1476952750.git.viresh.kumar@linaro.org> <CAJZ5v0jNJBDKq+ccHKRA6JGAOXV0qT0-k1mwAcBkCv-7JtzACw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jNJBDKq+ccHKRA6JGAOXV0qT0-k1mwAcBkCv-7JtzACw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21 October 2016 at 19:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Oct 20, 2016 at 10:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Hi,
>>
>> Some platforms (like TI) have complex DVFS configuration for CPU
>> devices, where multiple regulators are required to be configured to
>> change DVFS state of the device. This was explained well by Nishanth
>> earlier [1].
>>
>> Some thoughts went into it few months back but then it all got lost. I
>> am trying to get that back on track with this thread.
>>
>> One of the major complaints around multiple regulators case was that the
>> DT isn't responsible in any way to represent the ordering in which
>> multiple supplies need to be programmed, before or after frequency
>> change. It was considered in this patch and such information is left to
>> the platform specific OPP driver now, which can register its own
>> opp_set_rate() callback with the OPP core and the OPP core will then
>> call it during DVFS.
>>
>> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
>> and code to pass values for multiple regulators and verified that they
>> are all properly read by the kernel (using debugfs interface).
>>
>> Though more testing on real (TI) platforms would be useful.
>>
>> This is rebased over: linux-next branch in the PM tree.
>>
>> V1->V2:
>> - Ack from Rob for 1st patch
>> - Moved the supplies structure to pm_opp.h (Dave)
>> - Fixed an compilation warning.
>
> I need somebody from the OPP camp to review patches [2-8/8] for me.

Sure, I have already asked Stephen yesterday to do that.

--
viresh
