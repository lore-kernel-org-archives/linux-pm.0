From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
	wakeup events from being lost
Date: Mon, 28 Jun 2010 23:19:27 +0200
Message-ID: <201006282319.27758.rjw__21809.2315401465$1277760205$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006281517100.1977-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006281517100.1977-100000@iolanthe.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 28, 2010, Alan Stern wrote:
> On Mon, 28 Jun 2010, Rafael J. Wysocki wrote:
> 
> > Below is the patch I'd like to add to suspend-2.6/linux-next.
> > 
> > Rafael
> > 
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM: Make it possible to avoid wakeup events from being lost
> > 
> > One of the arguments during the suspend blockers discussion was that
> > the mainline kernel didn't contain any mechanisms making it possible
> > to avoid losing wakeup events during system suspend.
> 
> I don't see anything more to complain about in the patch.  :-)

Great! :-)

> You probably should change the title and the first paragraph of the 
> description to avoid saying that events can get lost.  Like:
> 
> PM: Make it possible to avoid races between wakeup and system sleep

I will, thanks!

Rafael
