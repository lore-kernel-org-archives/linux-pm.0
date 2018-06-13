From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Wed, 13 Jun 2018 14:40:47 +0530
Message-ID: <20180613091047.mfhtgrdypx2qvndp@vireshk-i7>
References: <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
 <20180612173514.GV12217@hirez.programming.kicks-ass.net>
 <20180613085509.s7ktdespfyjpozuu@vireshk-i7>
 <b9dba62b-35df-46a9-a66c-3ec0952109b6@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b9dba62b-35df-46a9-a66c-3ec0952109b6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-pm@vger.kernel.org

On 13-06-18, 11:03, Daniel Lezcano wrote:
> nr_threads(smpboot) <> nr_threads(idleinject)
> 
> If we are facing races issues, it is because we are trying to avoid
> using locks in the code path. With lock and proper refcounting that
> should be solved, AFAICT there are similar races with inodes.

I am not sure if locking can make things better here. We aren't using them as we
don't really need them AFAIU :)

-- 
viresh
