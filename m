From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Few enhancement ideas
Date: Fri, 15 Jul 2005 16:04:28 +0300
Message-ID: <1121432668.27159.2.camel@localhost>
References: <1121277175.6338.105.camel@localhost>
	<20050713183814.1F948BF466@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92890929329023597=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050713183814.1F948BF466@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "ext db@adsl-69-107-32-110.dsl.pltn13.pacbell.net" <db@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Cc: linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com
List-Id: linux-pm@vger.kernel.org

--===============92890929329023597==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 2005-07-13 at 11:38 -0700, ext
db@adsl-69-107-32-110.dsl.pltn13.pacbell.net wrote:
> > The Product
> > ===========
> > Nokia 770 is powered by an OMAP1710 on a custom board. 
[snip]
> ... and all that running Linux!  The last rumor I heard was that
> it might base on the 2.6.12 kernel. I look forward to seeing one
> of these, so I'll know for sure!
Yes, we'll bring some with us.

> For those unfamiliar with OMAP, http://linux.omap.com is a place
> to start ... there's a Linux-OMAP mailing list and patches (such
> as 2.6.13-rc1-omap1) in a GIT repository, many of which have made
> their way into kernel.org releases.  It's a family of ARM SOC
> processors that's very power-efficient.
> 
> 
> > Interests
> > =========
> > Here are a few ideas that we are planning to investigate in order to
> > address shortcomings in the current PM model with respect to system-wide
> > PM:
> >
> > - Regulator framework: similar to clock framework HAL
> 
> Perhaps you could elaborate in a separate email thread?
As Amit wrote we've been very busy till now, but we plan to elaborate an articulated proposal

> > - Generic framework for system-wide constraints: to handle constraints
> > outside bus control
> > - PM framework: Enhance PM framework to allow flexible policy control.
> > Like DPM?
> > - User space API: Requires study
> >
> > Are these ideas of interest to the PM community or Nokia-specific?
> 
> General interest!
> 
> I'll be very glad to see a more cross-pollination from that part
> of the embedded Linux world.  Laptops get plenty of attention,
> but there's more to Linux than that.  :)
> 
> - Dave
> 

--===============92890929329023597==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92890929329023597==--
