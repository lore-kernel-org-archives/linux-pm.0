From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 08:08:27 +0000
Message-ID: <20060427080826.GB2376@ucw.cz>
References: <200604252034.54352.ncunningham@cyclades.com>
	<Pine.LNX.4.44L0.0604251010460.5330-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82784572675805901=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0604251010460.5330-100000@iolanthe.rowland.org>
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
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============82784572675805901==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> The right way to solve this is to make sure that the resuming kernel can
> correctly determine whether the power session (way back from the original
> sw-suspend) is still intact.  It's expected that in many cases it won't
> be, because most systems won't provide suspend current while the machine
> is off.  We have to guarantee that the boot kernel's actions won't end up
> fooling the resuming kernel into thinking that the power sessions are
> intact when in fact they aren't.  (Furthermore, in an ideal world, we
> would also make sure that the boot kernel won't destroy any power sessions
> that still _are_ intact.  Right now we have no way to do this, because the
> drivers in the boot kernel don't know that it _is_ a boot kernel.)

You don't know if it is boot or resume until you read the disk, sorry.

							Pavel
-- 
Thanks, Sharp!

--===============82784572675805901==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82784572675805901==--
