From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 14:03:07 +0200
Message-ID: <E1I5h64-0000fs-34__8430.80948475308$1183464516$gmane$org@be1.lrz>
References: <8CIbE-3y1-1@gated-at.bofh.it> <8CJKt-62G-35@gated-at.bofh.it>
	<8CKZS-7Ur-3@gated-at.bofh.it> <8CLjc-8iq-29@gated-at.bofh.it>
	<8CO7m-4k4-11@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>, oliver@neukum.org, linux-pm@lists.linux-foundation.org, benh@kernel.crashing.org, nigel@nigel.suspend2.net, mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

>> > So to summarize, the plan that makes things work with fuse is:
>> >=20
>> > - For STR, don't do the freezer thing.
>> >=20
>> > - For STD, don't sys_sync() after you froze
>> >=20
>> > There might be -other- issues, but that should get you through some =
of
>>=20
>> At the risk of repeating myself. Character device drivers are written
>> with the assumption that normal io and suspend/resume do not race
>> with each other due to the freezer.
>> What do you intend to do about that?
>=20
> Oliver, can you please explain your worries in a bit more detail?

Try suspending while printing.
--=20
What's worse than a Male Chauvinist Pig?
A woman that won't do what she's told.

Fri=DF, Spammer: tgyvaxz@.qcLz7l.7eggert.dyndns.org
