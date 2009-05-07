From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 7 May 2009 23:42:55 +0200
Message-ID: <20090507214255.GA14611__23253.4712100916$1241732849$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz> <4A03129A.90105@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A03129A.90105@acm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: U Kuehn <ukuehn@acm.org>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >> - Support for multiple swap devices
> >> - Support for non-swap (an ordinary file can be used)
> >> - Uses cryptoapi (LZO support, more than 2x speed of uncompressed data!)
> >> - Asynchronous I/O, readahead, multithreaded. Get the maximum throughput
> >>   possible with your hardware.
> >> - Userspace user interface that lets you abort hibernating and abort
> >>   resuming, get nice progress display etc.
> > 
> > All these are either done by uswsusp already, or could be done w/o
> > modifying kernel code.
> 
> Given that tuxonice DOES work reliably with dm-crypt encrypted swap
> partitions, does uswsusp offer this functionality? Looking into the docs
> on the sourceforge site does not give any information about this
> - point.

uswsusp does not care what kind of device it writes on, so yes,
dm-crypt works. IIRC seife was working on some YaST scripts so that
setting it up was easy for users.

> Further, being someone with a crypto background, the userland suspend
> helper does have some issues with the password/key handling:
> 1) no support for keys containing a 0 byte. (cryptsetup can handle
> this)

"passwords containing 0 byte" ? Is that a big deal? How would user
enter such password?

> 2) the rsa functionality seems to use the unsound practice to encrypt
> the symmetric key directly without any padding (aka encoding in libgcrypt).

If this is easy to fix, can you tell me what to do?

Otherwise, can you write a short note to bugtraq? Having bad crypto in
uswsusp would indeed be very very bad.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
