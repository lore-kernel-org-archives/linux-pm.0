From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Fri, 29 May 2009 09:45:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905290942150.2882-100000@iolanthe.rowland.org>
References: <aec7e5c30905290041p13cc3e48k3527640fb52c3730@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905290041p13cc3e48k3527640fb52c3730@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 29 May 2009, Magnus Damm wrote:

> > (And by the way, the _noirq ops don't run in atomic context. =A0They run
> > in process context with most interrupt deliveries disabled. =A0It's not
> > the same thing -- they are allowed to sleep.)
> =

> Huh, so if they are allowed to sleep then clock events are still
> running. And probably some clocksource as well. I guess that's why you
> say "most" interrupts disabled instead of all. Sharing the timer IRQ
> is not allowed then?

Rafael can tell you.  But notice I didn't say the interrupts were
disabled -- I said that interrupt _delivery_ was disabled.  In general
the interrupts themselves _are_ enabled; the kernel fields them but
then does not call the drivers' interrupt handler routines.  (Except
perhaps for IRQs which are explicitly marked as wakeup sources...)

> I wonder if the PM code assumes that the clock event is a sys device?
> We use platform drivers for clock events on SuperH...

Ask Rafael.

Alan Stern
