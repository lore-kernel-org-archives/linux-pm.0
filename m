From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sun, 25 Dec 2005 11:52:21 -0500
Message-ID: <200512251152.23242.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0512251133010.31812-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512251133010.31812-100000@netrider.rowland.org>
Content-Disposition: inline
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

On Sunday 25 December 2005 11:43, Alan Stern wrote:
> > It is not *that* bad, actually. In system suspend/resume cases, no ne=
w
> > I/O requests can happen, because userspace is frozen. Because of
> > runtime suspend, you should handle I/O errors properly, but you shoul=
d
> > handle I/O errors properly, anyway, so... looks like a solution to me.
>=20
> You're right, it's not really all that bad. =A0Note however that in the=
 PPC
> implementation, Ben H. does not freeze userspace before suspend to RAM.
>=20

Do we freeze processes before STR on i386?

--=20
Dmitry
