From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 3/10] PCI PM: Power-manage devices
	without drivers during suspend-resume
Date: Mon, 5 Jan 2009 11:51:05 +0100
Message-ID: <20090105105105.GF27199__33613.4661724374$1231152810$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
	<200812302333.45560.rjw@sisk.pl> <200812302338.42915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812302338.42915.rjw@sisk.pl>
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
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> 
> PCI devices without drivers can be put into low power states during
> suspend with the help of pci_prepare_to_sleep() and prevented from
> generating wake-up events during resume with the help of
> pci_enable_wake().  However, it's better not to put bridges into
> low power states during suspend, because that might result in entire
> bus segments being powered off.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Pavel Machek <Pavel@suse.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
