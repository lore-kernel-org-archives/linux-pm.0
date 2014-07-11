From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Fri, 11 Jul 2014 11:31:49 +0530
Message-ID: <CAKohpo=BFtwGoj5WhnahvETGrosRkwjBYPWGfn0FBdskJP=XXg@mail.gmail.com>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
	<53BE75EE.6010200@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <53BE75EE.6010200@mit.edu>
Sender: stable-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa@mit.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Saravana Kannan <skannan@codeaurora.org>, "Bu, Yitian" <ybu@qti.qualcomm.com>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10 July 2014 16:45, Srivatsa S. Bhat <srivatsa@mit.edu> wrote:
> Looks good to me. But I think it would be better to move the invocation of
> kobject_move() to update_policy_cpu() itself, so that update_policy_cpu()
> will do all the work involved in updating the policy->cpu, as its name suggests.
>
> With that small nit,
>
> Reviewed-by: Srivatsa S. Bhat <srivatsa@mit.edu>

Hi Rafael,

I had a chat with Srivatsa about this patch and the V2 version which
people aren't able to test yet.

I proposed that we take this patch as is and hold V2 for some time.
- V2 wouldn't apply cleanly to stable kernels for sure
- V2 isn't yet tested and V1 is.
- Saravana already proposed a patch which would remove most of what
  V2 is adding: http://www.spinics.net/lists/arm-kernel/msg346604.html

Our chats:

<vireshk> srivatsa, http://www.spinics.net/lists/arm-kernel/msg346604.html
<srivatsa> vireshk, thanks for the pointer.. will try to take a look
by tonight..

<vireshk> srivatsa, Because saravana is actually looking to change much of
                the stuff, what about dropping the V2 fix that I sent
yesterday and
                take V1 only for now?
<vireshk> srivatsa, As V1 would apply cleanly over stable kernels as well
<srivatsa> vireshk, sure, no problem... perhaps you can make the code
                 reorganization of the kobject_move as a separate
patch and submit
                 it for merge window instead of -rc
<vireshk> srivatsa, I was even thinking of that as well
<vireshk> Have two patches, only first one for rc and second one for
next release
<vireshk> srivatsa, But the second patch would be overwritten by Saravanna,
                so might not be of any use
<srivatsa> vireshk, ah, i see.. in that case, we can hold off on the
second patch for
                 now.. just v1 should do..


What do you say?
