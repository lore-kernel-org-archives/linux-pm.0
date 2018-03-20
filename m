From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFT][PATCH v7 3/8] sched: idle: Do not stop the tick upfront in the idle loop
Date: Tue, 20 Mar 2018 10:52:12 -0700
Message-ID: <002901d3c074$2e315280$8a93f780$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> yKMSef9P3FfdwyKMYeuPWj
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: yKMSef9P3FfdwyKMYeuPWj
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

I am just trying to catch up. Switching to 4.16-rc6 and
this new patch set.

I think this patch 3/8 is incorrect, and is actually
patch 2/8 repeated.

I'll see if I can just apply the old v5 patch 3/7,
and move on.

On 2018.03.20 08:16 Rafael J. Wysocki wrote:

...[snip]...
