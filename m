From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 08 Aug 2006 21:10:19 +0300
Message-ID: <1155060619.4434.22.camel@Dogbert.NOE.nokia.com>
References: <200608081344.k78DiY0t002356@olwen.urbana.css.mot.com>
	<20060808135247.GA4624@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060808135247.GA4624@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, dsingleton@mvista.com
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-08-08 at 16:52 +0300, ext Pavel Machek wrote:
> Hi!
> =

> A: No.
> Q: Should I top-post?
> =

> > If you're a device manufacturer, and you build, say 50 devices that
> all
> > use the same hardware but, because they are optimized for different
> > functional use cases, have different preferred operating points and
> > DVFS policies, it's *highly* desirable to not have to maintain 50
> > separate builds for those devices.  Putting configuration
> information
> > in places that can be changed independently of compilation is very
> > important to us.
> =

> You'll still need to maintain 50 different userlands, so I do not
> think that issue is _so_ important.

Hi,
the complexity/burden of maintenance depends on how the data to be
flashed is partitioned and the flashing stages used in production.

Mantaining 50 different kernel versions _and_ 50 different rootfs images
is more complex than having just a single kernel.

Of course a module would live in intfs or rootfs, so that would mantain
a single package, but it would introduce extra dependancies between
kernel version and rootfs version.
Especially if module support has to be enabled just because of it.

> Anyway, lets get in core first, than talk about userspace interface
> for chanig operating points, ok?
:D I think everybody has agreed on that, but it's important that
production-related issues are understood.

-- =

Cheers,
           Igor

Igor Stoppa (Nokia M - OSSO / Tampere)
