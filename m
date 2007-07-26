From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Towards eliminating the freezer
Date: Thu, 26 Jul 2007 22:54:16 +0200
Message-ID: <200707262254.16921.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707261521590.3043-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707261521590.3043-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 26 July 2007 21:32, Alan Stern wrote:
> On Wed, 25 Jul 2007, Rafael J. Wysocki wrote:
> 
> > > > So, who's writing the patch? ;-)
> > > 
> > > I can do it.  You haven't made any changes to this part of the code, 
> > > have you?
> > 
> > Yes, I have, quite recently. :-)
> > 
> > > My work tends to be based on Linus's tree, not -mm. 
> > 
> > At the moment they are pretty much in line, at least as far as this code is
> > concerned.  Anyway, I'm trying to keep track of PM-related patches,
> > at http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc1/
> 
> I got your snapshot file.  None of the patches in it modify anything
> in drivers/base/power/*, so there shouldn't be any interference.

I think that's correct.

> By the way, just checking: Apparently when device_power_down() in 
> suspend.c calls sysdev_suspend(), if there's an error it doesn't then 
> call dpm_power_up().  Is it correct to assume this is a bug?

Yes.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
