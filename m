From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Tue, 16 Jul 2013 01:25:13 +0200
Message-ID: <2233063.0GCWqjjfbB@vostro.rjw.lan>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <6515593.XAmN11qlGF@vostro.rjw.lan> <51E4337A.7020509@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43976 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab3GOXPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 19:15:23 -0400
In-Reply-To: <51E4337A.7020509@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, viresh.kumar@linaro.org, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, July 15, 2013 07:38:02 PM Toralf F=C3=B6rster wrote:
> On 07/12/2013 12:33 AM, Rafael J. Wysocki wrote:
> > I'm going to take [1/8] for 3.11 and queue up the rest for 3.12 if =
people don't
> > hate them.  This way we'll have some more testing coverage before t=
hey reach
> > the mainline hopefully.
>=20
> Applied patch 1#8 on top of v3.11-rc1-8-g47188d3 passes two s2ram/wak=
eup

Sorry, I have no idea what 1#8 means.

> cycles fine and crashed the system at the 3rd attempt / one times jus=
t
> at the 4th (blinking power led, no sysrq, ...).
>=20
> Applying patch 1-8 on top of that tree differs in that way that it
> crashes now the system even at the 1st attempt or at least at the 2nd

What are you talking about?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
