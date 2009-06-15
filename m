From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PCI hotplug v.s. suspend
Date: Mon, 15 Jun 2009 22:51:50 +0200
Message-ID: <200906152251.51648.rjw__32201.6672384509$1245099226$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906151630440.2643-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906151630440.2643-100000@iolanthe.rowland.org>
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
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ath5k-devel@venema.h4ckr.net
List-Id: linux-pm@vger.kernel.org

On Monday 15 June 2009, Alan Stern wrote:
> On Mon, 15 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > I'm not sure whether the example is trustworthy.  There was some
> > > discussion quite a while ago regarding whether drivers should free
> > > their IRQs during suspend, but I don't remember what the outcome was.
> > 
> > No, they shouldn't.
> > 
> > That's why we do the entire suspend_device_irqs() thing etc.
> 
> Looks like the Documentation/power/pci.txt file needs to be updated.  
> No surprise, it hasn't been touched in well over a year and there 
> haven't been any meaningful updates in four years.

Sure it does, but PCI PM has been a moving target for quite some time.  I hope
it's going to settle down now.

Best,
Rafael
