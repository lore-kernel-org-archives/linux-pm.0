From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 0/3] devfreq_cooling: let the driver supply the real
 power every time we need it
Date: Tue, 28 Feb 2017 13:52:53 +0000
Message-ID: <1583912b-3581-a1d2-4b60-1072219d3f76@arm.com>
References: <20170131161147.17002-1-lukasz.luba@arm.com>
 <20170221133559.GC23954@ct-lt-587>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752222AbdB1Nw5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Feb 2017 08:52:57 -0500
In-Reply-To: <20170221133559.GC23954@ct-lt-587>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, rui.zhang@intel.com, orjan.eide@arm.com, chris.diamand@arm.com

Thank you Javi for the ACK.

On 21/02/17 13:35, Javi Merino wrote:
> On Tue, Jan 31, 2017 at 04:11:44PM +0000, Lukasz Luba wrote:
>> Hi,
>>
>> This patchset introduces a new interface for devfreq cooling in thermal
>> framework. The previous version of the patch can be seen here [1].
>> I have simplified the implementation and introduced resource utilization
>> scaling factor.
[..]
>>
>> The first patch contains some refactoring for getting the voltage,
>> the second implements the new feature, the third one changes trace function.
>> Patchset is based on v4.10-rc5.

I will have to rebase the patch set due to changes
introduced in merged tag pm-4.11-rc1 (OPP interface).

[..]
>>
>
> For the series:
>
> Acked-by: Javi Merino <javi.merino@kernel.org>

That would be a small v3 change, so should be simple.

Regards,
Lukasz
