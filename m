From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 10:13:32 +0100
Message-ID: <20060313091332.GC3495@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313083037.GA3495@elf.ucw.cz>
	<20060313084811.GC20569@neo.rr.com>
	<20060313085042.GB3495@elf.ucw.cz>
	<20060313090759.GA20930@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81095049123084595=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313090759.GA20930@neo.rr.com>
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
Cc: linux-pm@osdl.org, "Victor Porton, , , " <porton@ex-code.com>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============81095049123084595==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 13-03-06 04:07:59, Adam Belay wrote:
> On Mon, Mar 13, 2006 at 09:50:42AM +0100, Pavel Machek wrote:
> > On Po 13-03-06 03:48:11, Adam Belay wrote:
> > > The timeout feature could be done using the ACPI alarm interface, but there's
> > > no reliable way of knowing how long the system can remain in a suspend state
> > > on the x86 mobile platform, so waking up at the right time would be tricky if
> > > not impossible.
> > 
> > Make it an hour... System should be able to stay suspended for an
> > hour. IIRC Apple did something like this? I'd just be slightly worried
> > about machine waking up itself just when you hit the turbulence in the
> > airplane, or something like that. 
> 
> Hmm, but let's say the battery is 40% charged.  Then it's not very clear if it
> will last an hour.  All of a sudden the issue becomes system specific, or it
> may even depend on things like whether wake-on-lan is enabled,
>right?

40% battery should still last 10+ hours in suspend-to-RAM, unless
something is wrong.

You *could* wakeup every minute or so to check the battery state; some
PDAs actually do that.

> If we could get a power management event and wake the system when the battery
> reaches a low condition that would be really awesome.  But I don't think this
> is possible AFAIK.

ACPI people have to comments, but see above, it can be emulated by
polling.
								Pavel

-- 
166:

--===============81095049123084595==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81095049123084595==--
