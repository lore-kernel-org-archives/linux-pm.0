From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Sat, 5 Aug 2006 12:05:04 +0000
Message-ID: <20060805120504.GA5417@ucw.cz>
References: <5389061B65D50446B1783B97DFDB392D01F607DB@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <5389061B65D50446B1783B97DFDB392D01F607DB@orsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: "Mochel, Patrick" <patrick.mochel@intel.com>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

Hi!

> >> Please note that the interface is not hooked up with the rest of the
> code
> >> yet and is provided just for reference/review.
> =

> Drivers/powerop/powerop_sysfs.c : includes asm/powerop.h and will not
> compile on i386.
> There are other places where it will not compile for non-omap
> architectures.  The architecture independent code should build for all
> architectures.
> =

> Now just rambling a bit, while catching up on the email thread some of
> this may be wrong but....
> =

> Is it realistic to have the dimensionality of the operating points
> defined at the architecture level?  Why couldn't there be multiple types
> of operating points based on presence of different peripherals?  Having
> the array defined at compile time seems wrong.  Couldn't the platform

It is complex enough already, please don't overdesign it even more.

							Pavel
-- =

Thanks for all the (sleeping) penguins.
