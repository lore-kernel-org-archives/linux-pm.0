From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Date: Fri, 24 Aug 2018 08:44:35 -0700
Message-ID: <000701d43bc1$5e0c2c50$1a2484f0$@net>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan> t8fgfrW4IttF2t8fhf7XeN
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: t8fgfrW4IttF2t8fhf7XeN
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Leo Yan' <leo.yan@linaro.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.08.24 02:44 Rafael J. Wysocki wrote:
> On Tuesday, August 21, 2018 10:44:10 AM CEST Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
>> stopped tick more aggressively) in the stopped tick case is present
>> when the tick has not been stopped yet too.

... [snip] ...

>> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)

... [snip] ...

> Due to the lack of objections, I'm inclined to queue this up.

I have been following these threads.
Recall that I was involved, over a period of months, in the original
"powernightmare" stuff.
I have revived my tests (and wish I had left myself better notes), and
am establishing a baseline before adding and trying this patch.
My baseline is actually two tests with and without the previous two patches (the ones
that were just sent a couple of days ago in "More power management updates for v4.19-rc1".
I might have those results in some presentable form by later today (it looks O.K.)
Results with this patch will take another couple of days.

... Doug
