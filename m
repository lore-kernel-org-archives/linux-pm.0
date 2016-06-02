From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/2] cpufreq: Optimize cpufreq_frequency_table_target()
Date: Thu, 2 Jun 2016 06:59:04 +0530
Message-ID: <20160602012904.GV3725@vireshk-i7>
References: <cover.1464777376.git.viresh.kumar@linaro.org>
 <120ed8a873b6df2ccc9406eeec8f8f74e5f9b0d5.1464777376.git.viresh.kumar@linaro.org>
 <20160601194615.GQ9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160601194615.GQ9864@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 01-06-16, 12:46, Steve Muckle wrote:
> >  	/*
> >  	 * Find the closest frequency above target_freq.
> > -	 *
> > -	 * The table is sorted in the reverse order with respect to the
> > -	 * frequency and all of the entries are valid (see the initialization).
> >  	 */
> > -	entry = policy->freq_table;
> > -	do {
> > -		entry++;
> > -		freq = entry->frequency;
> > -	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
> > -	entry--;
> > +	index = cpufreq_frequency_table_target(policy, target_freq,
> > +					       CPUFREQ_RELATION_L);
> 
> This adds a function call to the fast path...

I understand that, but I am not sure how far should we go to avoid
that. Open coding routines to save on that isn't a good idea surely.

I have at least kept this routine in cpufreq.h to avoid a call, but
eventually we will have at least a call somewhere within it. :(

-- 
viresh
