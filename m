From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Sun, 22 Feb 2009 15:03:11 +0100
Message-ID: <20090222140311.GF1387__37716.0589946017$1235311645$gmane$org@ucw.cz>
References: <200902191356.53584.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902190956570.3012-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0902190956570.3012-100000@iolanthe.rowland.org>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Again, the decision to trigger automatic suspend has to be based on some
> > well defined criteria and the (in)activity of devices seems to be one of them.
> 
> I don't know what criteria the system monitor would use.  It might have 
> to be platform-specific.  The Android people seem to have a pretty good 
> idea of what criteria will work for them.
> 
> Inactivity of devices isn't always a good criterion.  There might be a
> background task which wakes up every few seconds to do something as
> long as the system is awake, thereby keeping some device always active.  
> The activity from this background task shouldn't prevent an auto-sleep.

Then we'd need a interface to mark such background task... and what is
reasonable use for such task, anyway? Either its job is neccessary, or
it should not waste power.

IOW maybe it is easier to eliminate such stuff?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
