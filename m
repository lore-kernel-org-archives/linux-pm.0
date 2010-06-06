From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 00:26:55 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006070014380.2933__4673.74649965695$1275863305$gmane$org@localhost.localdomain>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<20100606190525.GA20517@infradead.org>
	<AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
	<20100606192405.GA7559@infradead.org>
	<AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-705175777-1275863218=:2933"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-705175777-1275863218=:2933
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o56MRRbq024343

Brian,

On Sun, 6 Jun 2010, Brian Swetland wrote:

> On Sun, Jun 6, 2010 at 12:24 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
> >
> > Yes. =C2=A0That's what makes me wonder about some parts of the discus=
sion
> > here. =C2=A0Getting the drivers for one or more of the android plattf=
orms
> > in is not a problem. =C2=A0I'd say it could have easily been done wit=
h the
> > manweeks spent arguing in this and related threads.
> >
> > The much bigger issues is to get android userspace running on a more
> > or less vanilla kernel, that is withoutthe =C2=A0binder, without the =
rather
> > interesting group ID based security hack^H^H^H^Hmodel, without the
> > suspend blocker userspace API and so on, and so on.
>=20
> Somebody will have to broker a deal with the frameworks/apps folks to
> get rid of the binder.  They like it a lot.  Of course if somebody
> built a drop-in replacement for the userspace side that didn't require
> a kernel driver, had the same performance characteristics, solved the
> same problems, etc, they could probably make an argument for it (or
> just provide it as a drop-in replacement for people who want a more
> "pure" linux underneath Android, even if we didn't pick it up).
>=20
> The group ID stuff works incredibly well for gating device access --
> we ensure that devices that need access from various processes end up
> with perms like 0660 root audio (say for a raw audio interface), and
> then we assure that processes which have the "may use audio hardware"
> permission are executed with audio as an additional group.  We ended
> up using the same model to control socket, raw socket, and bt socket
> access because at the time we could not find a reasonable way to grant
> or exclude such permissions on a process by process basis.
> Maintaining about 20-30 lines of diffs to make that work was not a bad
> tradeoff (and we don't expect those patches to go upstream).  If
> there's a way to accomplish this without patching the kernel, we're
> all ears.
>=20
> While we do maintain some assorted patches to core code (like the
> permissions thing), we strongly prefer to keep our work localized to
> drivers (generic to android or specific to hardware), and try to
> migrate to common kernel features when possible, submit patches (like
> work Mike Chan is doing around cpufreq and power measurement), etc.
> Patches to core code cause more headaches when we rebase up to new
> kernel versions, after all.

thanks for the honest answer and thanks to Christoph for the
reminder!=20

That takes a lot of the bullshit arguments about downstream users
being hurt out of the discussion. The above problems are way more
complex to resolve than the suspend blocker details.

That's another prove why we can let the drivers flow in (in the worst
case w/o the suspend blocker stubs) and have no pressure to resolve
the suspend blocker problem yesterday.

That said, after thinking more about it, I'm advocating the stubs
solution with a clear removal / decision date constraint
(e.g. 2.6.37), as it forces all involved parties to stay tuned and not
to forget about it. I'm curious about the outcome :)

Thanks,

	tglx
--8323328-705175777-1275863218=:2933
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-705175777-1275863218=:2933--
