From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Sat, 8 Feb 2014 12:17:09 +0530
Message-ID: <CAJuA9agcpbKYocaQUBr2-VCXcXAo3r3urFF=+G_+ib2jCZqvwg@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
	<1391786342-11812-3-git-send-email-thomas.ab@samsung.com>
	<52F50698.4060305@arm.com>
	<52F509BD.70903@arm.com>
	<CAGo_u6raZY0sKdDn4d92SKpi=eqUpf23vW8K_bEi-v62V2jdPA@mail.gmail.com>
	<52F51888.5010608@arm.com>
	<CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com>
	<52F51FCD.5000009@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <52F51FCD.5000009@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 7, 2014 at 11:32 PM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
> On 07/02/14 17:37, Nishanth Menon wrote:
>> On Fri, Feb 7, 2014 at 11:31 AM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
>
> [...]
>
>>> Yes I think its counter-intuitive as it's visible to the userspace(list of
>>> frequencies and the boost parameters are exposed through sysfs)
>>
>> That will be a different problem -> as currently every single
>> frequency in the cpufreq list has ability to be marked as boost
>> frequency - if userspace does not maintain that, then, IMHO, fix the
>> userspace :D
>>
>
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies gives
> the list of frequencies based on the state of the boost feature at anytime.

The list of frequencies in
/sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies
does not change based in the state of the boost feature (enabled or
disabled). But the scaling_max_frequency and scaling_min_frequency are
updated based on the set of available + boost frequencies available.

>
> Intuitively the list without boost shouldn't have any frequency above the range
> when it's enabled :), that's what I was referring to. So I am not talking about
> any issue with user-space maintenance.
>
> Regards,
> Sudeep
>
