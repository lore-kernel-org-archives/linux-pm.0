From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Sun, 18 Mar 2018 08:30:29 -0700
Message-ID: <000801d3bece$0e4b9090$2ae2b1b0$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net> xW2zeQ0g8FfdwxW30ehIAY
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: xW2zeQ0g8FfdwxW30ehIAY
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.18 04:01 Rafael J. Wysocki wrote:

> Below is a drop-in v6 replacement for patch [4/7].
>
> With this new patch applied instead of the [4/7] the behavior should be much
> more in line with the v4 behavior, so please try it if you can and let me know
> if that really is the case on your systems.

Yes, the idle power is back down to V4 levels. (I did not do a new graph).

Some other data from this week (7 patch set + poll fix verses kernel 4.16-rc5):

pipe-test: The not cross core test is the most dramatic. Using CPU's 3 and 7,
or core 3, uses 6% less power and 18% performance improvement.

Graphs:
http://fast.smythies.com/pipe-test-one-core-power.png
http://fast.smythies.com/pipe-test-one-core-times.png

A couple of Phoronix tests (I didn't get very far yet):
himeno: 11% performance improvement; 14% less power.
compress-lzma: small performance improvement; small power improvement.
mafft: performance similar; small power improvement.

... Doug
