From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/4] selftest: cpufreq: Add support for cpufreq framework
Date: Thu, 19 Jan 2017 10:36:36 -0700
Message-ID: <c3cd3310-7a12-134e-3c5a-c5fcacc6821d@kernel.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
 <bde954c8-d581-aa9d-a64d-2ca94e794f2f@kernel.org>
 <20170116034815.GJ9953@vireshk-i7>
 <ca6812e9-88be-17b0-be3c-47681ab0653b@kernel.org>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ca6812e9-88be-17b0-be3c-47681ab0653b@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/17/2017 02:00 PM, Shuah Khan wrote:
> On 01/15/2017 08:48 PM, Viresh Kumar wrote:
>> On 13-01-17, 15:35, Shuah Khan wrote:
>>> Could you please add .gitignore for generated files. You can
>>> send that as a separate patch and don't have to resend the
>>> series.
>>
>> Hi Shuah,
>>
>>>>  tools/testing/selftests/Makefile                 |   1 +
>>>>  tools/testing/selftests/cpufreq/Makefile         |   8 +
>>>>  tools/testing/selftests/cpufreq/cpu.sh           |  84 ++++++++
>>>>  tools/testing/selftests/cpufreq/cpufreq.sh       | 241 ++++++++++++++++++++++
>>>>  tools/testing/selftests/cpufreq/governor.sh      | 153 ++++++++++++++
>>>>  tools/testing/selftests/cpufreq/main.sh          | 194 ++++++++++++++++++
>>>>  tools/testing/selftests/cpufreq/module.sh        | 243 +++++++++++++++++++++++
>>>>  tools/testing/selftests/cpufreq/special-tests.sh | 115 +++++++++++
>>
>> All I have are .sh files and no intermediate files are generated.
>> Perhaps I don't need any .gitignore entries ?
>>
> 
> Never mind. There is no need to do .gitignore.
> 

Thanks for these tests. Applied the series to linux-kselftest next
for 4.11

thanks,
-- Shuah
