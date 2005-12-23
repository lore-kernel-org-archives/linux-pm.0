From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 22:28:32 +0100
Message-ID: <20051223212832.GC15357@elf.ucw.cz>
References: <20051223172057.GA15357@elf.ucw.cz>
	<Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On P=E1 23-12-05 16:22:44, Alan Stern wrote:
> On Fri, 23 Dec 2005, Pavel Machek wrote:
>=20
> > Well, if you can find some elegant solution in the core, I think that=
s
> > the best way.
> >=20
> > You could set system_state to "suspending" or something like that, an=
d
> > just if() out notifications in that case.
>=20
> How about simply adding a call to try_to_freeze() somewhere inside=20
> kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much=20
> what I want, in theory.  The hotplug processes would get frozen before=20
> /sbin/hotplug is exec'ed.
>=20
> I haven't actually tried it yet, so maybe there's a hidden gotcha.

That would mean quite a lot of "extra" events delivered to userspace,
no?  ... no, actually not, that should be okay. "resume during
suspend" events will be discarded, because they'll not make it into
on-disk image, so userspace will get single unplug/replug events after
resume. That's okay.

OTOH I do not think try_to_freeze() is going to make it. Process
freezing is one-time action, so if you start new thread,
try_to_freeze() will not attempt to freeze it.
							Pavel
--=20
Thanks, Sharp!
