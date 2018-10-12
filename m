From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Date: Fri, 12 Oct 2018 09:20:19 -0600
Message-ID: <20181012152019.GF2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
 <8161939.SRDo8Qx48D@aspire.rjw.lan>
 <20181011220842.GE2371@codeaurora.org>
 <CAJZ5v0hXM9krdacL09kJSn30AL_5kN+4U3d02rZX7-V2DWg_VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXM9krdacL09kJSn30AL_5kN+4U3d02rZX7-V2DWg_VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rplsssn@codeaurora.org, Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, "Nayak, Rajendra" <rnayak@codeaurora.org>, bjorn.andersson@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12 2018 at 01:43 -0600, Rafael J. Wysocki wrote:
>On Fri, Oct 12, 2018 at 12:08 AM Lina Iyer <ilina@codeaurora.org> wrote:
>> On Thu, Oct 11 2018 at 14:56 -0600, Rafael J. Wysocki wrote:
>> >On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
>> >> From: Ulf Hansson <ulf.hansson@linaro.org>

>> The cluster states should account for that additional latency.
>
>But even then, you need to be sure that the idle governor selected
>"cluster" states for all of the CPUs in the cluster.  It might select
>WFI for one of them for reasons unrelated to the distance to the next
>timer (so to speak), for example.
>
Well, if cpuidle chooses WFI, cpu_pm_enter() will not be called. So for
that case we are okay with this approach.

>> Just the CPU's power down states need not care about that.
>
>The meaning of this sentence isn't particularly clear to me. :-)
>
What I meant to say is that if cpuidle chooses a CPU only power down
state, then, atleast in ARM architecture, we would not choose to power
down the cluster in the firmware. To power down the cluster in the
firmware, all CPUs need to choose a cluster state, which would account
the additional latency of powering off and on the domain.

How I ever thought that I could convey this point in that line is beyond
me now. Sorry!

>> But, it would be nice if the PM domain governor could be cognizant of
>> the idle state chosen for each CPU, that way we dont configure the
>> domain to be powered off when the CPUs have just chosen to power down
>> (not chosen a cluster state). I think that is a whole different topic to
>> discuss.
>
>This needs to be sorted out before the approach becomes viable, though.
>
We embarked on that discussion a few years ago, but realized that there
is a lot more complexity involved in specifying that especially with DT.
I believe ACPI has a way to specify this. But DT and driver code
currently don't have a nice way to propagate this requirement to the
domain governor. So we shelved it for the future.

>Basically, the domain governor needs to track what the idle governor
>did for all of the CPUs in the domain and only let the domain go off
>if the latency matches all of the states selected by the idle
>governor.  Otherwise the idle governor's assumptions would be violated
>and it would become essentially useless overhead.
>
Well, we kinda do that in the CPU PM domain governor. By looking at the
next wakeup and the latency/QoS requirement of each CPU in the domain,
we determine if the domain can be powered off. But, if we were to do
this by correlating domain idle states to that of the required CPU idle
state, then a lot needs to plumbed in to the cpuidle and driver model.
The current approach is rather simple while meeting most of the
requirement.

Thanks,
Lina
