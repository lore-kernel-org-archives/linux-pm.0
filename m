From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Tue, 15 Sep 2015 17:34:29 -0700
Message-ID: <55F8B915.30202@linaro.org>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com> <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org> <20150911110959.GA22876@e105326-lin>
 <55F72773.9090001@linaro.org> <20150915150044.GD3206@e105326-lin>
 <20150915151953.GF16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150915151953.GF16853@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ricky Liang <jcliang@chromium.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 09/15/2015 08:19 AM, Peter Zijlstra wrote:
> Please flip the argument around; providing lots of knobs for vendors to
> do $magic with is _NOT_ a good thing.
> 
> The whole out-of-tree cpufreq governor hack fest Android thing is a
> complete and utter fail on all levels. Its the embedded, ship, forget,
> not contribute cycle all over again.
> 
> Making that harder is a _GOOD_ thing.

I get why the plugin-like governor interface may encourage out of tree
development, but why would providing lots of policy knobs/tunables from
the scheduler be bad?

Shouldn't that hopefully reduce the likelihood that someone feels the
need to roll their own stack of kernel modifications which never make it
upstream?

cheers,
Steve
