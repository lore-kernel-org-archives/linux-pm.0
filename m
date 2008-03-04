From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Tue, 4 Mar 2008 16:00:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803041558070.15986-100000__5731.38180557198$1204664766$gmane$org@iolanthe.rowland.org>
References: <200803041230.42152.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803041230.42152.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008, David Brownell wrote:

> > What's wrong with a superfluous probe at resume time, besides the waste 
> > of a few milliseconds?
> 
> I'm more concerned with the undesirable removal of devices at suspend
> time ... ones with mounted filesystems etc.

On that we can agree.  The removal is done if the host doesn't define a 
resume method.  There doesn't seem to be any point to that, given that 
the probing during resume will determine whether a card has in fact 
been removed.

Alan Stern
