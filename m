From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] cpupower: Fix no-rounding MHz frequency output
Date: Wed, 1 Nov 2017 15:01:26 -0600
Message-ID: <a2fa979c-91ab-d6ed-71e0-47b7f473786c@kernel.org>
References: <20171025135132.16324-1-prarit@redhat.com>
 <20171025220156.GH2694@lianli.shorne-pla.net>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout.easymail.ca ([64.68.200.34]:47786 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdKAVBg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 17:01:36 -0400
In-Reply-To: <20171025220156.GH2694@lianli.shorne-pla.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>, Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>

On 10/25/2017 04:01 PM, Stafford Horne wrote:
> On Wed, Oct 25, 2017 at 09:51:32AM -0400, Prarit Bhargava wrote:
>> 'cpupower frequency-info -ln' returns kHz values on systems with MHz range
>> minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
>> the command returns
>>
>> hardware limits: 800000 MHz - 4.200000 GHz
>>
>> The code that causes this error can be removed.  The next else if clause
>> will handle the output correctly such that
>>
>> hardware limits: 800.000 MHz - 4.200000 GHz
>>
>> is displayed correctly.
>>
>> [v2]: Remove two lines instead of fixing broken code.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Thomas Renninger <trenn@suse.com>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: Shuah Khan <shuah@kernel.org>
> 
> Reviewed-by: Stafford Horne <shorne@gmail.com>

Thanks for the review.

-- Shuah

> 
>> ---
>>  tools/power/cpupower/utils/cpufreq-info.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
>> index 3e701f0e9c14..df43cd45d810 100644
>> --- a/tools/power/cpupower/utils/cpufreq-info.c
>> +++ b/tools/power/cpupower/utils/cpufreq-info.c
>> @@ -93,8 +93,6 @@ static void print_speed(unsigned long speed)
>>  		if (speed > 1000000)
>>  			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
>>  				((unsigned int) speed%1000000));
>> -		else if (speed > 100000)
>> -			printf("%u MHz", (unsigned int) speed);
>>  		else if (speed > 1000)
>>  			printf("%u.%03u MHz", ((unsigned int) speed/1000),
>>  				(unsigned int) (speed%1000));
>> -- 
>> 2.15.0.rc0.39.g2f0e14e64
>>
> 
> 
