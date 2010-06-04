From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] drivers/base/power: be more verbose in
	device_pm_add()
Date: Fri, 4 Jun 2010 18:50:37 +0200
Message-ID: <20100604165037.GG2695__16088.4817749777$1275670417$gmane$org@buzzloop.caiaq.de>
References: <1275653834-9132-1-git-send-email-daniel@caiaq.de>
	<20100604164527.GA27034@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100604164527.GA27034@suse.de>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 04, 2010 at 09:45:27AM -0700, Greg KH wrote:
> On Fri, Jun 04, 2010 at 02:17:14PM +0200, Daniel Mack wrote:
> > If a parentless device was added during a PM transaction, developers
> > might want to know which device caused the troube. Hence, output the
> > kobject's name in this case.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Cc: Magnus Damm <damm@igel.co.jp>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Randy Dunlap <randy.dunlap@oracle.com>
> > Cc: linux-pm@lists.linux-foundation.org
> > ---
> >  drivers/base/power/main.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 941fcb8..9e9fe6a 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -98,7 +98,7 @@ void device_pm_add(struct device *dev)
> >  		 * transition is in progress in order to avoid leaving them
> >  		 * unhandled down the road
> >  		 */
> > -		dev_WARN(dev, "Parentless device registered during a PM transaction\n");
> > +		dev_WARN(dev, "Parentless device registered during a PM transaction: %s\n", kobject_name(&dev->kobj));
> 
> Doesn'tthe dev_WARN call already print the name of the device?  Why
> print it twice?

Erm, no it didn't. Should it have? This is what I saw:

[    0.880646] Parentless device registered during a PM transaction


Daniel
