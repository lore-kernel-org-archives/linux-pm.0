From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Date: Thu, 22 Mar 2018 12:11:33 -0700
Message-ID: <003f01d3c211$9a094e10$ce1bea30$@net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan>  <20180314120450.GT4043@hirez.programming.kicks-ass.net> z38ge3YFh1Konz38iel45g
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: z38ge3YFh1Konz38iel45g
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Rik van Riel' <riel@surriel.com>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.22 09:32 Rik van Riel wrote:
> On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
>
>> On x86 we don't have to use that time_check_counter thing,
>> sched_clock()
>> is really cheap, not sure if it makes sense on other platforms.
>
> Are you sure? I saw a 5-10% increase in CPU use,
> for a constant query rate to a memcache style
> workload, with v3 of this patch.

I would very much like to be able to repeat your test results.
However, I am not sure what you mean by "memcache style workload".
Is there a test you can point me to? Say a Phoronix type test, for example.

All of my tests with the V3 of this patch have been fine.

... Doug
