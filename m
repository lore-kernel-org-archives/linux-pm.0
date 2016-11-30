From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev list
Date: Wed, 30 Nov 2016 07:06:24 +0530
Message-ID: <CAKohpom1khq8ot5VBJmBufh+58hkiCD4Ko7GOScK55cxW8z++w@mail.gmail.com>
References: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
 <20161129024647.GY6095@codeaurora.org> <20161129051115.GE3288@vireshk-i7> <20161129205638.GB6095@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161129205638.GB6095@codeaurora.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Joonyoung Shim <jy0922.shim@samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 November 2016 at 02:26, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/29, Viresh Kumar wrote:
>> On 28-11-16, 18:46, Stephen Boyd wrote:
>> > Anyway, rant over, how about handing out the opp table pointer to
>> > the caller so they can pass it back in when they call the put
>> > side? That should fix the same problem if I understand correctly.
>>
>> Hmm, so the problem is that all below routines (and their callers) need to get
>> updated:
>>
>> int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions, unsigned int count);
>> void dev_pm_opp_put_supported_hw(struct device *dev);
>> int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
>> void dev_pm_opp_put_prop_name(struct device *dev);
>> struct opp_table *dev_pm_opp_set_regulator(struct device *dev, const char *name);
>> void dev_pm_opp_put_regulator(struct opp_table *opp_table);
>>
>> And that will make it difficult to get it back to stable kernels, specially
>> because they were all added in different kernel releases after 4.4.
>
> Why do we care? The put variants of the prop and supported_hw
> functions are never called, so we're not going to hit this
> problem there. Sure the code is broken, but nobody is using the
> code in mainline so there isn't anything to backport to stable
> urgently.

Hmm, only the set variants are used by the sti driver.

>>
>> And we also need to fix them properly, with something like a cookie instead of a
>> plain opp_table pointer.
>
> Perhaps this means my approach in using opp_table is undesirable
> for some reason? Care to elaborate why?

You only suggested the cookie method as well, isn't it ? I am fine with your
patch as well, the only problem is that we will have different prototype for
a single set of APIs..

> I'd prefer we used my patch because it
> isn't as easy to break and more directly fixes the problem at
> hand.

Okay, can you please send it formally and I can Ack it then ?

--
viresh
