From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 11:17:19 +0200
Message-ID: <20160519091719.GL29844@pali>
References: <573C9F45.5090109@ti.com>
 <573D60B4.7010906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33903 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372AbcESJRW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 05:17:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so19327618wmn.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 02:17:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <573D60B4.7010906@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Thursday 19 May 2016 09:44:04 Ivaylo Dimitrov wrote:
> Hi,
>=20
> On 18.05.2016 19:58, Andrew F. Davis wrote:
> >Hello all,
> >
> >Why do we need this patch? I removed giving each battery a number in=
 its
> >name intentionally. It doesn't seem to be needed anymore, and only t=
wo
> >old drivers out of the ~70 power supply drivers do this.
> >
>=20
> The patch is needed because commit <703df6c09795> breaks existing use=
rspace
> on Nokia N900, which counts on name numbering. Also, commit <703df6c0=
9795>
> description says nothing about name changing, so I assumed it is an
> unintentional side-effect of splitting the code into modules.

Right, changing name cause breaking userspace and that commit does not
describe anything about changing name. So also from my perspective it i=
s
regression.

> You are not listed and as I try to avoid making more noise than neede=
d when
> sending patches, I didn't include you in CC. Apologies if I should ha=
ve
> CC-ed you.

Maybe in future it could make sense to CC author of commit which
introduced regression...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
