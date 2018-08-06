From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
Date: Mon, 6 Aug 2018 10:30:39 +0200
Message-ID: <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
References: <20180804152932.3861-1-gabriele.mzt@gmail.com> <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 4, 2018 at 7:31 PM, Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
> On 04/08/2018 17:29, Gabriele Mazzotta wrote:
>> This change does not take into account that some BIOSes change
>> MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
>> If the turbo is disabled when the system boots, policy.max_freq
>> is set to pstate.max_pstate. However, if the BIOS later enables
>> the turbo, the CPU will never be able to run at pstate.turbo_pstate.
>>
>> Since now intel_pstate_set_policy() does its calculations using
>> pstate.max_freq and pstate.turbo_freq, we can always calculate
>> cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
>> with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
>> speed when the turbo is enabled.

Well, the problem with this approach is that always using
pstate.turbo_pstate as the max causes the governor to overestimate the
target frequency when the turbo range is not available (the target
depends on the width of the entire available P-state range including
turbo, so if the turbo range is not available, the number take into
that computation is too large).

Are we expected to get notified when the BIOS updates
MSR_IA32_MISC_ENABLE_TURBO_DISABLE?
