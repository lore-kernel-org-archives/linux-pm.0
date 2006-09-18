From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [linux-pm] [RFC] CPUFreq PowerOP integration, Centrino PM Core
 and OPs registration 2/3
Date: Mon, 18 Sep 2006 15:16:59 +0400
Message-ID: <450E802B.800@gmail.com>
References: <45096C1A.7010008@gmail.com> <20060918104624.GB4973@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932246AbWIRLQl@vger.kernel.org>
In-Reply-To: <20060918104624.GB4973@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> +/* 
>> + * FIXME: very temporary implementation, just to prove the concept !! 
>> + */
>> +static int 
>> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
>> +		  int va_arg)
> 
> Ok, so can we get final implementation? Parsing strings in drivers is
> evil...
ok, i saw this your comment when you mentioned it for the first time and I 
explicitly put it in TODO letter sent along with the patchset.

Can you instead of such implementation details try to review and give us your 
comments if any on interfaces approach and namely on cpufreq/PowerOP integration 
at cpufreq_driver layer; comments _based_ on the code. The issue with string 
parsing does not affect cpufreq/PowerOP integration interfaces since currently I 
keep going with parameter names(strings) interface for PowerOP Core regardless 
of whether parsing will eventually occur - at PM Core or POwerOP Core.

	Eugeny
> 
> 									Pavel
> 
