From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle
 info
Date: Tue, 15 Apr 2014 15:13:11 +0200
Message-ID: <20140415131311.GM11182@twins.programming.kicks-ass.net>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
 <CAKfTPtC4E=7DxnXZy8bSpeAqyLwsr-oXodXBod2aMc_x4VyqGg@mail.gmail.com>
 <53398FE6.1090203@linaro.org>
 <CAKfTPtBiFUM90igrhz=VnvSkt9MQ2E-xxnzDf=wSKdK+qA4EQA@mail.gmail.com>
 <533A6E3D.4040002@linaro.org>
 <CAKfTPtCH0AhxM8TUeqjnnFVmpLd1D39B4gV2SaWmHX21iLNVuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtCH0AhxM8TUeqjnnFVmpLd1D39B4gV2SaWmHX21iLNVuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alex Shi <alex.shi@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 01, 2014 at 11:05:16AM +0200, Vincent Guittot wrote:
> >> We are working on a bench which can generate middle load pattern with
> >> idle CPUs but it's not available yet. In the mean time, one bench that
> >> plays with idle time is cyclictest, it will not give you performance
> >> results but only scheduling latency which might be what you are
> >> looking for.
> >
> >
> > Yeah, thanks. I believe I know what is in the rt-tests package :)
> >
> > What I meant is what kind of values would you like to see with this patchset
> > ?
> 
> IIUC, you patch tries to improve the wake up latency of a task by
> selecting the CPUs with the shallowest C-state, so this metrics seems
> to be a good candidate

cyclic-test might be too regular to really measure anything though.
