From: skannan@codeaurora.org
Subject: Re: RFC: Leave sysfs nodes alone during hotplug
Date: Tue, 8 Jul 2014 03:30:04 -0000
Message-ID: <533b04020d15a2f9ac0c582652f6e70f.squirrel@www.codeaurora.org>
References: <53B5D22F.2070308@codeaurora.org>
    <CAKohpomuPshe4HpvWSzmZ3vvAjV-zHucfHBVbhB6dUBrrYH8pw@mail.gmail.com>
    <53BAF540.9080904@codeaurora.org>
    <CAAW3Ypa690EKmDzwx94CaHeR4j_F6_yFmFrn6xTYuLv=pH7B3g@mail.gmail.com>
    <CAKohpokvRnLU+DQBX39odAf5wxuzWjLi=sy5t2fYReoHCfshwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpokvRnLU+DQBX39odAf5wxuzWjLi=sy5t2fYReoHCfshwQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Todd Poynor <toddpoynor@google.com>, Saravana Kannan <skannan@codeaurora.org>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ruchi Kandoi <kandoiruchi@google.com>
List-Id: linux-pm@vger.kernel.org


Viresh Kumar wrote:
> On 8 July 2014 04:10, Todd Poynor <toddpoynor@google.com> wrote:
>> For Android's usage we're also interested in both:
>>
>> 1. not removing and recreating the cpufreq sysfs files for a CPU on
>> hotplug events (we currently use hotplug uevents to reset file
>> ownership such that power policy can be controlled by non-root).
>>
>> 2. not resetting the contents of policy files such as scaling_max_freq
>> (also fixed up from uevents) or stats files (we currently keep a
>> separate persistent time_in_state for battery accounting purposes).
>
> So, we actually need to retain all the files. I will try to see this
> separately. Will add it in my todo list.
>

Looks like there's enough interest. I'll also try to send out a patch of
what I think a simplified CPUfreq should look like.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
