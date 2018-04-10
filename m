From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 00/10] sched/cpuidle: Idle loop rework
Date: Tue, 10 Apr 2018 09:03:43 +0200
Message-ID: <380836701.aBTtZlsN1h@aspire.rjw.lan>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <1607755.Sz6cLBVOsW@aspire.rjw.lan> <a2c05878-e112-9f6c-3da2-5c75ba38abc4@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2c05878-e112-9f6c-3da2-5c75ba38abc4@tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, April 9, 2018 5:58:32 PM CEST Thomas Ilsche wrote:
> 
> --------------ms020002070802070802040704
> Content-Type: text/plain; charset=utf-8; format=flowed
> Content-Language: en-US
> Content-Transfer-Encoding: quoted-printable
> 
> On 2018-04-08 18:32, Rafael J. Wysocki wrote:
> > The v9 along with some cleanups suggested by Frederic on top of it and =
> with
> > ACKs from Peter (obtained on IRC) is now available from the pm-cpuidle =
> branch
> > in the linux-pm.git tree.
> >=20
> > It has been added to my linux-next branch, so it probably will be picke=
> d up by
> > linux-next tomorrow and I have a plan to push it for v4.17 in the secon=
> d half
> > of the next week unless a major issue with it is found in the meantime.=
> 
> 
> Great to hear that. Thanks for all your work.

You're very welcome!

> I'm finishing up some analysis of corner cases, but nothing major.
> So I'm glad to see this is moving along. I've been nitpicking a lot,
> but this is clearly a huge improvement and there are practical
> limitations against a theoretically perfect solution. In any case the
> changes will also make future policy adaptions much easier.

Thanks for your feedback, it would have taken much more time to get to this
point without it.

Thanks,
Rafael
