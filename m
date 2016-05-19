From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Thu, 19 May 2016 10:38:14 -0500
Message-ID: <573DDDE6.7070408@ti.com>
References: <573C9F45.5090109@ti.com> <573D60B4.7010906@gmail.com>
 <20160519091719.GL29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:55981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261AbcESPip (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 May 2016 11:38:45 -0400
In-Reply-To: <20160519091719.GL29844@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On 05/19/2016 04:17 AM, Pali Roh=C3=A1r wrote:
> On Thursday 19 May 2016 09:44:04 Ivaylo Dimitrov wrote:
>> Hi,
>>
>> On 18.05.2016 19:58, Andrew F. Davis wrote:
>>> Hello all,
>>>
>>> Why do we need this patch? I removed giving each battery a number i=
n its
>>> name intentionally. It doesn't seem to be needed anymore, and only =
two
>>> old drivers out of the ~70 power supply drivers do this.
>>>
>>
>> The patch is needed because commit <703df6c09795> breaks existing us=
erspace
>> on Nokia N900, which counts on name numbering. Also, commit <703df6c=
09795>
>> description says nothing about name changing, so I assumed it is an
>> unintentional side-effect of splitting the code into modules.
>=20
> Right, changing name cause breaking userspace and that commit does no=
t
> describe anything about changing name. So also from my perspective it=
 is
> regression.
>=20

=46air enough, I was unaware of the userspace breakage, the patch messa=
ge
only stated it was being put back because it used to exist.

Thanks for the clarification,
Andrew

P.S. The code is still a bit strange, I'll probably go grab one of the
N900s from our test farm and make sure my future cleanups don't break
this, but are we sure the *name* of a driver is an ABI? Sound like ABI
abuse by the N900 software to me, almost like telling Linus he can't
change the kernel version number because a userspace script depends on
"uname =3D=3D v2.6.x". :)
