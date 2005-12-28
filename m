From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Tue, 27 Dec 2005 20:36:39 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512272026140.6491-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0512261301090.12383-100000@monsoon.he.net>
	<200512261750.26186.dtor_core@ameritech.net>
	<Pine.LNX.4.50.0512271300560.4933-100000@monsoon.he.net>
	<d120d5000512271351s766ef783j6d32ea802f5ee3cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21284003771506166=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <d120d5000512271351s766ef783j6d32ea802f5ee3cd@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: dtor_core@ameritech.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============21284003771506166==
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Tue, 27 Dec 2005, Dmitry Torokhov wrote:

> On 12/27/05, Patrick Mochel <mochel@digitalimplant.org> wrote:

> > Would it be possible to simply mark the device as 'removed' and ignore it
> > until we resumed, and then clean it up (hotplug events and everything)?
> >
>
> Unfortunately swsusp resumes devices in the middle of suspend process
> with everything frozen and drivers don't know if they may clean up or
> have to postpone doing so. To do it uniformly you'd need to introduce
> threads and offload cleanups. I doubt it is good idea to require each
> subsystem to define cleanup thread or [ab]used keventd?

Blech, I forgot about the caveman-like way of making sure the swap device
is resumed. :)

Nevertheless, it shouldn't matter, and you bring up a point that exists,
and is actually more prevalent - the case of trying to resume a device
that doesn't exist any more.

Last week, I suggested that all devices that are thought to be present
should be resumed. Those that have gone away should be removed once the
system is resumed, then new devices should be discovered. In this, I am
implying that devices that are thought to be there, but really aren't
(have been removed, unplugged, or undocked) should be marked as such
(somehow) and taken care of later.

When swsusp resumes every device before writing the image, it should
ignore devices that aren't present anymore. They can still exist in
software (in the various object hiearchies), but they should just be
skipped. Ditto for when we 'suspend' them again, and on the real resume.

When the system is back up and userspace is started again, something
should walk the device tree and reap the devices that are no longer
present. The core could do this, so long as the flag was in struct device,
though I'm not sure that it would know about the hooks to trigger a
removal on the device's bus (or would it need to?). Then, we can free all
the memory, do all the unregistering, and generate all the hotplug events.

Of course, at that point, we'll need to discover any new devices, which is
going to be bus-speciifc. But, with a few extra bits of infrastructure
(per-bus objects, and a ->scan() method in struct bus_type), this will
relatively simple..

Thoughts?


	Patrick


--===============21284003771506166==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21284003771506166==--
