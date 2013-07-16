From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] cpufreq: Preserve policy structure across suspend/resume
Date: Tue, 16 Jul 2013 15:24:40 +0530
Message-ID: <51E51860.4020905@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <20130711221704.547.64296.stgit@srivatsabhat.in.ibm.com> <CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com> <51E3C950.90503@linux.vnet.ibm.com> <CAKohpo=tfd_CXDBkbE23=UdEF99ZK-17NM_cvpGJ_e9wXGzsZQ@mail.gmail.com> <51E50AD4.6040208@linux.vnet.ibm.com> <CAKohponOeqptU2mz4XCFZKoEs5EBTTx0A3Dvev5k-BJiW_2McA@mail.gmail.com> <51E51276.9020805@linux.vnet.ibm.com> <CAKohpon=rVBHZHCz_C7pFoQARXspDJyyPoocTvh8hHjAHPu-og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:43363 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab3GPJ6O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2013 05:58:14 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 16 Jul 2013 15:21:32 +0530
In-Reply-To: <CAKohpon=rVBHZHCz_C7pFoQARXspDJyyPoocTvh8hHjAHPu-og@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/16/2013 03:05 PM, Viresh Kumar wrote:
> On 16 July 2013 14:59, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> On 07/16/2013 02:40 PM, Viresh Kumar wrote:
> 
>>> So, even if you don't keep the fallback storage, things should work
>>> without any issue (probably worth trying as this will get rid of a per
>>> cpu variable :))
>>>
>>
>> No, I already tried that and it didn't work ;-( The thing is, we need the
>> __cpufreq_add_dev() code to call the ->init() routines of drivers etc. But if
>> it finds the policy structure, it will skip all of that initialization and happily
>> proceed. Which is precisely the cause of all the erratic behaviour we are seeing
>> (ie., lack of proper initialization post-resume).
> 
> I missed that point. :)
> 
>> So this approach keeps the memory preserved in a fallback storage and lets the
>> init code run to full completion without any issues.
>>
>> Perhaps we could do some _more_ code reorganization in the future to take this
>> issue into account etc., but IMHO that might be non-trivial. I'm trying to keep
>> this as simple and straight-forward as possible as a first step, to atleast get
>> it properly working. (Changing the order in which init is done is kinda scary
>> since its hard to comprehend what assumptions we might be breaking!).
>>
>> We can perhaps revisit your idea later and optimize out the extra per-cpu data.
> 
> No, we don't need to optimize it that way. Current design looks good
> for now.

Cool! Thanks :)

Regards,
Srivatsa S. Bhat

