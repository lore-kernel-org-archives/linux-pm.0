From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 22:02:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606242200530.492-100000@netrider.rowland.org>
References: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sat, 24 Jun 2006, Linus Torvalds wrote:

>  /**
>   *	device_suspend - Save state and stop all devices in system.
>   *	@state:		Power state to put each device in.
>   *
>   *	Walk the dpm_active list, call ->suspend() for each device, and move
> - *	it to dpm_off.
> - *	Check the return value for each. If it returns 0, then we move the
> - *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
> - *	the dpm_off_irq list. If we get a different error, try and back out.
> + *	it to the dpm_off list.
> + *
> + *	(For historical reasons, if it returns -EAGAIN, that used to mean
> + *	that the device would be called again with interrupts enabled.
--------------------------------------------------------------^ disabled.

> + *	These days, we use the "suspend_late()" callback for that, so we
> + *	print a warning and consider it an error).

Alan Stern
