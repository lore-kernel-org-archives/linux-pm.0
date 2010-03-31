From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement	user_ops writer
Date: Wed, 31 Mar 2010 16:47:02 +0200
Message-ID: <20100331144702.GC3449@ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003300009.18315.rjw@sisk.pl> <4BB1508E.9030103@crca.org.au>
	<201003302303.12758.rjw@sisk.pl> <4BB2B3E5.7020708@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BB2B3E5.7020708@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> Regarding using LRU pages as temporary storage, if it wasn't safe and 
> reliable, I would have stopped doing it ages ago. The only problem I can 

What kind of argument is that?

And what prevents people from introducing more KMS-like breakage in
future?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
