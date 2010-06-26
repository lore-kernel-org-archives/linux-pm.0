From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
	from being lost
Date: Sat, 26 Jun 2010 20:21:42 +0200
Message-ID: <201006262021.42966.rjw__47237.6314261512$1277576633$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006261258140.22018-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006261258140.22018-100000@netrider.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, June 26, 2010, Alan Stern wrote:
> On Sat, 26 Jun 2010, David Brownell wrote:
... 
> > > +        The
> > > /sys/power/wakeup_count file allows user space to avoid
> > > +        losing wakeup events
> > > when transitioning the system into a sleep
> > > +        state.  Reading
> 
> This could have been phrased better:  The /sys/power/wakeup_count file
> allows user space to put the system into a sleep state conditionally
> subject to the arrival of concurrent wakeup events, which will either
> block the sleep transition or cause it to fail.

I'll chage this in the final version.  Thanks!

Rafael
