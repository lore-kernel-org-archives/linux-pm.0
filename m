From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sun, 25 Dec 2005 20:54:10 +0100
Message-ID: <20051225195410.GA1864@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0512251133010.31812-100000@netrider.rowland.org>
	<200512251152.23242.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200512251152.23242.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Ne 25-12-05 11:52:21, Dmitry Torokhov wrote:
> On Sunday 25 December 2005 11:43, Alan Stern wrote:
> > > It is not *that* bad, actually. In system suspend/resume cases, no =
new
> > > I/O requests can happen, because userspace is frozen. Because of
> > > runtime suspend, you should handle I/O errors properly, but you sho=
uld
> > > handle I/O errors properly, anyway, so... looks like a solution to =
me.
> >=20
> > You're right, it's not really all that bad. =A0Note however that in t=
he PPC
> > implementation, Ben H. does not freeze userspace before suspend to RA=
M.
> >=20
>=20
> Do we freeze processes before STR on i386?

Yes.
							Pavel

--=20
Thanks, Sharp!
