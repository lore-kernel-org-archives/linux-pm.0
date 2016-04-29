From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RESEND][RFC/PATCH] cpufreq: Fix GOV_LIMITS handling for the
 userspace governor
Date: Fri, 29 Apr 2016 14:35:07 -0700
Message-ID: <5723D38B.3000802@nvidia.com>
References: <5722513B.4080801@nvidia.com> <20160429034908.GS2915@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11852 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbcD2VhL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2016 17:37:11 -0400
In-Reply-To: <20160429034908.GS2915@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matthew Longnecker <MLongnecker@nvidia.com>

On 04/28/2016 08:49 PM, Viresh Kumar wrote:
> On 28-04-16, 11:06, Sai Gurrappadi wrote:
>> Resending without the copyright headed appended..sorry!
>>
>> -Sai
>>
>> =======
> 
> :)
> 
> For your information, this isn't the right place to add text which shouldn't be
> committed.

[..]

>>
>> Signed-off-by: Sai Gurrappadi <sgurrappadi@nvidia.com>
>> ---
> 
> Rather do it here and git am will automatically drop that while applying the
> patch.

Good to know. Thanks!

-Sai

> 
>>  drivers/cpufreq/cpufreq_userspace.c | 20 ++++++++++++++++----
