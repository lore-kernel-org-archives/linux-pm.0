From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: properly retrieve
 P-state upon suspend
Date: Wed, 1 Feb 2017 15:59:46 -0800
Message-ID: <CAGt4E5v6FtynvbY-t+iX1YY287rQyt9cxG49hQX3nj83NHpSfg@mail.gmail.com>
References: <20161219201028.18885-1-code@mmayer.net> <20170106041112.GC21926@vireshk-i7>
 <CAGt4E5t9w-TE=dqaZJLYxyG__pS9HjPNaD-H-brC7GJudA=30g@mail.gmail.com> <13652921.6keQ978gf5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36606 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdBAX7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 18:59:48 -0500
Received: by mail-wm0-f52.google.com with SMTP id c85so64500508wmi.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2017 15:59:47 -0800 (PST)
In-Reply-To: <13652921.6keQ978gf5@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Markus Mayer <code@mmayer.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 1 February 2017 at 15:44, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, January 31, 2017 10:53:01 AM Markus Mayer wrote:
>> On 5 January 2017 at 20:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 19-12-16, 12:10, Markus Mayer wrote:
>> >> From: Markus Mayer <mmayer@broadcom.com>
>> >>
>> >> The AVS GET_PMAP command does return a P-state along with the P-map
>> >> information. However, that P-state is the initial P-state when the
>> >> P-map was first downloaded to AVS. It is *not* the current P-state.
>> >>
>> >> Therefore, we explicitly retrieve the P-state using the GET_PSTATE
>> >> command.
>> >>
>> >> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> >> ---
>> >>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 13 ++++++++++++-
>> >>  1 file changed, 12 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> >> index 2c6e325..c943606 100644
>> >> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> >> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> >> @@ -784,8 +784,19 @@ static int brcm_avs_target_index(struct cpufreq_policy *policy,
>> >>  static int brcm_avs_suspend(struct cpufreq_policy *policy)
>> >>  {
>> >>       struct private_data *priv = policy->driver_data;
>> >> +     int ret;
>> >> +
>> >> +     ret = brcm_avs_get_pmap(priv, &priv->pmap);
>> >> +     if (ret)
>> >> +             return ret;
>> >>
>> >> -     return brcm_avs_get_pmap(priv, &priv->pmap);
>> >> +     /*
>> >> +      * We can't use the P-state returned by brcm_avs_get_pmap(), since
>> >> +      * that's the initial P-state from when the P-map was downloaded to the
>> >> +      * AVS co-processor, not necessarily the P-state we are running at now.
>> >> +      * So, we get the current P-state explicitly.
>> >> +      */
>> >> +     return brcm_avs_get_pstate(priv, &priv->pmap.state);
>> >>  }
>> >>
>> >>  static int brcm_avs_resume(struct cpufreq_policy *policy)
>> >
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Just wanted to follow up to see if this has been or will be picked up
>> for 4.10?
>
> For 4.10?  No way.

I was only thinking 4.10, because it's a fix for an existing driver.
But I am not complaining if it goes into 4.11.

>> I had a quick poke around some trees and did not see it
>> there.
>
> I'm not sure which trees you checked, but it is there in my linux-next branch.

Clearly, I didn't check there, my apologies.

Regards,
-Markus
