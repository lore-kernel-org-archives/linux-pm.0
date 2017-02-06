From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftest: cpufreq: Update MAINTAINERS file
Date: Mon, 6 Feb 2017 12:22:58 -0700
Message-ID: <269608a9-83fe-c170-b520-0e1398b39582@kernel.org>
References: <c3cd3310-7a12-134e-3c5a-c5fcacc6821d@kernel.org>
 <ce0bdaab50468d22a46cce3cb04efbb21f467cb6.1484890757.git.viresh.kumar@linaro.org>
 <20170206103852.GJ3131@vireshk-i7>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:46448 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752042AbdBFTXB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 14:23:01 -0500
In-Reply-To: <20170206103852.GJ3131@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>

On 02/06/2017 03:38 AM, Viresh Kumar wrote:
> On 20-01-17, 11:10, Viresh Kumar wrote:
>> Update MAINTAINERS file with cpufreq's selftest directory.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> Hi shuah,
>>
>> Can you please add this one as well along with the code? Thanks.
>>
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c36976d3bd1a..bf414a1a5f82 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3381,6 +3381,7 @@ B:	https://bugzilla.kernel.org
>>  F:	Documentation/cpu-freq/
>>  F:	drivers/cpufreq/
>>  F:	include/linux/cpufreq.h
>> +F:	tools/testing/selftests/cpufreq/
>>  
>>  CPU FREQUENCY DRIVERS - ARM BIG LITTLE
>>  M:	Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Shuah; Can you please add this as well?
> 


Thanks for reminding me. I will pick this up.

-- Shuah
