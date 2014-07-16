From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
Date: Wed, 16 Jul 2014 11:14:01 +0530
Message-ID: <CAKohpon8zDP3hVFMQV4CO2zOkb-AwnDws8xW=H8Hm4=gW=8FGQ@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
	<1405052287-4744-1-git-send-email-skannan@codeaurora.org>
	<CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
	<2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
	<CAKohpokhmj1OkCRj=X+Q7eYiun8fsqD2dpEt66VKYnqo3dENVA@mail.gmail.com>
	<53C0A12A.2060204@codeaurora.org>
	<CAKohpon9en_VnSx+CVydPsWBHtArvmazn0hrodrRJt9jgOa0-g@mail.gmail.com>
	<53C42AA8.8010107@codeaurora.org>
	<CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>
	<53C4BDFB.70707@codeaurora.org>
	<53C4D12E.3040807@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35653 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbaGPFoC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 01:44:02 -0400
Received: by mail-ob0-f174.google.com with SMTP id vb8so440792obc.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2014 22:44:01 -0700 (PDT)
In-Reply-To: <53C4D12E.3040807@mit.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa@mit.edu>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 15 July 2014 12:28, Srivatsa S. Bhat <srivatsa@mit.edu> wrote:
> Wait, allowing an offline CPU to be the policy->cpu (i.e., the CPU which is
> considered as the master of the policy/group) is just absurd.

Yeah, that was as Absurd as I am :)

> The goal of this patchset should be to just de-couple the sysfs files/ownership
> from the policy->cpu to an extent where it doesn't matter who owns those
> files, and probably make it easier to do CPU hotplug without having to
> destroy and recreate the files on every hotplug operation.

I went to that Absurd idea because we thought we can skip playing with
the sysfs nodes on suspend/hotplug.

And if policy->cpu keeps changing with hotplug, we *may* have to keep
sysfs stuff moving as well. One way to avoid that is by using something
like: policy->sysfs_cpu, but wasn't sure if that's the right path to follow.

Lets see what Saravana's new patchset has for us :)
