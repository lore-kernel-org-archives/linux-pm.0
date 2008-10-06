From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] PM: use pm_op methods for device types
Date: Mon, 6 Oct 2008 17:11:27 +0200
Message-ID: <20081006151127.GC1380__33124.1691289053$1223385040$gmane$org@ucw.cz>
References: <20080925220635.GA12175@kroah.com>
	<Pine.LNX.4.44L0.0809260948580.2395-100000@iolanthe.rowland.org>
	<20080926175922.GA767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080926175922.GA767@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: USB list <linux-usb@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Kay Sievers <kay.sievers@vrfy.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> > Okay, I was confused too.  Looking more closely, it's apparent that 
> > mainline is okay and the problem was introduced by Hannes Reinecke's 
> > 
> > driver-core-remove-suspend-resume-callbacks-for-device-type.patch
> > 
> > which states that the suspend/resume callbacks in struct device_type
> > are unused.  It may be true that the legacy suspend/resume methods are
> > unused, but the new pm_ops methods definitely are used.
> > 
> > Therefore part or all of Hannes patch should be reverted.  And the 
> > mainline is okay as it stands.
> 
> Ah, ick.
> 
> Hannes, care to respin this patch based on this information?

I guess Hannes patch shoud simply be dropped....

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
