From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 27 Jun 2006 11:33:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606271130490.20671-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
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

On Mon, 26 Jun 2006, Linus Torvalds wrote:

> =

> =

> On Tue, 27 Jun 2006, Adam Belay wrote:
> > =

> > Yes, and pci_set_power_state() can require msleep().
> =

> Actually, I was looking at that, and it's a problem right now.
> =

> For all the silly (and wrong) reasons.
> =

> The msleep() shouldn't actually be in pci_set_power_state(), but in the =

> infrastructure that calls it. In particular, when actually powering down, =

> there's no point in doing a msleep() between each device - we'll be =

> sleeping a lot longer than 10ms after we've gone down.
> =

> The fact that D3hot won't necessarily take effect until 10 ms after we've =

> done the "go to sleep" thing obviously doesn't really mean that we should =

> actually sleep 10 msec _there_.

What about other occasions when pci_set_power_state() is called?  For =

instance, a selective suspend.  Where's the appropriate place to delay in =

that case?

What happens if the system sleep is aborted (some later driver is unable =

to suspend) and everything gets resumed immediately?  Where should the 10 =

ms delay occur then?

Alan Stern
