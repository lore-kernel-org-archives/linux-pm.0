From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] PM: Runtime PM v17 - Platform Device Bus
	Support
Date: Wed, 19 Aug 2009 15:11:26 -0700
Message-ID: <20090819221126.GB28691@suse.de>
References: <20090815032620.20925.21607.sendpatchset@rx1.opensource.se>
	<200908161221.18288.rjw@sisk.pl>
	<20090818221452.GB20676@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090818221452.GB20676@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, stern@rowland.harvard.edu
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 07:14:52AM +0900, Paul Mundt wrote:
> Greg?

Odd, I don't see this in my inbox, sorry for the delay.

> On Sun, Aug 16, 2009 at 12:21:18PM +0200, Rafael J. Wysocki wrote:
> > On Saturday 15 August 2009, Magnus Damm wrote:
> > > From: Magnus Damm <damm@igel.co.jp>
> > > 
> > > This patch adds default Runtime PM callbacks to the dev_pm_ops
> > > belonging to the platform bus. The callbacks are weak symbols
> > > that architecture specific code can override.
> > > 
> > > Allows Runtime PM even though CONFIG_PM_SLEEP=n.
> > > 
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > 
> > Thanks for the patch.
> > 
> > Greg, is it fine with you?

It's fine with me, Rafael, are you taking this through your tree?  If
so, please add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

thanks,

greg k-h
