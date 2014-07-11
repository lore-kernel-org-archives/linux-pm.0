From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] cpufreq: ondemand: Eliminate the deadband effect
Date: Fri, 11 Jul 2014 20:34:14 +0200
Message-ID: <20140711183414.GA18951@amd.pavel.ucw.cz>
References: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr>
 <1404147574-17422-3-git-send-email-stratosk@semaphore.gr>
 <20140711165710.GA18033@amd.pavel.ucw.cz>
 <53C01F15.2090702@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36891 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbaGKSeR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jul 2014 14:34:17 -0400
Content-Disposition: inline
In-Reply-To: <53C01F15.2090702@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 2014-07-11 20:29:57, Stratos Karafotis wrote:
> Hi Pavel!
>=20
> On 11/07/2014 07:57 =CE=BC=CE=BC, Pavel Machek wrote:
> > Hi!
> >=20
> >> Tested on Intel i7-3770 CPU @ 3.40GHz and on ARM quad core 1500MHz=
 Krait
> >> (Android smartphone).
> >> Benchmarks on Intel i7 shows a performance improvement on low and =
medium
> >> work loads with lower power consumption. Specifics:
> >>
> >> Phoronix Linux Kernel Compilation 3.1:
> >> Time: -0.40%, energy: -0.07%
> >> Phoronix Apache:
> >> Time: -4.98%, energy: -2.35%
> >> Phoronix FFMPEG:
> >> Time: -6.29%, energy: -4.02%
> >=20
> > Hmm. Intel i7 should be race-to-idle machine. So basically rule lik=
e
> > if (load > 0) go to max frequency else go to lowest frequency would=
 do
> > the right thing in your test, right?
>=20
> I don't think that "if (load > 0) go to max" will work even on i7.
> For low load this will have impact on energy consumption.

Are you sure? CPU frequency should not matter on idle CPU.

(Can you try to modify your code and rerun for example the apache
test?)

> > So... should we do that, or do we need better benchmark?
>=20
> I'm sorry. I'm not sure I understood exactly what do you mean by "bet=
ter
> benchmark".

I believe that any increase of frequency in frequency will make the
benchmarks you qouted better (on i7). Actually, you can probably just
select performance governor...?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
