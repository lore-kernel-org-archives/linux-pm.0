From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 23:44:05 +0100
Message-ID: <200902182344.12100.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<200902182217.48321.rjw@sisk.pl>
	<d6200be20902181435o1794007bpfbab1f9e41979bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902181435o1794007bpfbab1f9e41979bad@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Wednesday 18 February 2009 23:35:26 schrieb Arve Hj=F8nnev=E5g:
> >> Allowing user space to suspend input devices while they are still open
> >> is useful. The user-space code that reads from the input devices does
> >> not need to know if the device is suspended or not, and the kernel
> >> cannot auto suspend input devices based on inactivity.
> >
> > Hmm. =A0Why can't it?
> =

> Because they stop working. It is OK for us to turn off the touchscreen
> when the screen is off, but when the screen is on the user will touch
> items on the screen and expect them to respond. (We could also turn
> off the touchscreen when the keyguard is on, but we don't currently do
> this.)

This depends on the capabilities of the input device in question. Some
USB keyboards can be autosuspended under these conditions because
they can do remote wakeup.

	Regards
		Oliver
