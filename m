From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 27 Jun 2006 17:16:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606271713550.3927@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606271130490.20671-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606271130490.20671-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Tue, 27 Jun 2006, Alan Stern wrote:
> =

> What about other occasions when pci_set_power_state() is called?  For =

> instance, a selective suspend.  Where's the appropriate place to delay in =

> that case?
>
> What happens if the system sleep is aborted (some later driver is unable =

> to suspend) and everything gets resumed immediately?  Where should the 10 =

> ms delay occur then?

I think the caller should just do it (eg for the suspend path, we could =

just say that on failure, before we start waking things up, we mdelay() =

for a while).

In practice, I don't think it's an issue. The alternative is to just make =

the "msleep()" be an "mdelay()", of course, at which point it's suddenly =

irq-safe.

		Linus
