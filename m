From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 2 Mar 2009 15:34:22 +0100
Message-ID: <20090302143422.GE2527__36788.9025518254$1236004578$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
	<20090301225647.GE1961@elf.ucw.cz>
	<200903020924.42451.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903020924.42451.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2009-03-02 09:24:36, Oliver Neukum wrote:
> Am Sonntag 01 M=E4rz 2009 23:56:47 schrieb Pavel Machek:
> > > Allowing user space to suspend input devices while they are still open
> > > is useful. The user-space code that reads from the input devices does
> > > not need to know if the device is suspended or not, and the kernel
> > > cannot auto suspend input devices based on inactivity.
> >
> > Actually, I'd like you to fix your userspace and close input devices
> > when it does not need them. Given the way you control the platform it
> > should not be that hard. I do not see why we'd want to invent new
> > interface for "uhuh, I have opened the keyboard but I am not really
> > interested in keys being pressed".
> =

> Generally you can't do this. A task has an open fd.
> =

> - you cannot assume it can open the device again (fd may be
> inherited)

Well, those tasks that matter - X servers and similar - usually can.

> - keeping the device open makes sure you are talking to the same device

Well, you have to handle hotplug anyway, so... and the name will not
change unless you unplug/replug.

> - you may want to avoid repeating expensive initialisations

That kind of initializations should perhaps be done at insmod, not
open time?

> - some input devices also do output

I guess you want to separate those to two different devices, then.

Anyway...

* I'd prefer "close to powersave". I can see that can be tricky to
use. So the alternative is

* ioctl() "I'm not interested in exact keys, powersave" is something
that makes sense. It should really be discussed with input people.

I'd hate to see

* magic /sys/.../file where you echo 1 to powersave. It is too
disconnected from the input fd, and while it may make it easier to
retrofit powermanagement without modifying Xservers etc... it will
ultimately result in pretty ugly hacks.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
