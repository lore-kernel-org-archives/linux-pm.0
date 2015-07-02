From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/10] OPP: Allocate dev_opp from _add_device_opp()
Date: Thu, 02 Jul 2015 16:46:48 -0700
Message-ID: <5595CD68.9040701@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org> <83bd3b9837b30bab62f41aed3dd2cdf52cc21688.1434369079.git.viresh.kumar@linaro.org> <55948DB0.8060500@codeaurora.org> <20150702062455.GD31684@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54810 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbbGBXqv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 19:46:51 -0400
In-Reply-To: <20150702062455.GD31684@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 07/01/2015 11:24 PM, Viresh Kumar wrote:
> On 01-07-15, 18:02, Stephen Boyd wrote:
>> On 06/15/2015 04:57 AM, Viresh Kumar wrote:
>>>  	/* Duplicate OPPs ? */
>>> -	if (new_opp->rate == opp->rate) {
>>> +	if (opp && new_opp->rate == opp->rate) {
>> Isn't opp always non-NULL at this point? Maybe this if statement should
>> be moved into the list_for_each_entry_rcu() loop.
> when the dev_opp was getting created for the first time, before this
> patch, we used to do a 'goto list_add'. And so control never reached
> here, but now we might find a empty list of OPPs and so 'opp' can be
> NULL here.

Yes, but doesn't list_for_each_entry_rcu() always assign opp to be at
least &dev_opp->opp_list->next which will be pointing at
&dev_opp->opp_list if the list is empty (modulo ->member)?

> Not sure about moving this to the loop, as we are already taking
> 'dev_opp_list_lock' in this routine.

Sorry, I lost you here. How does that matter? I was suggesting moving
the duplicate OPP check into the list_for_each_entry_rcu() loop so that
this NULL check doesn't matter.

>
>>> +remove_dev_opp:
>>> +	_remove_device_opp(dev_opp);
>> Doesn't this just return early because dev_opp has something in it?
> Hmm, it isn't required probably.
>
> ---------------------8<-----------------------
>
> Message-Id: <b13057f196330d0e08f3c517676cc3116b1be4ae.1435818265.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Fri, 12 Jun 2015 12:43:14 +0530
> Subject: [PATCH] OPP: Allocate dev_opp from _add_device_opp()
>
> There is no need to complicate _opp_add_dynamic() with allocation of
> dev_opp as well. Allocate it from _add_device_opp() instead.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>

Looking better.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

