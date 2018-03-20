From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Tue, 20 Mar 2018 11:52:37 +0100
Message-ID: <1726729.vkejFNOM44@aspire.rjw.lan>
References: <000f01d3bba5$3cba5a00$b62f0e00$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000f01d3bba5$3cba5a00$b62f0e00$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 14, 2018 4:00:44 PM CET Doug Smythies wrote:
> On 2018.03.14 07:09 Rafael J. Wysocki wrote:
> 
> ... [snip]...
> 
> > v2 -> v3: Use local_clock() for time measurements and drop the
> >          counter, since that should be lightweight enough (as
> >          suggested by Peter).
> 
> I have been testing the latest of everything for a couple of days
> now, and everything continues to be great.

Due to the lack of any further comments from anyone, I have queued up this
patch with a Tested-by from you.

Thanks!
