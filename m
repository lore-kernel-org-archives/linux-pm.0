From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 12:40:10 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512271229510.4933-100000@monsoon.he.net>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<20051226223325.GE1974@elf.ucw.cz>
	<Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
	<20051227192254.GJ1822@elf.ucw.cz>
	<20051227192956.GA10704@digitalimplant.org>
	<20051227194100.GL1822@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051227194100.GL1822@elf.ucw.cz>
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


On Tue, 27 Dec 2005, Pavel Machek wrote:

> On =DAt 27-12-05 11:29:56, Patrick Mochel wrote:

> > But, in some cases, peple are going to care about the intermediate
> > states, and we'll need to support them. It's simple enought to know
> > what states a PCI device supports, so I don't understand where the
> > complexity comes in.. ?
>
> Someone has to test all that... Unless we have in-tree driver that
> wants use intermediate states, I think supporting them is bad idea.

I don't understand what your issue is; perhaps you could explain it a bit
better. There is no additional work on the part of the core, nor any
additional complication in supporting 4 possible power states vs
supporting 2 vs supporting any arbitrary number that the driver and devic=
e
implement.

I did not suggest that we make the drivers support intermediate states; I
only stated that there are some drivers and devices that can and will
implement them, and that there are cases in which it will make sense to
enter them from userpsace.

If the sysfs files are simply checking string values and making a
driver-based call based on the validity of the string, then it doesn't
matter a) what the strings are or b) how many there are.

I admit I made a mistake in suggesting the interface - we wouldn't want t=
o
simply export all the PM states that are present in the device's config
space. We would really only want to export the states that the driver say=
s
it supports. But, that could be any number of states, above and beyond (o=
r
a subset of) D1/D2/D3/etc (or whatever the bus spec says are standard
states).


As far as testing, how does that factor into the picture? Do you feel tha=
t
we currently (or will) lack coverage testing? If so, I agree. However, I
do not think that should prevent us from thinking clearly about what the
best possible solution is.

If there is a need for more and/or better testing then we can collectivel=
y
gather the resources to accomplish it.

Thanks,


	Patrick
