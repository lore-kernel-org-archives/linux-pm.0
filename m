From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Fri, 4 Mar 2011 23:42:25 +0100
Message-ID: <20110304224225.GA23936__34294.1473158591$1299278674$gmane$org@elf.ucw.cz>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<201103042221.02852.rjw@sisk.pl> <20110304214630.GA29883@albatros>
	<201103042330.25079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103042330.25079.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-pm@lists.linux-foundation.org, Vasiliy Kulikov <segoon@openwall.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> > If one may change kernel memory via swap then it is another problem with
> > modules_disabled.
> 
> If you want an interface to disable _any_ kind of writes into the kernel
> memory by any means, then please add it and don't call it modules_disabled,
> because it's a hell of a confusing name and no amount of documentation
> can help that.

...and that interface should be CAP_SYS_something, I'd say...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
