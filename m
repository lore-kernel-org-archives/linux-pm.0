From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 09:44:04 +0300
Message-ID: <573D60B4.7010906@gmail.com>
References: <573C9F45.5090109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33147 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbcESGoI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 02:44:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so18365410wme.0
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 23:44:06 -0700 (PDT)
In-Reply-To: <573C9F45.5090109@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Hi,

On 18.05.2016 19:58, Andrew F. Davis wrote:
> Hello all,
>
> Why do we need this patch? I removed giving each battery a number in =
its
> name intentionally. It doesn't seem to be needed anymore, and only tw=
o
> old drivers out of the ~70 power supply drivers do this.
>

The patch is needed because commit <703df6c09795> breaks existing=20
userspace on Nokia N900, which counts on name numbering. Also, commit=20
<703df6c09795> description says nothing about name changing, so I=20
assumed it is an unintentional side-effect of splitting the code into=20
modules.

> Also I don't see this in my mailbox archive, was I CC'd on this patch=
?
>

You were not, get_maintainer.pl on v4.4-rc7 (the tree I was working on=20
by the time I've sent <9aafabc7fece>, iirc) gives:

Sebastian Reichel <xxx@xxx.org> (maintainer:POWER SUPPLY CLASS/SUBSYSTE=
M=20
and DRIVERS)
Dmitry Eremin-Solenikov <xxx@xxx.org> (maintainer:POWER SUPPLY=20
CLASS/SUBSYSTEM and DRIVERS)
David Woodhouse <xxx@xxx.org> (maintainer:POWER SUPPLY CLASS/SUBSYSTEM=20
and DRIVERS)
"Pali Roh=C3=A1r" <xxx@xxx.org> (maintainer:NOKIA N900 POWER SUPPLY DRI=
VERS)
linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and=20
DRIVERS)
linux-kernel@vger.kernel.org (open list)
(mail addresses masked by me)

You are not listed and as I try to avoid making more noise than needed=20
when sending patches, I didn't include you in CC. Apologies if I should=
=20
have CC-ed you.

Ivo
