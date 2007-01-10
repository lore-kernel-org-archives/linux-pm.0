From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Suspend and wake on lan
Date: Wed, 10 Jan 2007 21:59:41 +0100
Message-ID: <200701102159.42126.rjw@sisk.pl>
References: <200701102050.25410.rob@tenfoot.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701102050.25410.rob@tenfoot.org.uk>
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
To: Rob Walker <rob@tenfoot.org.uk>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 10 January 2007 21:50, Rob Walker wrote:
> Hi,
> =

> I'm having some trouble getting wake on lan to work after the computer is =

> suspended.  Wake on Lan works if I shut down the computer normally (i.e. =
it =

> powers up again when I send the magic packet), but doesn't wake up when I =

> suspend the computer to disk and then send the magic packet.  I ensure th=
at =

> wake on lan is enabled before suspending by running `ethtool -s eth0 wol =
g`.
> =

> The computer is an AMD Athlon, using a Gigabyte GA-71X motherboard with V=
IA =

> KT400 chipset.
> The on board network chip is a RealTek RTL8139, using the 8139too driver.
> =

> I've tried the kernel from debian testing (2.6.18) and a hand built 2.6.1=
9.1 =

> kernel, both with the same results.  =

> =

> I've tried uswsusp and the in-kernel suspend, again both with the same =

> results.
> =

> Can you help?

Hm, not really, but I think the 8139too's suspend routine does something
that disables WOL.

Please try to contact the author/maintianer of the driver.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
