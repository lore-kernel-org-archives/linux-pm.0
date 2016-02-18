From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness is scaled
Date: Thu, 18 Feb 2016 13:09:26 -0800
Message-ID: <001101d16a90$a7a26e10$f6e74a30$@net>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net> <CAJZ5v0hSLJRkOKQ0UvJsSs0o-NuHiE+gOnC+f0q8vQtciABP2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta12.telus.net ([209.171.16.85]:34200 "EHLO cmta12.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965499AbcBRVJb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Feb 2016 16:09:31 -0500
In-Reply-To: <CAJZ5v0hSLJRkOKQ0UvJsSs0o-NuHiE+gOnC+f0q8vQtciABP2Q@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Mel Gorman' <mgorman@techsingularity.net>
Cc: 'Rafael Wysocki' <rjw@rjwysocki.net>, 'Ingo Molnar' <mingo@kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Matt Fleming' <matt@codeblueprint.co.uk>, 'Mike Galbraith' <umgwanakikbuti@gmail.com>, 'Linux-PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On 2106.02.18 Rafael J. Wysocki wrote:
On Thu, Feb 18, 2016 at 12:11 PM, Mel Gorman wrote:
>>
>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index cd83d477e32d..54250084174a 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -999,7 +999,7 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
>>         sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
>>         duration_us = ktime_us_delta(cpu->sample.time,
>>                                      cpu->last_sample_time);
>> -       if (duration_us > sample_time * 3) {
>> +       if (duration_us > sample_time * 12) {
>>                 sample_ratio = div_fp(int_tofp(sample_time),
>>                                       int_tofp(duration_us));
>>                 core_busy = mul_fp(core_busy, sample_ratio);
>> --

The immediately preceding comment needs to be changed also.
Note that with duration related scaling only coming in at such a high
ratio it might be worth saving the divide and just setting it to 0.

> I've been considering making a change like this, but I wasn't quite
> sure how much greater the multiplier should be, so I've queued this
> one up for 4.6.

> That said please note that we're planning to make one significant
> change to intel_pstate in the 4.6 cycle that's very likely to affect
> your results.

Rafael:

I started to test Mel's change added to your 3 patch set version 10.

I only have one data point so far, I selected the test I did from one of Mel's
better results (although there is no reason to expect my computer to have
best results for the same operating conditions):

Stock kernel 4.5-rc4 just for reference:
Linux s15 4.5.0-040500rc4-generic #201602141731 SMP Sun Feb 14 22:33:37 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

        Command line used: iozone -s 401408 -r 32 -f bla.bla -i 0
        Output is in Kbytes/sec

              KB  reclen   write rewrite
          401408      32 1895293 3035291
_________________________________________________________________

Kernel 4.5-rc4 + jrw 3 patch set version 10  (nominal 3X duration holdoff)
Linux s15 4.5.0-rc4-rjwv10 #167 SMP Mon Feb 15 14:23:10 PST 2016 x86_64 x86_64 x86_64 GNU/Linux

        Command line used: iozone -s 401408 -r 32 -f bla.bla -i 0
        Output is in Kbytes/sec

              KB  reclen   write rewrite
          401408      32 2010558 3086354
          401408      32 1945126 3127472
          401408      32 1944807 3110387
          401408      32 1948620 3110002
                     AVE 1962278 3108554

Performance mode, for comparison:

              KB  reclen   write rewrite
          401408      32 2870111 5023311
          401408      32 2869642 5149213
          401408      32 2792053 5100280
          401408      32 2863887 5149229
_________________________________________________________________

Kernel 4.5-rc4 + jrw 3 patch set version 10 + mg 12X duration hold-off
Linux s15 4.5.0-rc4-rjwv10-12 #169 SMP Thu Feb 18 08:15:33 PST 2016 x86_64 x86_64 x86_64 GNU/Linux

        Command line used: iozone -s 401408 -r 32 -f bla.bla -i 0
        Output is in Kbytes/sec

              KB  reclen   write rewrite
          401408      32 1989670 3100580
          401408      32 2062291 3112463
          401408      32 2107637 3233567
          401408      32 2111772 3340610
                     AVE 2067843 3196805
          Gain Verses 3X    5.4%    2.8%
_________________________________________________________________

Mel: Did you observe any downside conditions?

For example, here is just an example taken some trace samples from my computer:

Duration kick in = 3X
Core busy = 101
Current pstate = 16
Load = 2.2%
Duration = 43.815 mSec
Scaled busy = 48
Next Pstate = 16 (= minimum for my computer)

If duration kick in = 12X then
Scaled busy = 214
Next pstate = 38 (= Max turbo for my computer)

Note: I do NOT have an operational example where it matters in terms
of energy use or whatever. I just suggesting that we look.

... Doug


