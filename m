From: david-b@pacbell.net
Subject: Re: Few enhancement ideas
Date: Wed, 13 Jul 2005 11:38:14 -0700
Message-ID: <20050713183814.1F948BF466@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <1121277175.6338.105.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============27108509047410223=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1121277175.6338.105.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org, amit.kucheria@nokia.com
Cc: Igor.Stoppa@nokia.com, sampsa.fabritius@nokia.com
List-Id: linux-pm@vger.kernel.org

--===============27108509047410223==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> The Product
> ===========
> Nokia 770 is powered by an OMAP1710 on a custom board. The device will
> ship with a 1500mAh battery which will give a continuous browsing
> use-time (WLAN or Bluetooth) of 3hrs. The device needed to be
> instant-ON, so we have used run-time power management. This gives us an
> official 'standby-time' of 7 days. All the drivers make extensive use of
> the clock framework and release clocks when peripheral is not in use.

... and all that running Linux!  The last rumor I heard was that
it might base on the 2.6.12 kernel. I look forward to seeing one
of these, so I'll know for sure!

For those unfamiliar with OMAP, http://linux.omap.com is a place
to start ... there's a Linux-OMAP mailing list and patches (such
as 2.6.13-rc1-omap1) in a GIT repository, many of which have made
their way into kernel.org releases.  It's a family of ARM SOC
processors that's very power-efficient.


> Interests
> =========
> Here are a few ideas that we are planning to investigate in order to
> address shortcomings in the current PM model with respect to system-wide
> PM:
>
> - Regulator framework: similar to clock framework HAL

Perhaps you could elaborate in a separate email thread?

> - Generic framework for system-wide constraints: to handle constraints
> outside bus control
> - PM framework: Enhance PM framework to allow flexible policy control.
> Like DPM?
> - User space API: Requires study
>
> Are these ideas of interest to the PM community or Nokia-specific?

General interest!

I'll be very glad to see a more cross-pollination from that part
of the embedded Linux world.  Laptops get plenty of attention,
but there's more to Linux than that.  :)

- Dave


--===============27108509047410223==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============27108509047410223==--
