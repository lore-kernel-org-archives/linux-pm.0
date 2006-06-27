From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Tue, 27 Jun 2006 16:58:36 +1000
Message-ID: <1151391516.2350.55.camel@localhost.localdomain>
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
	<Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
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

On Mon, 2006-06-26 at 23:18 -0700, Linus Torvalds wrote:
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

Agreed... though I still (heh, do I sound like I insist a bit there ? :)
think that we should look into not having interrupts off for this second
pass... it's just too much of a pain not to be able to hit a code path
that uses a mutex or whatever else and starts insulting you with
might_sleep() backtraces... And yes, even in the second phase. The
console is a good example I took earlier, fb_set_suspend() really wants
the console sem to be held, that's the only remotely sane way to make
sure the fbcon isn't currently trying to draw to you or other things
like that and the console is typically what you want to have suspended
late and/or resumed early.... In fact, for radeonfb, I also need a lot
of long delays when bringing the chip back up. Right now, I have ugly
hacks to do either mdelay or msleep depending if it uses my early wakeup
hook or the real resume()...

I'm not sure actually _why_ we should have irqs off if we do the job
properly, that is have either subsystems, class devices or child
devices, having taken care of blocking IOs to the driver in the first
place. (If we need a generic netdev suspend/resume, then so be it, that
will block the queues, and ethX should/could be a child of the device
like hda is a child of the controller in the IDE stack). =


Ben.
 =
