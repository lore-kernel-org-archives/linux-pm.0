From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Mon, 8 Aug 2011 23:54:52 +0200
Message-ID: <20110808215452.GB22709@elf.ucw.cz>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<20110808210104.GA2926@suse.de> <20110808210537.GA22709@elf.ucw.cz>
	<201108082314.23860.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108082314.23860.rjw@sisk.pl>
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
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, yanmin_zhang@linux.intel.com, Greg KH <gregkh@suse.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > Thanks for the nice pointer. I checked dynamic debug. It's really a good debug tool.
> > > > > With the dynamic debug:
> > > > > 1) user need write a user space parser to process the syslog output;
> > > > > 2) Our testing scenario is we leave the mobile for at least hours. Then, check its status.
> > > > > No serial console available during the testing. One is because console would be suspended,
> > > > > and the other is serial console connecting with spi or HSU devices would consume power. These
> > > > > devices are powered off at suspend-2-ram.
...
> Not in the case described by Yanmin.

Really? I see the description above.

Yes, they'd need to set up syslog to only log >= KERN_ERR, then parse
the (small) results. Even hours worth of suspends should not cause
_that_ many errors.

Serial console is irrelevant. You need live machine to dump dmesg, but
again, you need live machine to access debugfs, too.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
