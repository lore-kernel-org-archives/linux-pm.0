From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Mon, 26 Dec 2005 12:43:43 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2841859931960351=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051224004029.GC16043@elf.ucw.cz>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============2841859931960351==
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id jBQKhvDZ027132


On Sat, 24 Dec 2005, Pavel Machek wrote:

> On P=E1 23-12-05 07:12:35, Patrick Mochel wrote:

> > Please note that D3 is only relevant for PCI devices and for ACPI dev=
ices.
> > The fact that it's the same value for every device in the system is a
> > design flaw. Please be aware that the value to write to the device fi=
le
> > could change, and will be dependent on the type (bus) of device, and =
quite
> > possibly on the device itself. It may not even be '3' for all PCI dev=
ices
> > in the future, or may be a string rather than 1 character, or simply =
a '1'
> > into a different file.
>
> Is there enough locking in driver core to make this safe?

The issue I stated is actually orthogonal to locking the device; but the
answer to your question is: probably not. We should probably be taking th=
e
per-device semaphore to prevent against competing events that are trying
to add/remove a device or driver.

> Ouch and BTW *right* value is _2_, today... because state_store() uses
> value from user as a pm_message_t.event. We should at least supply
> some hint that it is runtime suspend in pm_message_t.flags --
> unfortunately we do not have pm_message_t.flags yet.

And I don't think that we want it. I think that we want a completely
different API for doing runtime PM. Using the same API will make the
drivers more complicated by having to have a repeated control sequence fo=
r
determing what state (and under what conditions) the device is entering.

Also, recall that the actual states the device and driver support could b=
e
different than any other device or driver (even when the device or driver
are the same). What we need is a way for a driver to easily export the
states that it supports and a way to enter those exported states (e.g. an
array or linked list of state names and callbacks, like has been mentione=
d
a few times before).

To that effect, the per-device power file and its semantics should go awa=
y
completely and replaced with something that supports this new API.

> > Also, is there source available?
>
> Should be, we are trying to do *Open*SUSE these days ;-))).

Heh, but where? (And, actually nevermind, Holger pointed them out..  :-)

Thanks,


	Patrick



--===============2841859931960351==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============2841859931960351==--
