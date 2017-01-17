From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/4] selftest: cpufreq: Add support for cpufreq framework
Date: Tue, 17 Jan 2017 14:00:00 -0700
Message-ID: <ca6812e9-88be-17b0-be3c-47681ab0653b@kernel.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
 <bde954c8-d581-aa9d-a64d-2ca94e794f2f@kernel.org>
 <20170116034815.GJ9953@vireshk-i7>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:58401 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751015AbdAQVCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 16:02:03 -0500
In-Reply-To: <20170116034815.GJ9953@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>

On 01/15/2017 08:48 PM, Viresh Kumar wrote:
> On 13-01-17, 15:35, Shuah Khan wrote:
>> Could you please add .gitignore for generated files. You can
>> send that as a separate patch and don't have to resend the
>> series.
> 
> Hi Shuah,
> 
>>>  tools/testing/selftests/Makefile                 |   1 +
>>>  tools/testing/selftests/cpufreq/Makefile         |   8 +
>>>  tools/testing/selftests/cpufreq/cpu.sh           |  84 ++++++++
>>>  tools/testing/selftests/cpufreq/cpufreq.sh       | 241 ++++++++++++++++++++++
>>>  tools/testing/selftests/cpufreq/governor.sh      | 153 ++++++++++++++
>>>  tools/testing/selftests/cpufreq/main.sh          | 194 ++++++++++++++++++
>>>  tools/testing/selftests/cpufreq/module.sh        | 243 +++++++++++++++++++++++
>>>  tools/testing/selftests/cpufreq/special-tests.sh | 115 +++++++++++
> 
> All I have are .sh files and no intermediate files are generated.
> Perhaps I don't need any .gitignore entries ?
> 

Never mind. There is no need to do .gitignore.

thanks,
-- Shuah
