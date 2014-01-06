From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: try to resume policies which failed on last resume
Date: Mon, 06 Jan 2014 12:33:09 +0100
Message-ID: <43419777.Exys3DrW83@vostro.rjw.lan>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org> <87a9f92xnn.fsf@nemi.mork.no> <CAKohpon7u_1h+9rKQeC8J4Pqd_6bSajn7Ag8=COqczhbSPEgMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62648 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752144AbaAFLTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2014 06:19:24 -0500
In-Reply-To: <CAKohpon7u_1h+9rKQeC8J4Pqd_6bSajn7Ag8=COqczhbSPEgMA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, January 06, 2014 04:24:09 PM Viresh Kumar wrote:
> On 6 January 2014 16:19, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
> > I cancelled by pressing backspace while the image was being written=
=2E

Basically, stuff is still frozen at this point, but devices are fully
functional.  It's kind of like returning an error code from swsusp_writ=
e()
in hibernate() (kernel/power/hibernate.c).

> I will answer other queries on next mail, but a quick question:
> Do you get these warnings even if you don't cancel hibernation?

Good question. :-)

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
