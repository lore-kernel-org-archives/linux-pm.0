From: Pavel Machek <pavel@ucw.cz>
Subject: Re: what the patches do Re: [RFC 10/15] PM / Hibernate:
 user, implement user_ops reader
Date: Thu, 25 Mar 2010 22:26:56 +0100
Message-ID: <20100325212656.GD22902__10042.7305246287$1269552730$gmane$org@elf.ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003252114.36605.rjw@sisk.pl> <4BABC5B6.2070301@crca.org.au>
	<201003252129.10224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003252129.10224.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Nigel Cunningham <ncunningham@crca.org.au>, Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > >> I'm asking because if we're going to make a go of getting the in-kernel
> > >> code in much better shape, and we have Rafael, Jiri and I - and you? -
> > >> all pulling in the same direction to improve it, there's going to come a
> > >> point (hopefully not too far away) where uswsusp is just making life too
> > >> difficult, and getting rid of it will be a big help.
> > >
> > > We're not dropping user space interfaces used by every distro I know of.

Good.

> > So what's your long term plan then?
> 
> First, improve the in-kernel thing, second, switch people to it, _then_ remove
> the s2disk interface (after we're reasonably sure it's not used by any major
> distro) and _finally_ simplify things after it's been removed.

I'd really prefer to keep s2disk interface. It allows advanced stuff
like internet suspend resume (yep someone is doing it), crazy stuff
like multiple resumes from same image for fast booting (yep, some
embedded people are doing that) and might-be-useful stuff like
s2both...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
