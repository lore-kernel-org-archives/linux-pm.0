From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v7.3 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 22 Mar 2018 13:46:49 -0700
Message-ID: <004001d3c21e$e867a3b0$b936eb10$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan> z4Bte42s61Konz4ByelYCQ
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: z4Bte42s61Konz4ByelYCQ
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 2018.03.22 10:40 Rafael J. Wysocki wrote:

...[snip]...

>The difference between this and the original v7 (of patch [5/8]) is
> what happens in menu_update().  This time next_timer_us is checked
> properly and if that is above the tick boundary and a tick wakeup occurs,
> the function simply sets mesured_us to a large constant and uses that to
> update both the correction factor and data->intervals[] (the particular
> value used in this patch was found through a bit of experimentation).
>
> Let's see how this works for Thomas and Doug.

System idle test done for 74 minutes.
After boot and after the system settles down for a couple of minutes,
Processor package power is constant at 3.7 Watts. (great)
Not worth a new graph to show a flat line.

V7.3 average package power = 3.68 Watts.
V7 average package power = 3.68 Watts
V7.2+ average package power = 4.06 Watts (+10%)

> For easier testing there is a git branch containing this patch (and the
> rest of the series) at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  idle-loop-v7.3

Thanks. I used this git branch this time and for the first time.
Much easier.

... Doug
