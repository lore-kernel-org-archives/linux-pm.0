From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
	events during suspend
Date: Fri, 25 Jun 2010 15:28:19 +0200
Message-ID: <201006251528.19898.rjw__24289.0395726592$1277472697$gmane$org@sisk.pl>
References: <201006241819.25055.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1006241257410.1654-100000@iolanthe.rowland.org>
	<20100625084056.188ba96d@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100625084056.188ba96d@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 25, 2010, Florian Mickler wrote:
> On Thu, 24 Jun 2010 13:09:27 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > > > This requires you to define an explicit PCI_WAKEUP_COOLDOWN delay.  I 
> > > > think that's okay; I had to do something similar with USB and SCSI.  
> > > > (And I still think it would be a good idea to prevent workqueue threads 
> > > > from freezing until their queues are empty.)
> 
> I'm not that familiar with the freezer, but couldn't it be
> deadlocky if the work depends on some already frozen part?

No, in the case of freezable workqueues (which is the one we're discussing)
they generally can't depend on anything freezable, because it's never known
which freezable tasks will be frozen first.

> What about a new work-type that calls
> pm_relax() after executing it's workfunction and executing
> pm_stay_awake() on enqueue?

That might be useful., although it doesn't really help here, because there
still is a window between queuing up a work item and executing it.

Rafael
