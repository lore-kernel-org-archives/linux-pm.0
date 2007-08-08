From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] uli526x: Add suspend and resume routines
Date: Wed, 8 Aug 2007 14:05:00 +0200
Message-ID: <200708081405.00778.rjw__14480.3168172531$1186574224$gmane$org@sisk.pl>
References: <200708052114.01790.rjw@sisk.pl>
	<20070807160357.d6ea9731.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070807160357.d6ea9731.akpm@linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 8 August 2007 01:03, Andrew Morton wrote:
> On Sun, 5 Aug 2007 21:14:01 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +
> > +/*
> > + *	Suspend the interface.
> > + */
> > +
> > +static int uli526x_suspend(struct pci_dev *pdev, pm_message_t state)
> 
> Since when did suspend and resume methods become dependent upon CONFIG_PM_SLEEP?
> 
> We have eight thousand implementations of this, all of which presently
> use CONFIG_PM.

Yes, they do, but if CONFIG_PM_SLEEP is not set, they won't be used.

Greetings,
Rafael
