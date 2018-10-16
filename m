From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] tools/power/cpupower: fix compilation with STATIC=true
Date: Tue, 16 Oct 2018 08:28:47 -0600
Message-ID: <4a4cb4dc-16d7-7f71-eb99-d4b1e7788862@kernel.org>
References: <153968018626.397151.17942194042449956995.stgit@buzz>
 <2028892.8FmI4CMcI5@house>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2028892.8FmI4CMcI5@house>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/16/2018 05:39 AM, Thomas Renninger wrote:
> On Tuesday, October 16, 2018 10:56:26 AM CEST Konstantin Khlebnikov wrote:
>> Rename duplicate sysfs_read_file into cpupower_read_sysfs and fix linking.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Acked-by: Thomas Renninger <trenn@suse.de>
> 
> Thanks!
> 
>> -       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
>> +       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
> 
> I also looked at this and would only have fixed half of it (overseeing above
> old leftover from cpupower lib introduction).
> I guess, this patch from Konstantin is better and the correct solution.
> 

Thank you both. I will get this into 4.20-rc1 or rc2 depending on how timing
works.

I think this applies to stable as well.

thanks,
-- Shuah
