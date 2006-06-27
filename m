From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 27 Jun 2006 03:07:17 -0400
Message-ID: <20060627070716.GC3438@neo.rr.com>
References: <Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151130644.10141.70.camel@localhost.localdomain>
	<20060627060810.GD4264@neo.rr.com>
	<Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
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

On Mon, Jun 26, 2006 at 11:18:15PM -0700, Linus Torvalds wrote:
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
> =

> 			Linus

Yes, but when returning to D0 from D3 it's a very necessary delay before
restoring PCI config space etc.  Wouldn't this be problematic for PCI devic=
es
that want to use resume_early()?

Thanks,
Adam
