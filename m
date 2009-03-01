From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Sun, 1 Mar 2009 23:56:47 +0100
Message-ID: <20090301225647.GE1961__42243.2716623463$1235948195$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<200902180022.00239.rjw@sisk.pl>
	<d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> > Phase 3: Probably explicit control left to open/close.
> >>
> >> While that's generally a good idea, it's important to recognize that
> >> some devices should be runtime-suspended even while they are open.
> >
> > From the kernel side, yes (and that should be transparent to the user space
> > having them open).  By the user space, no.
> 
> Allowing user space to suspend input devices while they are still open
> is useful. The user-space code that reads from the input devices does
> not need to know if the device is suspended or not, and the kernel
> cannot auto suspend input devices based on inactivity.

Actually, I'd like you to fix your userspace and close input devices
when it does not need them. Given the way you control the platform it
should not be that hard. I do not see why we'd want to invent new
interface for "uhuh, I have opened the keyboard but I am not really
interested in keys being pressed".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
