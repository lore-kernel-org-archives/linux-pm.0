From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Mon, 20 Feb 2006 10:08:36 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602201006230.12708-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220000907.GE15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
	<20060220002053.GF15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
	<20060220004142.GI15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602200938320.12708-100000@monsoon.he.net>
	<20060220175842.GH19156@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34304896023639442=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060220175842.GH19156@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============34304896023639442==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 20 Feb 2006, Pavel Machek wrote:

> Hi!
>
> > > > > Compatibility is already restored.
> > > >
> > > > No, the interface is currently broken. The driver core does not
> > > > dictate
> > >
> > > There were two different interfaces, one accepted 0 and 2, everything
> > > else was invalid, and second accepted 0, 1, 2, 3.
> > >
> > > If you enter D2 on echo 2, you are breaking compatibility with 2.6.15
> > > or something like that.
> >
> > I don't see how this is true. If a process writes "2" to a PCI device's
> > state file, what else are sane things to do?
>
> In some kernel version (2.6.15, iirc), device entered D3 if you wrote
> "2" to state file, and there are programs out there that depend on
> it.

Like what?

> > You dropped the fundamental point, and I don't understand why you disagree
> > with it - the driver core should not be dictating policy to the downstream
> > drivers. It is currently doing this by filtering the power state that is
> > passed in via the "state" file.
>
> That's best we can do to stay compatible. Please introduce new file,
> and make states string-based.

You are still overlooking the point - the core should not be filtering the
values. It currently is, but it's trivial to fix. What is your issue with
that?

Thanks,


	Pat

--===============34304896023639442==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34304896023639442==--
