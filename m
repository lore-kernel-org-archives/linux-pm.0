From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data
 pointer
Date: Thu, 4 Feb 2016 17:05:48 +0530
Message-ID: <20160204113548.GG3469@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1876466.AY9fn15fDn@vostro.rjw.lan>
 <20160204053614.GV3469@vireshk>
 <CAHZ_5WxJSDtFyFdCc-D2=HSaPON=3rzUxpxPYsCyZvrV1Nv3qw@mail.gmail.com>
 <20160204082538.GB3469@vireshk>
 <20160204113102.GA17371@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160204113102.GA17371@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 04-02-16, 17:01, Gautham R Shenoy wrote:
> Yes it does! Thank you for the explanation.
> 
> So, the CPUFREQ_HAVE_GOVERNOR_PER_POLICY is really
> CPUFREQ_HAVE_GOVERNOR_TUNERS_PER_POLICY. Can we change the name to
> reflect the intent?

Hmm, we might wanna do that. Though we are quite busy (screwed up) at
the moment, will do that later on :)

-- 
viresh
