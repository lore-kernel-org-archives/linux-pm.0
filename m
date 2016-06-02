From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
Date: Thu, 02 Jun 2016 22:08:27 +1000
Message-ID: <1464869307.31709.1.camel@ellerman.id.au>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
	 <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
	 <1464865688.11826.1.camel@ellerman.id.au>
	 <20160602112203.GO3725@vireshk-i7>
	 <1464867465.11826.4.camel@ellerman.id.au>
	 <20160602114311.GR3725@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602114311.GR3725@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linaro-kernel@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-06-02 at 17:13 +0530, Viresh Kumar wrote:
> On 02-06-16, 21:37, Michael Ellerman wrote:
> > On Thu, 2016-06-02 at 16:52 +0530, Viresh Kumar wrote:
> > > On 02-06-16, 21:08, Michael Ellerman wrote:
> > > > On Wed, 2016-06-01 at 16:04 +0530, Viresh Kumar wrote:
> > > > 
> > > > > The policy is copied (unnecessarily) and is never freed. Fix it by just
> > > > > getting a reference to the existing policy structure and putting it
> > > > > back.
> > > > > 
> > > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > 
> > > > When was it broken, always?
> > > > 
> > > > Cc: stable ?
> > > 
> > > Its a small memory leak and its not that we will fail on something. So
> > > didn't bother to add those details, but in case they are required:
> > > 
> > > Cc: <stable@vger.kernel.org> # 4.3+
> > > Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> > 
> > OK. I can't actually see where the copy is?
> > 
> > But if we are leaking even a small amount of memory in a loop like that, in a
> > function that's run semi-regularly, then it's going to add up eventually.
> 
> Urg, it wasn't a memory leak actually. I misread.
> 
> I somehow thought that cpufreq_get_policy() is also allocating memory
> for the policy, but it just memcpy's it into the callers buffer. So,
> that's not a problem really.
> 
> This patch should be just dropped. Sorry for the noise.

OK, no worries.

cheers
