From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RESEND] cpupower: Fix no-rounding MHz frequency output
Date: Wed, 25 Oct 2017 09:41:52 -0400
Message-ID: <76a2402d-d1d7-5d74-b572-dbe5a8915965@redhat.com>
References: <20171023115632.27998-1-prarit@redhat.com>
 <20171023123539.GF2694@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbdJYNlx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Oct 2017 09:41:53 -0400
In-Reply-To: <20171023123539.GF2694@lianli.shorne-pla.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>



On 10/23/2017 08:35 AM, Stafford Horne wrote:
> On Mon, Oct 23, 2017 at 07:56:32AM -0400, Prarit Bhargava wrote:
>> Sent about a year ago ...
>>
>> P.
>>
>> ---8<---
>>
>> 'cpupower frequency-info -ln' returns kHz values on systems with MHz range
>> minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
>> the command returns
>>
>> hardware limits: 800000 MHz - 4.200000 GHz
>>
>> The value of speed passed into print_speed is in kHz, so divide speed by
>> 1000 in the MHz else-if section to get MHz.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Thomas Renninger <trenn@suse.com>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> ---
>>  tools/power/cpupower/utils/cpufreq-info.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
>> index 3e701f0e9c14..fe7c25147b3a 100644
>> --- a/tools/power/cpupower/utils/cpufreq-info.c
>> +++ b/tools/power/cpupower/utils/cpufreq-info.c
>> @@ -94,7 +94,7 @@ static void print_speed(unsigned long speed)
>>  			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
>>  				((unsigned int) speed%1000000));
>>  		else if (speed > 100000)
>> -			printf("%u MHz", (unsigned int) speed);
>> +			printf("%u MHz", (unsigned int) speed/1000);
> 
> This looks ok to me, but can't we just remove this condition and depend on the
> condition with the decimal point below?
> 
> -Stafford
> 
>>  		else if (speed > 1000)
>>  			printf("%u.%03u MHz", ((unsigned int) speed/1000),
>>  				(unsigned int) (speed%1000));

Yeah we can.  I think I made a cut-and-paste error when I originally did this
code.  I'll submit a v2 to clean that up.

P.


>> -- 
>> 2.15.0.rc0.39.g2f0e14e64
>>
