From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 03/15] PM / Hibernate: separate block_io
Date: Mon, 29 Mar 2010 15:30:31 +0200
Message-ID: <20100329133031.GA26618__13692.2739250169$1269869523$gmane$org@ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<4BAA98FC.9040302@crca.org.au> <4BAACC0A.2040009@crca.org.au>
	<201003252112.25204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003252112.25204.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Nigel Cunningham <ncunningham@crca.org.au>, Jiri Slaby <jirislaby@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > How about some abbreviation of hibernate? "hib"?
> > 
> > On further reflection, how about "std" (suspend to disk)? I think that's 
> > less ugly than the 'hib' suggestion :)
> 
> But it also decodes as "standard" if someone is not in the right context. :-)
> 

Hmm, and when you are in really wrong context, you get rather nasty
diseases...

std_prepare() seems like rather bad idea :-).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
