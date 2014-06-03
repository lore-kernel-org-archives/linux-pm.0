From: Pavel Machek <pavel@ucw.cz>
Subject: Re: autosleep suspend too frquent problem
Date: Tue, 3 Jun 2014 14:01:28 +0200
Message-ID: <20140603120128.GA5080@amd.pavel.ucw.cz>
References: <35FD53F367049845BC99AC72306C23D1029A27656A2D@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A27656A2D@CNBJMBX05.corpusers.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'len.brown@intel.com'" <len.brown@intel.com>, "'rjw@sisk.pl'" <rjw@sisk.pl>, "'linux-pm@vger.kernel.org'" <linux-pm@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!


> I found sd card sometimes are damaged/ destroyed=20
> On our devices .
> And seems it is caused by kernel's frequently suspend/resume,
> Because during suspend/resume, the driver will suspend/resume sdcard
> Very frequently, this will damaged the sdcard sometimes, and the dama=
ge
> is not recoverable ..
>=20
> Sometimes kernel will enter suspend and exit suspend very frequently,
> Especially when the system is in idle, but some driver is not idle,
> And it will  wake up the system by irq frequently.
> By our power test result, if system enter suspend /resume very freque=
ntly,
> Will consume more power , because it will enable /disable many device=
s
> During a short time .
>=20
> I make a patch to prevent the system to enter suspend/resume state
> More than one time during 2 seconds=EF=BC=9A

It is good you managed to diagnose the problem, but this si not the
right solution.

Either:

1) don't power down SD card during system suspend

or maybe even better

2) don't power _up_ SD card during system resume. Let it be powered
down until the first access.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
