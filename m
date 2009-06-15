From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PCI hotplug v.s. suspend
Date: Mon, 15 Jun 2009 16:34:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906151630440.2643-100000__22227.8616311543$1245098133$gmane$org@iolanthe.rowland.org>
References: <200906152158.30989.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906152158.30989.rjw@sisk.pl>
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
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, ath5k-devel@venema.h4ckr.net
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Jun 2009, Rafael J. Wysocki wrote:

> > I'm not sure whether the example is trustworthy.  There was some
> > discussion quite a while ago regarding whether drivers should free
> > their IRQs during suspend, but I don't remember what the outcome was.
> 
> No, they shouldn't.
> 
> That's why we do the entire suspend_device_irqs() thing etc.

Looks like the Documentation/power/pci.txt file needs to be updated.  
No surprise, it hasn't been touched in well over a year and there 
haven't been any meaningful updates in four years.

Alan Stern
