From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Tue, 12 Apr 2011 18:23:24 +0200
Message-ID: <20110412162324.GA25315@elf.ucw.cz>
References: <BANLkTik8bWF8c+BmrzzqOZiWWwujskgs7w@mail.gmail.com>
	<Pine.LNX.4.44L0.1104121200530.2000-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1104121200530.2000-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> > If you want to figure out which device suspend too slow, this patch
> > will do better.
> 
> It's okay with me.  Presenting the information in an easy-to-read form 
> is fine.  I just wanted to point out that the information is already 
> available.
> 
> BTW, there are several spelling errors in the Kconfig help text in your 
> patch.  You should fix them before submitting the patch again.

Well well. I'd avoid placing this in kernel. It seems that parsing
dmesg to get the "better" debugging information out is pretty much
trivial.

Just publish that shell script somewhere...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
