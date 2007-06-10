From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2] PM: Remove suspend and resume
	support from struct device_type
Date: Sun, 10 Jun 2007 21:22:41 +0200
Message-ID: <20070610192241.GB25138@elf.ucw.cz>
References: <200706101519.50588.rjw@sisk.pl> <200706101522.23816.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706101522.23816.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The suspend and resume support in struct device_type (include/linux/device.h)
> is not used anywhere.  It is also undocumented, so it can be removed.

I guess you should cc gregkh on this one.. and the previous series
that touches driver model. And perhaps cc lkml is good idea.

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
