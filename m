From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 12/20] cpufreq: Mark policy->governor = NULL for
 inactive policies
Date: Thu, 2 Apr 2015 11:39:54 +0530
Message-ID: <CAKohpok37PXGxmP+M-d8mpT-eGxaCjtAwgQdZO=mJ9PmvxTv3w@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<466c5246b6ad83b960eeb63ab34a04379448980d.1424345053.git.viresh.kumar@linaro.org>
	<551CC7E2.6070806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36651 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbDBGJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 02:09:54 -0400
Received: by obbec2 with SMTP id ec2so113498109obb.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 23:09:54 -0700 (PDT)
In-Reply-To: <551CC7E2.6070806@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 2 April 2015 at 10:08, Saravana Kannan <skannan@codeaurora.org> wrote:
> What's wrong with this behavior? If you cat scaling_min/max_freq, it's going
> to show the last minimum and maximum freqs too. I don't think this needs to
> be set to NULL until the governor is unloaded. Which you are already taking
> care of in the previous patch.
>
> It's handy to be able to tell what governor will be restored when a cluster
> if offline.
>
> Nacked because I think this patch is not helping.

Oh, I really believe this patch makes sense. :)

Don't confuse it with the 'last-governor' thing or scaling_min/max stuff..
Its different.

Consider a scenario:
- Cluster was using ONDEMAND governor.
- Cluster hotplugged out
- Governor removed, but the pointer policy->governor isn't updated.

-> At this point accessing 'scaling_governor' or 'scaling_setspeed' can
get called and that will result in a crash.

- We go ahead and insert the governor again

-> At this point also the same problem will happen as governor will
get allocated again.

Now, what we are talking about here is a pointer to the governor, not
its name which is stored in 'last_governor' in the previous patch.

We store that name as it is used for internal working of the core, not for
userspace.

What we expose to userspace must be consistent, and so if the governor
is removed, we will not be able to provide 'scaling_setspeed' or
'scaling_governor' to userspace.

Also, it is scaling-governor, not what the next governor is going to be.
Plus, what should we print on scaling_setspeed of a cluster not running
anymore ?

And so why keep something that we can't provide to userspace all the
time. That may break userspace if it relies on it..
