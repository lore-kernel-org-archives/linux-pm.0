From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Mon, 20 Feb 2006 09:55:00 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602200938320.12708-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220000907.GE15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
	<20060220002053.GF15608@elf.ucw.cz>
	<Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
	<20060220004142.GI15608@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12723450678780202=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060220004142.GI15608@elf.ucw.cz>
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

--===============12723450678780202==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 20 Feb 2006, Pavel Machek wrote:

> On Ne 19-02-06 16:36:34, Patrick Mochel wrote:
> >
> > On Mon, 20 Feb 2006, Pavel Machek wrote:
> >
> > > On Ne 19-02-06 16:17:01, Patrick Mochel wrote:
> >
> > > > I really fail to see what your fundamental objection is. This restores
> > > > compatability, makes the core simpler, and adds the ability to use the
> > > > additional states, should drivers choose to implement them; all for
> > > > relatively little code. It seems a like a good thing to me..
> > >
> > > Compatibility is already restored.
> >
> > No, the interface is currently broken. The driver core does not
> > dictate
>
> There were two different interfaces, one accepted 0 and 2, everything
> else was invalid, and second accepted 0, 1, 2, 3.
>
> If you enter D2 on echo 2, you are breaking compatibility with 2.6.15
> or something like that.

I don't see how this is true. If a process writes "2" to a PCI device's
state file, what else are sane things to do?

You dropped the fundamental point, and I don't understand why you disagree
with it - the driver core should not be dictating policy to the downstream
drivers. It is currently doing this by filtering the power state that is
passed in via the "state" file.

> Please let this interface die and create new one. (And notice that
> this is exactly same advice you gave me month ago).

And I was sort of wrong. I think an ideal interface would allow the bus
drivers to export the states that they support, and would allow a state
name of any format to be written to that file.

One way to do that is to have each bus driver export its equivalent of a
"state" file for each device. But, a better solution is to leverage the
infrastructure that is already in place and export things through the
existing "state" file.

These patches are steps along that path. They prevent the core from
filtering the state value passed in. It's still an integer value, but it
allows any possible state to be used.

We could just as easily leave it as a string, and have the buses parse the
value to their expectations. Eventually we might want to do something like
that, or have them export a list of string states that they support.
Regardless, that is all in the future, and is completely orthogonal to
letting a device support more than just "on" or "off".

Thanks,


	Pat


--===============12723450678780202==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12723450678780202==--
