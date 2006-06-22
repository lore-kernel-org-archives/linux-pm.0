From: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 09:25:06 -0700
Message-ID: <20060622092506.da2a8bf4.akpm@osdl.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<4499BE99.6010508@gmail.com>
	<20060621221445.GB3798@inferi.kami.home>
	<20060622061905.GD15834@kroah.com>
	<20060622004648.f1912e34.akpm@osdl.org>
	<20060622160403.GB2539@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060622160403.GB2539@slug>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006 18:04:03 +0200
Frederik Deweerdt <deweerdt@free.fr> wrote:

> Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> > I can bisect it if we're stuck, but that'll require beer or something.
> =

> FWIW, my laptop (Dell D610) gave the following results:
> 2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() r=
eturns -16
> 2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usb=
core]() returns -16

So it's in mainline already - hence it's some recently-written thing which
was not tested in rc6-mm2.

> 2.6.17: oops
> 2.6.17.1: oops

2.6.17 wasn't supposed to oops.  Do you have details on this?

> 2.6.17-rc6-mm2: suspends correctly

Good kernel, that.
