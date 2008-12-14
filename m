From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] PCI: fix incorrect error return
	in	pci_enable_wake
Date: Sun, 14 Dec 2008 10:33:12 +0100
Message-ID: <20081214093311.GB1445__29730.0538317815$1229247642$gmane$org@ucw.cz>
References: <200812112058.08927.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0812111510160.15474-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0812111510160.15474-100000@iolanthe.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-12-11 15:11:39, Alan Stern wrote:
> This patch (as1186) fixes a minor mistake in pci_enable_wake().  When
> the routine is asked to disable remote wakeup, it should not return an
> error merely because the device is not allowed to do wakeups!
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Pavel Machek <pavel@suse.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
