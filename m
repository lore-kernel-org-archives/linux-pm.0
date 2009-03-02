From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 2 Mar 2009 09:24:36 +0100
Message-ID: <200903020924.42451.oliver__46361.2304571599$1235982269$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
	<20090301225647.GE1961@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090301225647.GE1961@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Sonntag 01 M=E4rz 2009 23:56:47 schrieb Pavel Machek:
> > Allowing user space to suspend input devices while they are still open
> > is useful. The user-space code that reads from the input devices does
> > not need to know if the device is suspended or not, and the kernel
> > cannot auto suspend input devices based on inactivity.
>
> Actually, I'd like you to fix your userspace and close input devices
> when it does not need them. Given the way you control the platform it
> should not be that hard. I do not see why we'd want to invent new
> interface for "uhuh, I have opened the keyboard but I am not really
> interested in keys being pressed".

Generally you can't do this. A task has an open fd.

- you cannot assume it can open the device again (fd may be inherited)
- keeping the device open makes sure you are talking to the same device
- you may want to avoid repeating expensive initialisations
- some input devices also do output

	Regards
		Oliver
