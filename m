From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [Results] [RFC PATCH v4 00/40] mm: Memory Power Management
Date: Wed, 13 Nov 2013 00:19:29 +0530
Message-ID: <52827839.80904@linux.vnet.ibm.com>
References: <20130925231250.26184.31438.stgit@srivatsabhat.in.ibm.com> <52437128.7030402@linux.vnet.ibm.com> <20130925164057.6bbaf23bdc5057c42b2ab010@linux-foundation.org> <52442F6F.5020703@linux.vnet.ibm.com> <5281E09B.3060303@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:42142 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab3KLSyC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2013 13:54:02 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 13 Nov 2013 00:23:59 +0530
In-Reply-To: <5281E09B.3060303@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mgorman@suse.de, dave@sr71.net, hannes@cmpxchg.org, tony.luck@intel.com, matthew.garrett@nebula.com, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, amit.kachhap@linaro.org, thomas.abraham@linaro.org, markgross@thegnar.org

On 11/12/2013 01:32 PM, Srivatsa S. Bhat wrote:
> On 09/26/2013 06:28 PM, Srivatsa S. Bhat wrote:
>> On 09/26/2013 05:10 AM, Andrew Morton wrote:
>>> On Thu, 26 Sep 2013 04:56:32 +0530 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>>>
>>>> Experimental Results:
>>>> ====================
>>>>
>>>> Test setup:
>>>> ----------
>>>>
>>>> x86 Sandybridge dual-socket quad core HT-enabled machine, with 128GB RAM.
>>>> Memory Region size = 512MB.
>>>
>>> Yes, but how much power was saved ;)
>>>
>>
>> I don't have those numbers yet, but I'll be able to get them going forward.
>>
> 
> Hi,
> 
> I performed experiments on an IBM POWER 7 machine and got actual power-savings
> numbers (upto 2.6% of total system power) from this patchset. I presented them
> at the Kernel Summit but forgot to post them on LKML. So here they are:
> 

<snip>

And here is a recent LWN article that highlights the important design changes
in this version and gives a good overview of this patchset as a whole:

http://lwn.net/Articles/568891/

And here is the link to the patchset (v4):
http://lwn.net/Articles/568369/

Regards,
Srivatsa S. Bhat
 

