From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Mon, 26 Jun 2006 23:18:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151130644.10141.70.camel@localhost.localdomain>
	<20060627060810.GD4264@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060627060810.GD4264@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Tue, 27 Jun 2006, Adam Belay wrote:
> =

> Yes, and pci_set_power_state() can require msleep().

Actually, I was looking at that, and it's a problem right now.

For all the silly (and wrong) reasons.

The msleep() shouldn't actually be in pci_set_power_state(), but in the =

infrastructure that calls it. In particular, when actually powering down, =

there's no point in doing a msleep() between each device - we'll be =

sleeping a lot longer than 10ms after we've gone down.

The fact that D3hot won't necessarily take effect until 10 ms after we've =

done the "go to sleep" thing obviously doesn't really mean that we should =

actually sleep 10 msec _there_.

			Linus
