From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Sat, 17 Mar 2018 09:11:53 -0700
Message-ID: <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> xBBLeKgi1FfdwxBBQedJaO
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: xBBLeKgi1FfdwxBBQedJaO
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Peter Zijlstra' <peterz@infradead.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>
Cc: 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.17 Thomas Ilsche wrote:

> Over the last week I tested v4+pollv2 and now v5+pollv3. With v5, I
> observe a particular idle behavior, that I have not seen before with
> v4. On a dual-socket Skylake system the idle power increases from
> 74.1 W (system total) to 85.5 W with a 300 HZ build and even to
> 138.3 W with a 1000 HZ build. A similar Haswell-EP system is also
> affected.

I confirm your idle findings. There is a regression between V4 and V5.
The differences on my test computer are much less than on yours,
probably because I have only 8 CPUs.

http://fast.smythies.com/rjw_idle.png

1000 Hz kernel only.

... Doug
