From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] cpufreq-stats: Minor documentation fix
Date: Fri, 9 Sep 2016 00:38:59 +0200
Message-ID: <e538cefd-dc59-e135-d07e-4c3e1603a8e5@intel.com>
References: <20160908123943.6141564f@endymion>
 <20160908112006.GS27345@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59506 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbcIHWjD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Sep 2016 18:39:03 -0400
In-Reply-To: <20160908112006.GS27345@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.de>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>

On 9/8/2016 1:20 PM, Viresh Kumar wrote:
> On 08-09-16, 12:39, Jean Delvare wrote:
>> The cpufreq-stats code can no longer be built as a module, so it now
>> appears with square brackets in menuconfig.
>>
>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   Documentation/cpu-freq/cpufreq-stats.txt |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-4.8-rc5.orig/Documentation/cpu-freq/cpufreq-stats.txt	2016-09-04 23:31:46.000000000 +0200
>> +++ linux-4.8-rc5/Documentation/cpu-freq/cpufreq-stats.txt	2016-09-08 11:34:34.805606601 +0200
>> @@ -103,7 +103,7 @@ Config Main Menu
>>   	Power management options (ACPI, APM)  --->
>>   		CPU Frequency scaling  --->
>>   			[*] CPU Frequency scaling
>> -			<*>   CPU frequency translation statistics
>> +			[*]   CPU frequency translation statistics
>>   			[*]     CPU frequency translation statistics details
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
Applied, but please CC PM material to linux-pm too.  That makes it much 
easier to handle.


Thanks,

Rafael


