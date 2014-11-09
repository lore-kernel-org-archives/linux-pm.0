From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: Linux Suspend Bug
Date: Sun, 09 Nov 2014 11:38:31 +0100
Message-ID: <2106186.JibaY09ivf@merkaba>
References: <545EB306.6040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:54942 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaKIKry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 05:47:54 -0500
In-Reply-To: <545EB306.6040207@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tabor Kvasnicka <kamakwazee@gmail.com>
Cc: linux-pm@vger.kernel.org

Am Samstag, 8. November 2014, 18:19:18 schrieb Tabor Kvasnicka:
> The mainline upstream version of the kernel has a bug that won't allo=
w
> for my computer to fully suspend.
>=20
> Link to bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D87961
>=20
> I have provided information based on the bug reporting instructions, =
but
> I will provide any other information you need to help fix this proble=
m.

I did not take time to report any of this already, but I randomly see t=
he=20
following with 3.18-rc2/3 with a ThinkPad T520:

1) On hibernating the ThinkPad sometimes does not switched of. The powe=
r LED=20
is blinking as if its still suspending. It completely saves the hiberna=
tion=20
image tough, cause if I switch it off hardly then it comes up with the=20
hibernation image just nice. This happened several times, but not it do=
esn=C2=B4t=20
happen always.

2) Today on resuming from hibernating I just got a black screen. I swit=
ched off=20
manually and the machine booted regularily after switching it on again.

I didn=C2=B4t report any of this, cause I fear this would take a lot of=
 time to=20
bisect or debug properly. And I am not willing to spend that time curre=
ntly=20
since there are more important things for me to attend to.

Maybe if there is an easy way to have it in text console and give all m=
essages=20
so I can make a photo from the display. But right now=E2=80=A6 all I ha=
ve is either=20
desktop lock screen or black screen without any ability to interact wit=
h the=20
machine. Well=E2=80=A6 I didn=C2=B4t try SSHing to it, from another lap=
top so far. At least=20
for the second scenario this might work, but I am quite sure it wouldn=C2=
=B4t work=20
for the first.

I think there is some regression regarding hibernation with 3.18 over 3=
=2E17.

Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
