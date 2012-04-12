From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 21:22:53 -0400
Message-ID: <1334193773.23924.316.camel@gandalf.stny.rr.com>
References: <1334177035.23924.299.camel@gandalf.stny.rr.com>
	<Pine.LNX.4.44L0.1204111703180.1351-100000@iolanthe.rowland.org>
	<20120411220944.GC3677@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120411220944.GC3677@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-12 at 04:09 +0600, Andrey Rahmatullin wrote:
> On Wed, Apr 11, 2012 at 05:13:51PM -0400, Alan Stern wrote:
> > > I replaced the hcd_pci_suspend_noirq call with retval=0 and suspend/resume
> > > was successful.
> >  
> > This indicates that your computer doesn't like to suspend while the
> > EHCI controllers are in D3hot.  I have no idea why not.
> > 
> > If you want a really thorough test, try changing 
> > drivers/pci/pci-driver.c:pci_pm_suspend_noirq.  In the "if (!pm)" 
> > clause, add a call to
> > 
> > 	pci_prepare_to_sleep(pci_dev);
> > 
> > just after the pci_save_state line.  Then try suspending with the 
> > script enabled (ehci-hcd unbound from the controllers).  If this fails 
> > then we'll know it is the source of the trouble.
> Looks like it works even with this line added.
> 

I reverted the retval change (that worked) and added this line. Put the
script back and did a suspend. The suspend and resume worked without
issue.

Here's my change just in case I did it incorrectly:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 12d1e81..e026390 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -713,6 +713,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
        if (!pm) {
                pci_save_state(pci_dev);
+               pci_prepare_to_sleep(pci_dev);
                return 0;
        }
 
-- Steve
