From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sat, 10 Mar 2018 23:43:02 -0800
Message-ID: <001801d3b90c$99232600$cb697200$@net>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <007c01d3b843$3d825e70$b8871b50$@net> <000701d3b889$eadd5340$c097f9c0$@net> uoK1eZIXBFfdwuoK6ezbfC
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: uoK1eZIXBFfdwuoK6ezbfC
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Rik van Riel' <riel@surriel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
>On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
>> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
>
... [snip] ...

> The information that they often spend more time than a tick
> period in state 0 in one go *is* relevant, though.
>
>
> That issue can be dealt with in a couple of ways and the patch below is a
> rather straightforward attempt to do that.  The idea, basically, is to discard
> the result of governor prediction if the tick has been stopped alread and
> the predicted idle duration is within the tick range.
>
> Please try it on top of the v3 and tell me if you see an improvement.

It seems pretty good so far.
See a new line added to the previous graph, "rjwv3plus".

http://fast.smythies.com/rjwv3plus_100.png

I'll do another 100% load on one CPU test overnight, this time with
a trace.

... Doug
