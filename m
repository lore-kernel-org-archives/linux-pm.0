From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v6 0/8] Add support for Tegra Activity Monitor
Date: Mon, 23 Mar 2015 16:35:00 +0900
Message-ID: <CAAVeFuLf=FEci=NtCLi2p3kOkpWDNfCdAA8Wm9C5Z2cTGBiRzQ@mail.gmail.com>
References: <78905871.274971426655422042.JavaMail.weblogic@epmlwas07d> <CAAObsKDWuGatDaX2a8AqXDMayd0uJAUCLLdRYUmef1Oh=kvd3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKDWuGatDaX2a8AqXDMayd0uJAUCLLdRYUmef1Oh=kvd3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arto Merilainen <amerilainen@nvidia.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Stephen Warren <swarren@wwwdotorg>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 18, 2015 at 3:27 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 18 March 2015 at 06:10, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>> Hello,
>>>
>>> something happened during the last cycle and an old version of the devfreq
>>> driver was merged.
>>>
>>> This thread contains patches that bring it up to date to the last submitted
>>> version and also incorporates the feedback that that version received, plus
>>> some other small fixes and improvements that came up during rebase and
>>> testing.
>>>
>>> These patches implement support for setting the rate of the EMC clock based on
>>> stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
>>> memory accesses (among others).
>>>
>>> It depends on the following in-flight patches:
>>>
>>> * EMC driver: http://thread.gmane.org/gmane.linux.kernel/1907035
>>> * CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1897078
>>>
>>> I have pushed a branch here for testing:
>>>
>>> http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=actmon-v6
>>>
>>> Regards,
>>>
>>> Tomeu
>>>
>>> Tomeu Vizoso (8):
>>>   of: Add binding for NVIDIA Tegra ACTMON node
>>>   PM / devfreq: tegra: Update to v5 of the submitted patches
>>>   clk: tegra: Have EMC clock implement determine_rate()
>>>   PM / devfreq: tegra: Use clock rate constraints
>>>   PM / devfreq: tegra: remove operating-points
>>>   PM / devfreq: tegra: Set drvdata before enabling the irq
>>>   PM / devfreq: tegra: Enable interrupts after resuming the devfreq
>>>     monitor
>>>   ARM: tegra: Add Tegra124 ACTMON support
>>
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> for all PM / devfreq patches (2, 4, 5, 6, 7)
>> And merged in for-rc tree with a little modification.
>
> Thanks. Though that's fine with me, I was wondering if Mikko or
> Alexandre would have any comments on the changes, even if they are
> small regarding what they already reviewed.

After a quick look I think I'm good with it. I will try to look in
further detail. If there is anything wrong, we can fix it with fixup
patches, since what has been merged is good stuff already!

I guess it would now be interesting to look at the watermark support
for devfreq. I am not sure if anything is happening to it? Arto?

https://lkml.org/lkml/2014/12/5/262
