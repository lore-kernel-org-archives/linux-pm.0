From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Date: Tue, 19 Jun 2018 16:04:01 +0530
Message-ID: <20180619103401.s3grdcm2hq6kx2pm@vireshk-i7>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
 <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
 <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
 <20180619085407.nmos7tix77vnaqre@vireshk-i7>
 <82d0646e-8dd7-43ba-6b5d-b772e57e865d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82d0646e-8dd7-43ba-6b5d-b772e57e865d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 19-06-18, 15:55, Taniya Das wrote:
> Yes, Viresh, earlier code was updating the table frequency as I was marking
> the table frequency INVALID.
> 	if (core_count != c->max_cores)	
> 		c->table[i].frequency = CPUFREQ_ENTRY_INVALID;	
> 
> And thus I had to update the table frequency.
> 
> But now I have used the cur_freq instead and the table frequency is not
> touched.
> 	if (core_count != c->max_cores)
> 		cur_freq = CPUFREQ_ENTRY_INVALID;

Unless I am reading your versions incorrectly, they behave differently.

Until V2, if core_count wasn't equal to max_cores then the frequency was getting
marked as INVALID straight away in the table itself. Now if the next freq is
also same then you abort and overwrite the previous one as valid, but otherwise
it remains INVALID for ever. And this last thing doesn't happen anymore.

So if in your table there are few frequency entries which aren't repeating, but
the core_count != max_cores for some of them, they remain valid in the newer
versions.

-- 
viresh
