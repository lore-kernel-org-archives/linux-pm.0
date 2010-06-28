From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
 wakeup events from being lost
Date: Mon, 28 Jun 2010 15:19:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006281517100.1977-100000__26606.6861142919$1277752857$gmane$org@iolanthe.rowland.org>
References: <201006282101.54041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006282101.54041.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Florian Mickler <florian@mickler.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Jun 2010, Rafael J. Wysocki wrote:

> Below is the patch I'd like to add to suspend-2.6/linux-next.
> 
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Make it possible to avoid wakeup events from being lost
> 
> One of the arguments during the suspend blockers discussion was that
> the mainline kernel didn't contain any mechanisms making it possible
> to avoid losing wakeup events during system suspend.

I don't see anything more to complain about in the patch.  :-)

You probably should change the title and the first paragraph of the 
description to avoid saying that events can get lost.  Like:

PM: Make it possible to avoid races between wakeup and system sleep

Alan Stern
