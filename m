From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Runtime PM v17 - Platform Device Bus
	Support
Date: Thu, 20 Aug 2009 01:16:04 +0200
Message-ID: <200908200116.04678.rjw@sisk.pl>
References: <20090815032620.20925.21607.sendpatchset@rx1.opensource.se>
	<20090818221452.GB20676@linux-sh.org>
	<20090819221126.GB28691@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090819221126.GB28691@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 20 August 2009, Greg KH wrote:
> On Wed, Aug 19, 2009 at 07:14:52AM +0900, Paul Mundt wrote:
> > Greg?
> 
> Odd, I don't see this in my inbox, sorry for the delay.
> 
> > On Sun, Aug 16, 2009 at 12:21:18PM +0200, Rafael J. Wysocki wrote:
> > > On Saturday 15 August 2009, Magnus Damm wrote:
> > > > From: Magnus Damm <damm@igel.co.jp>
> > > > 
> > > > This patch adds default Runtime PM callbacks to the dev_pm_ops
> > > > belonging to the platform bus. The callbacks are weak symbols
> > > > that architecture specific code can override.
> > > > 
> > > > Allows Runtime PM even though CONFIG_PM_SLEEP=n.
> > > > 
> > > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > > 
> > > Thanks for the patch.
> > > 
> > > Greg, is it fine with you?
> 
> It's fine with me, Rafael, are you taking this through your tree?

Yup.

> If so, please add:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

I will, thanks!

Rafael
