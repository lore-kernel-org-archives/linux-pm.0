From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Thu, 1 Jul 2010 10:42:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007011010220.1596-100000@iolanthe.rowland.org>
References: <1277944121.3994.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277944121.3994.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 1 Jul 2010, Maxim Levitsky wrote:

> On Thu, 2010-07-01 at 01:40 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 01, 2010, Maxim Levitsky wrote:
> > > Hi,
> > > 
> > > 
> > > This is my desktop, and I don't use it much.
> > > I updated the kernel from 2.6.33 to 2.6.35-rc3, and my usb mouse (usb
> > > 1.1 of course) doesn't wake the system anymore.
> > 
> > Please wait for 2.6.35-rc4 to appear and see if there's any difference.
> Why should I?
> I always compile from git.
> Just pulled Linus' tree, and nothing changed.

On my system there's no problem -- but my development tree isn't
vanilla 2.6.35-rc3.  Note, however, that with my Microsoft USB optical
mouse I have to use _two_ button clicks to wake up the system.  One
click isn't enough -- I don't know why.

Enabling power/wakeup for the 0000:00:1d.0 and 5-1 devices should be 
all you need to do.  It should already be enabled by default for the 
usb5 device.

You _might_ find that this patch helps:

	http://marc.info/?l=linux-usb&m=127748897212461&w=2

although since it worked okay in 2.6.33, I doubt the patch will make 
any difference.

In fact, you're in a very good position to use git bisect.  I would be 
curious to know the exact change responsible for this regression.

Alan Stern
