From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
Date: Thu, 4 Oct 2018 20:38:14 +0200
Message-ID: <CAPDyKFoOkC7Tr0Hkx2OHhCA4Tk9j5Y3HBB4bG6ORaiHp-KcJ9w@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan> <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
 <20181004155755.GD5233@e107981-ln.cambridge.arm.com> <CAJZ5v0j+W2CHiqkniXNJgZ3DU9pOpd_83Wj9Egwf+pVkRCjZLg@mail.gmail.com>
 <20181004172109.GA16878@red-moon> <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrWzDU9BsfAnx7uoaXq=gmGg2r46Mn-cJHSWUk-TmyomA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4 October 2018 at 20:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 October 2018 at 19:21, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> On Thu, Oct 04, 2018 at 07:07:27PM +0200, Rafael J. Wysocki wrote:
>>
>> [...]
>>
>>> > > I don't see any dependency there, so I'll queue up the 1-3 in
>>> > > pm-domains and the 4-6 in pm-cpuidle.
>>> >
>>> > I do not see why we should merge patches 4-6 for v4.20; they add legacy
>>> > (DT bindings and related parsing code) with no user in the kernel; we
>>> > may still want to tweak them, in particular PSCI DT bindings.
>>>
>>> My impression was that 4-6 have been agreed on due to the ACKs they
>>> carry.  I'll drop them if that's not the case.
>>
>> I have not expressed myself correctly: they have been agreed (even
>> though as I said they may require some tweaking) but I see no urgency
>> of merging them in v4.20 since they have no user. They contain DT
>> bindings, that create ABI/legacy, I think it is better to have code
>> that uses them in the kernel before merging them and creating a
>> dependency that is not needed.
>
> There is already code using the new bindings, for the idle states.
> Please have look at patch 5, 6 and 11.

Should be 5, 6 and 10, sorry.

>
> Moreover, you have had plenty on time to look at the series, as those
> patches haven't changed since a very long time.
>
> May I suggest you do the review instead, so we can move things
> forward, please. The changes in the v9 series should be trivial to
> review.
>
>>
>>> > Likewise, it makes no sense to merge patches 7-8 without the rest of
>>> > the PSCI patches.
>
> Well, those patches are part of this series, because Mark wanted me to
> move the files. Is really such a big deal? I think it makes sense, no
> matter what happens afterwards.
>
> [...]
>
> Kind regards
> Uffe
