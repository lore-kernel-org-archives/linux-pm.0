From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Towards eliminating the freezer
Date: Thu, 26 Jul 2007 15:32:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707261521590.3043-100000@iolanthe.rowland.org>
References: <200707251423.08254.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707251423.08254.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 25 Jul 2007, Rafael J. Wysocki wrote:

> > > So, who's writing the patch? ;-)
> > 
> > I can do it.  You haven't made any changes to this part of the code, 
> > have you?
> 
> Yes, I have, quite recently. :-)
> 
> > My work tends to be based on Linus's tree, not -mm. 
> 
> At the moment they are pretty much in line, at least as far as this code is
> concerned.  Anyway, I'm trying to keep track of PM-related patches,
> at http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc1/

I got your snapshot file.  None of the patches in it modify anything
in drivers/base/power/*, so there shouldn't be any interference.

By the way, just checking: Apparently when device_power_down() in 
suspend.c calls sysdev_suspend(), if there's an error it doesn't then 
call dpm_power_up().  Is it correct to assume this is a bug?

Alan Stern
