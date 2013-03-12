From: Mayuresh Kulkarni <mkulkarni@nvidia.com>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Tue, 12 Mar 2013 20:26:08 +0530
Message-ID: <513F4208.4040207@nvidia.com>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com> <20130312134913.GD3514@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:7666 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab3CLOzz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 10:55:55 -0400
In-Reply-To: <20130312134913.GD3514@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, Peter De Schrijver <pdeschrijver@nvidia.com>, Mayuresh Kulkarni <mkulkarni@nvidia.com>

On Tuesday 12 March 2013 07:19 PM, Greg KH wrote:
> On Tue, Mar 12, 2013 at 02:19:19PM +0530, Mayuresh Kulkarni wrote:
>> - this commit adds a capability to delay the powering off
>> of the domain
>
> Why?
>

- As I mentioned below (sorry for mentioning below rather than at 
start), powering off a domain means the context save needs to be done && 
it needs to be restored during power on.
- It often observed that saving and restoring of context is expensive in 
terms of power consumed as well as overall system response.

>> - callers can use pm_genpd_set_poweroff_delay to set the
>> power off delay for a domain
>
> Why?
>

So, the idea is to delay the powering off a domain to some time in 
future with the anticipation that the domain would be really needed 
(starting from now till power off delay).

>> - it expects the delay in milli-seconds
>
> Why?
>

For Tegra we found that a delay in terms of milli-seconds is good in 
terms of power as well as system response.

>> - it also adds a pm_notifier per pm domain which cancels
>> the delayed power off work when system suspend is invoked
>
> Why?
>

- This patch uses pm_wq which is freezable during system suspend.
- It is observed that sometimes the work queued *before* system suspend 
is never canceled before system suspend is invoked. As a result, the 
pm_wq gets frozen and work is scheduled after the system resumes causing 
unwanted issues (like messed up ref-counts etc).
- So, I wanted a notification which tells that system suspend is invoked 
&& it happens *before* work queue is frozen. Hence, I used the 
pm_notifier which is executed before freeze of work queue to cancel any 
pending work associated for a domain which implements delayed power off.

> Come on, please tell us why something is needed and not what it does in
> a changelog comment.
>
>> Signed-off-by: Mayuresh Kulkarni <mkulkarni@nvidia.com>
>> ---
>>
>> - The idea here is to avoid the powering off of a domain if use cases causes
>> it to turn on within specific time in coming future
>
> What use case?

- We use this concept in downstream kernel for Tegra and have observed 
that delayed power off reduces the number of oscillations between 
on->off->on of a domain.
- A typical use case could be boot-Android-to-home-screen. This helps to 
reduces the 3d power partition turning on->off->on when user space is 
waiting for something other than 3d && it needs to use 3d after it gets 
that event.
- The delayed used here has to be tuned by someone who is working on 
power optimization for the various use cases.

>
>> - This seems to save power and better response by avoiding context save/restore
>> which are heavy operations in most of the cases
>
> Now these four lines are bit better, why are you hiding it down here?
>
> Who is going to use this code?  Where is those callers?  We don't add
> new infrastructure without in-kernel users, unless there is a very good
> reason.
>

- The downstream kernel has a graphics-host (host1x) driver which has a 
home grown power management framework called ACM 
(auto-clock-management). We implement both delayed clock and power 
partition off functionality in it.
- With preliminary host1x driver getting up-stream, the next logical 
step for us is to add power management feature(s) to it. However, the 
home grown ACM framework will not be acceptable upstream when runtime pm 
(for clock management) & pm domain (power partition management) are 
available to do the same tasks.
- The runtime pm supports auto-suspend concept so we exploit it to 
implement delayed clock off. However, pm domain doesn't have concept of 
delayed power off. And hence this patch adds this functionality.
- Having said that, there is no in-kernel component that uses this API 
as of now. But we anticipate that it will have one in near future, 
at-least for Tegra (specifically host1x driver).

> greg k-h
>

P.S.: All the above information is available in Tegra TRM and 
http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=summary (public git 
repository for NV released kernels).
