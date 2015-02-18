From: Martin Steigerwald <martin@lichtvoll.de>
Subject: [REGRESSION] fdo bug 86565 - black screen after resume from hibernation since linux kernel 3.18
Date: Wed, 18 Feb 2015 09:13:32 +0100
Message-ID: <2578139.MpDzvyvMS0@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:49217 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbBRINf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 03:13:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org

Hi!

I reported this with fdo for intel drivers back then as

https://bugs.freedesktop.org/86565

as I thought it to likely be an intel driver bug.


As it still happens and I am not sure of that anymore, I report here as=
=20
well. I still CC intel gfx list as well, as I didn=B4t get a comment on=
 the=20
debug log I attached to the bug report till now.


Since linux kernel 3.18-rc2 I sometimes get a black screen after resumi=
ng=20
from hibernation via in-kernel-suspend. With 3.17 I didn't have this=20
issue. Additionally, sometimes on hibernation the machine after writing=
=20
the image does not switch off, but stays on with the power LED blinking=
=2E I=20
then usually switch it off manually by pressing power button longer and=
 it=20
usually resumes just fine after it.

The first issue is most annoying and it seems they are unrelated, cause=
 as=20
I found now, the first issue happens even if the second one didn=B4t ha=
ppen=20
before. When the screen is black it takes some minutes usually and then=
 =20
it displays the lock screen again. As it doesn=B4t happen on every resu=
me=20
from hibernation and it may work okay for five or more attempts, bisect=
ing=20
this likely would take ages.

This is with a ThinkPad T520 with BIOS Version: 8AET63WW (1.43 ), Relea=
se=20
Date: 05/08/2013. The black screen happens with 3.18-rc2 upto 3.19-rc7.=
=20
With Intel Sandybridge graphics (no nvidia optimus).


I think it may be more of a general PM management issue, as I now heard=
=20
the the laptop was making the usual resume audio signal *after* the bla=
ck=20
screen delay. Thus I thought it may be stuck in general resume.


In comment #8 I attached a debug log with no_console_suspend drm.debug=3D=
0xe=20
initcall_debug as being asked for:

https://bugs.freedesktop.org/show_bug.cgi?id=3D86565#c8


I didn=B4t yet receive any comment on this.

Any further ideas?


If not I will test with 3.20-rc2 again and also try the patch Jani=20
mentioned in comment #7 in case its not in there.

Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
