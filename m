From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH trivial] PM / devfreq: Spelling s/frequnecy/frequency/
Date: Fri, 18 Mar 2016 01:53:33 +0100
Message-ID: <5813241.5vxuFgzBYr@vostro.rjw.lan>
References: <1457969342-23672-1-git-send-email-geert+renesas@glider.be> <56E7C45E.8080306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56046 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030602AbcCRAva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 20:51:30 -0400
In-Reply-To: <56E7C45E.8080306@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, March 15, 2016 05:14:22 PM Chanwoo Choi wrote:
> On 2016=EB=85=84 03=EC=9B=94 15=EC=9D=BC 00:29, Geert Uytterhoeven wr=
ote:
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/devfreq/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 64281bb2f6503c5a..4de78c552251a5a5 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -61,7 +61,7 @@ config DEVFREQ_GOV_USERSPACE
> >  	  Sets the frequency at the user specified one.
> >  	  This governor returns the user configured frequency if there
> >  	  has been an input to /sys/devices/.../power/devfreq_set_freq.
> > -	  Otherwise, the governor does not change the frequnecy
> > +	  Otherwise, the governor does not change the frequency
> >  	  given at the initialization.
> > =20
> >  comment "DEVFREQ Drivers"
> >=20
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Applied, thanks!

Rafael

