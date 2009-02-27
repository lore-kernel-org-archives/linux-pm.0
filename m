From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 11:12:47 +0100
Message-ID: <20090227101247.GF4582__18947.5841391415$1235729558$gmane$org@elf.ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200902210057.27781.rjw@sisk.pl>
	<d6200be20902201708g45540f60ib024c3365c85aef4@mail.gmail.com>
	<200902211047.26787.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902211047.26787.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > And if the kernel is supposed to start automatic suspend, it has to monitor
> > > all of the wakelocks.  IMO, it's better to allow the power manager to poll the
> > > kernel if it refuses to suspend.
> > 
> > What is better about polling in userspace?
> 
> One kernel thread less, for example?

One kernel thread is about as costly as one userland thread. And I
believe we should not design new code that _needs_ polling.

I think it is better to have kernel thread than userland polling us
all the time.

Now... on PC it will be "interesting". Your solution has great
advantage of being able to work with s2ram quirks... But s2ram quirks
are not an issue on embedded hardware or OLPC, and hopefully kernel
mode setting will fix it on PCs, too...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
