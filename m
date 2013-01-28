From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM/CORE: Fix using sizeof without parenthesis in the sysfs.c
Date: Mon, 28 Jan 2013 14:13:14 +0100
Message-ID: <13740912.iO1omHu2tD@vostro.rjw.lan>
References: <1359361909-28793-1-git-send-email-tianyu.lan@intel.com> <3030648.5OBcUztiBY@vostro.rjw.lan> <5106775D.1080101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57790 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab3A1NHG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jan 2013 08:07:06 -0500
In-Reply-To: <5106775D.1080101@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: James Courtier-Dutton <james.dutton@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, January 28, 2013 09:04:29 PM Lan Tianyu wrote:
> =E4=BA=8E 2013/1/28 20:18, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Monday, January 28, 2013 09:03:28 AM James Courtier-Dutton wrote=
:
> >> On 28 January 2013 08:31, Lan Tianyu <tianyu.lan@intel.com> wrote:
> >>> -       if (len =3D=3D sizeof ctrl_auto - 1 && strncmp(buf, ctrl_=
auto, len) =3D=3D 0)
> >>> +       if (len =3D=3D sizeof(ctrl_auto - 1) && strncmp(buf, ctrl=
_auto, len) =3D=3D 0)
> >>
> >> This looks wrong to me.
> >> sizeof ctrl_auto - 1
> >> is not the same value as
> >> sizeof(ctrl_auto - 1)
> >> because sizeof(x) is normally the same as sizeof(x - 1), unless si=
zeof
> >> x and sizeof 1 are different.
> >> Consider that is maybe should be:
> >> if (len =3D=3D (sizeof(ctrl_auto) - 1)) && strncmp(buf, ctrl_auto,=
 len) =3D=3D 0)
> Hi James:
> 	Yes. You are correct. Thanks for your review.
> >
> > The outer parentheses in the comparison with len are not necessary.
> >
> >> I a not sure what the correct answer is for this particular bit of
> >> code, because I have not looked at it in detail,I just wanted to p=
oint
> >> out that the brackets might be in the wrong place here.
> >
> > You are right and the patch doesn't make sense.
> Hi Rafael:
> 	So this patch is not necessary?

It is incorrect in the first place.

Yes, you could change spaces to parentheses in those places, but first,=
 please
do that correctly and second, it's just going to be a cosmetic change. =
 The
code works as is.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
