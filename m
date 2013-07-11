From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Thermal: x86 package temp thermal crash
Date: Thu, 11 Jul 2013 09:28:51 -0700
Message-ID: <51DEDD43.2090401@linux.intel.com>
References: <1373521763-23184-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20130711155911.GB5857@fifo99.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755735Ab3GKQYe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jul 2013 12:24:34 -0400
In-Reply-To: <20130711155911.GB5857@fifo99.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com

Thanks Daniel.

I will correct the comment and resubmit patch. Sorry for the pain caused 
by me.

Regards,
Srinivas

On 07/11/2013 08:59 AM, Daniel Walker wrote:
> On Wed, Jul 10, 2013 at 10:49:23PM -0700, Srinivas Pandruvada wrote:
>> On some older platform this resulted in general protection fault,
>> for accessing MSRs, which are not present.
>> Added change so that the module is loaded, only when the CPU has
>> PTS feature. The previous check has an issue when DTS sensor is
>> present but PTS is not supported.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Reported-by: Daniel Walker <dwalker@fifo99.com>
>> ---
>
> Although I should note that my platform is not old by any means.. So
> your comments above aren't exactly correct.
>
> Tested-By: Daniel Walker <dwalker@fifo99.com>
>
>

