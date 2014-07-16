From: "Srivatsa S. Bhat" <srivatsa@MIT.EDU>
Subject: Re: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Wed, 16 Jul 2014 13:19:39 +0530
Message-ID: <53C62E93.8010307@mit.edu>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>	<1405052287-4744-1-git-send-email-skannan@codeaurora.org>	<CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>	<2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>	<CAKohpokhmj1OkCRj=X+Q7eYiun8fsqD2dpEt66VKYnqo3dENVA@mail.gmail.com>	<53C0A12A.2060204@codeaurora.org>	<CAKohpon9en_VnSx+CVydPsWBHtArvmazn0hrodrRJt9jgOa0-g@mail.gmail.com>	<53C42AA8.8010107@codeaurora.org>	<CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>	<53C4BDFB.70707@codeaurora.org>	<53C4D12E.3040807@mit.edu> <CAKohpon8zDP3hVFMQV4CO2zOkb-AwnDws8xW=H8Hm4=gW=8FGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:59265 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758364AbaGPHvl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 03:51:41 -0400
In-Reply-To: <CAKohpon8zDP3hVFMQV4CO2zOkb-AwnDws8xW=H8Hm4=gW=8FGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 07/16/2014 11:14 AM, Viresh Kumar wrote:
> On 15 July 2014 12:28, Srivatsa S. Bhat <srivatsa@mit.edu> wrote:
>> Wait, allowing an offline CPU to be the policy->cpu (i.e., the CPU which is
>> considered as the master of the policy/group) is just absurd.
> 
> Yeah, that was as Absurd as I am :)
> 

I have had my own share of silly ideas over the years; so don't worry, we are
all in the same boat ;-)

>> The goal of this patchset should be to just de-couple the sysfs files/ownership
>> from the policy->cpu to an extent where it doesn't matter who owns those
>> files, and probably make it easier to do CPU hotplug without having to
>> destroy and recreate the files on every hotplug operation.
> 
> I went to that Absurd idea because we thought we can skip playing with
> the sysfs nodes on suspend/hotplug.
> 
> And if policy->cpu keeps changing with hotplug, we *may* have to keep
> sysfs stuff moving as well. One way to avoid that is by using something
> like: policy->sysfs_cpu, but wasn't sure if that's the right path to follow.
>

Hmm, I understand.. Even I don't have any suggestions as of now, since I
haven't spent enough time thinking of alternatives yet.

> Lets see what Saravana's new patchset has for us :)
> 

Yep :-)

Regards,
Srivatsa S. Bhat
