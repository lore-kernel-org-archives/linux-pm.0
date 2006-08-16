From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Use suspend_console in swsusp and
	make it configureable
Date: Wed, 16 Aug 2006 13:04:51 +0200
Message-ID: <200608161304.51758.rjw@sisk.pl>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060816104143.GC9497@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 16 August 2006 12:41, Pavel Machek wrote:
> Hi!
> =

> > The appended patch does the following:
> > =

> > 1) Adds suspend_console() and resume_console() to the suspend-to-disk c=
ode
> > paths so that people using netconsole are safe with swsusp.

So I assume this one is OK.

> > 2) Adds a Kconfig option allowing us to disable suspend_/resume_console=
()
> > if need be.
> =

> Slightly ugly, but I guess that is the way to go.

It also seems to be needed to add a 2 sec. dealy in suspend_console() so
that eg. the network console can send the messages before we try to suspend
the device.

> > 3) Marks CONFIG_PM_TRACE as dangerous.
> =

> I do not think that is enough. "(WILL TRASH YOUR CMOS)" would be more
> suitable. Dangerous is "may cause problems to you". This is "will
> cause problems to you". And for this to be useful, people have to edit
> sources, anyway.
> =

> 								Pavel
> =

> Can we just delete the config option?

OK, I'll do that.

I have divided the changes into three individual patches that will follow as
replies to this message.

Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
