From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of
	suspend	and resume
Date: Sun, 14 Dec 2008 10:28:27 +0100
Message-ID: <20081214092827.GA1445__30162.2264240452$1229247523$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<alpine.LFD.2.00.0812062157590.3425@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0812062201230.3425@nehalem.linux-foundation.org>
	<200812071439.27712.rjw@sisk.pl>
	<alpine.LFD.2.00.0812070824260.3425@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812070824260.3425@nehalem.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-12-07 08:34:43, Linus Torvalds wrote:
> On Sun, 7 Dec 2008, Rafael J. Wysocki wrote:
> > 
> > So, can we just say that PCI drivers shouldn't free IRQs during suspend and
> > request them during resume, and if there's any problem that leads to, then it
> > should be solved differently?
> 
> Well, there are reasons why _individual_ drivers might want to free and 
> re-request irq's during suspend, so I wouldn't say it's wrong either.

Another (not too good) reason why you may want to unregister the
interrupt is similarity between suspend and rmmod (and resume and
insmod).

In some cases you can get away with sharing code between those two
paths...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
