From: Patrick Mochel <mochel@digitalimplant.org>
Subject: RE: Powering down a device...
Date: Tue, 22 Nov 2005 09:15:57 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0511220909390.20910-100000@monsoon.he.net>
References: <EA12F909C0431D458B9D18A176BEE4A5030D5E61@dlee02.ent.ti.com>
	<1132536373.8816.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65385575904564308=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132536373.8816.34.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Percival <matthew@capgo.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============65385575904564308==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 21 Nov 2005, Matthew Percival wrote:

> G'Day,
>
> 	Thanks for your reply.  I have tried your suggestions out, but have not
> been able to conserve any additional power.
>
> > For device sleeps you just do an 'echo mem > /sys/power/state'.  Pm.c
> > will map which sleep and wake this takes you to.
>
> 	I just tried comparing `standby' with `mem', and there was no
> difference in vmain --- or anywhere else for that matter, though I was
> no expecting to see any change elsewhere.

The system power states depend on what the platform port has implemented.
It may be that the OSK has not implemented those states.

> > Each individual device will also have a power/state file in the sysfs
> > directory structure.  You can echo a device power state down to the
> > driver and it will react how if it knows how to enter that state.
>
> 	I tried `standby', `mem' and `disc'
> with /sys/devices/platform/smc91x/power/state and saw no change; there
> was nothing printed on the terminal either. I guess it must not be
> implemented with this driver at the moment, which I guess is why there
> is no change when I put the whole system to sleep (please correct me if
> my assumptions are wrong).  If it is nothing too difficult to add to the
> driver, would you be able to direct me to where I may find out how to do
> this?

Unfortunately, device power management is a bit incomplete (and a bit
rough). One would not write "standby", "mem", or "disk" to a device power
file, but rather a numeric value that is equal to the power state that the
device should enter, e.g. 1, 2, 3, etc.. (The fact that this numeric value
may not correlate to a power state relevant to that device was overlooked
by the designers of the generic interface).

It could also be that the smc91x does not support power management at all,
or that the right infrastructure is not in place for it to work.

Thanks,


	Pat


--===============65385575904564308==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65385575904564308==--
