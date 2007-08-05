From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Date: Sun, 5 Aug 2007 20:50:08 +0200
Message-ID: <20070805185008.GD1758__40211.6026999012$1186341066$gmane$org@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<1185954978.1363.23.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1185954978.1363.23.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > This patch implement the functionality of jumping from kexeced kernel
> > > to original kernel.
> > > 
> > > A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> > > trigger the jumping to (executing) the new kernel or jumping back to
> > > the original kernel.
> > 
> > Could we get two reboot commands? Exec loaded kernel seems to be quite
> > different operation than "jump back".
> 
> Exec loaded kernel for jumping back is also different from exec loaded
> kernel normally.
> 
> Maybe the two reboot operations in kexec jump can be seen as "jump to"
> and "jump back"?

Yes, that would be better.

> Document will be added in next version too.
> 
> This parameter is used for kernel-to-kernel communication. But now, it
> must be setup by user, as in usage guide.

Thanks for your help :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
