From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI: fix incorrect error return in
	pci_enable_wake
Date: Tue, 16 Dec 2008 10:43:53 -0800
Message-ID: <200812161043.53756.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0812111510160.15474-100000@iolanthe.rowland.org>
	<200812112119.51610.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812112119.51610.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 11, 2008 12:19 pm Rafael J. Wysocki wrote:
> On Thursday, 11 of December 2008, Alan Stern wrote:
> > This patch (as1186) fixes a minor mistake in pci_enable_wake().  When
> > the routine is asked to disable remote wakeup, it should not return an
> > error merely because the device is not allowed to do wakeups!
> >
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

I lost the original of this one.  Alan can you resend to me with Rafael's ack?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
