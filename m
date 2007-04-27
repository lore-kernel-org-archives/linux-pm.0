From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Fri, 27 Apr 2007 16:44:07 +0200
Message-ID: <20070427144407.GM22250@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0704271002060.3430-100000@iolanthe.rowland.org>
	<1177684350.3565.13.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177684350.3565.13.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.osdl.org, Pekka J Enberg <penberg@cs.helsinki.fi>, nigel@nigel.suspend2.net
List-Id: linux-pm@vger.kernel.org

Hi!

> > Consider this: Add a debugfs file containing a binary value.  If the value 
> > is on then preserve the boot dmesg buffer.  If the value is off, don't 
> > preserve it -- overwrite the buffer pointers with values saved in the 
> > image.
> 
> Or just add a debugfs file containing the printk buffer from before? I'd
> think it's only useful for debugging anyway.

I like it better than binary option.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
