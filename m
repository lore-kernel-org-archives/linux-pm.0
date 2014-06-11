From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 07:27:12 -0700
Message-ID: <009c01cf8581$3d75a7f0$b860f7d0$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <009b01cf857a$d5032090$7f0961b0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta4.telus.net ([209.171.16.77]:35014 "EHLO cmta4.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbaFKO1Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Jun 2014 10:27:16 -0400
In-Reply-To: <009b01cf857a$d5032090$7f0961b0$@net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com


On 2014.06.11 06:42 Doug Smythies wrote:
On 2014.06.11 05:34 Stratos Karafotis wrote:

>> 	if ((rem << 1) >= int_tofp(sample->mperf))
>> -		core_pct += 1;
>> +		core_pct += int_tofp(1);
>> 
>> 	sample->freq = fp_toint(
>> 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
>> -- 
>> 1.9.3

> No.

> The intent was only ever to round properly the pseudo floating
> point result of the divide.
> It was much more important (ugh, well 4 times more) when
> FRACBITS was still 6, which also got changed to 8 in a recent
> patch.

I forgot to mention there are other related roundings that are being considered.
I do not recall clearly, but I think Dirk and I agreed to hold off until
the recent panics had settled.

The analysis as to the importance needs to be re-done, as it was all done when FRACBITS was 6. Things were very "chunky" when
FRACBITS was 6.

These are what I was considering putting forward:

static inline int32_t fp_toint(int32_t x)
{
        if (x >= 0)
                x +=  (1 << (FRAC_BITS -1));
         else
                x -=  (1 << (FRAC_BITS -1));
        return (x >> FRAC_BITS);
}

static inline int32_t mul_fp(int32_t x, int32_t y)
{
        int64_t temp;
        temp = (int64_t)x * (int64_t)y;
        if (temp >= 0)
                temp +=  (1 << (FRAC_BITS -1));
         else
                temp -=  (1 << (FRAC_BITS -1));
        return (temp >> FRAC_BITS);
}

static inline int32_t div_fp(int32_t x, int32_t y)
{

        /* currently, there are only positive numbers to worry about here */

        int32_t rem;

        x = div_s64_rem((int64_t)x << FRAC_BITS, (int64_t)y, &rem);
        if((rem << 1) >= y) x++;
        return(x);
}


