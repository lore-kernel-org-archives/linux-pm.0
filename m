From: Florian Mickler <florian@mickler.org>
Subject: Re: [update 2] Re: [RFC][PATCH] PM: Avoid losing wakeup
 events during suspend
Date: Fri, 25 Jun 2010 08:40:56 +0200
Message-ID: <20100625084056.188ba96d__39184.5508981079$1277448162$gmane$org@schatten.dmk.lab>
References: <201006241819.25055.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1006241257410.1654-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006241257410.1654-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 24 Jun 2010 13:09:27 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> > > This requires you to define an explicit PCI_WAKEUP_COOLDOWN delay.  I 
> > > think that's okay; I had to do something similar with USB and SCSI.  
> > > (And I still think it would be a good idea to prevent workqueue threads 
> > > from freezing until their queues are empty.)

I'm not that familiar with the freezer, but couldn't it be
deadlocky if the work depends on some already frozen part?

What about a new work-type that calls
pm_relax() after executing it's workfunction and executing
pm_stay_awake() on enqueue?


Cheers,
Flo
