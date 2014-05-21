From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5] PM/OPP: discard duplicate OPPs
Date: Thu, 22 May 2014 01:48:43 +0200
Message-ID: <5258228.rMTDJps2Fm@vostro.rjw.lan>
References: <7cb6e0e039e0935e37c81d0f23d26b0b81ad8cda.1400597170.git.viresh.kumar@linaro.org> <1555967.8fxByr2j83@vostro.rjw.lan> <CAKohponU2feK9+9sUn4tu0t4fhwSy6PZuaAO3zkF7qRejCwM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63484 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752746AbaEUXbq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 19:31:46 -0400
In-Reply-To: <CAKohponU2feK9+9sUn4tu0t4fhwSy6PZuaAO3zkF7qRejCwM1Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Chander Kashyap <k.chander@samsung.com>

On Wednesday, May 21, 2014 09:33:42 AM Viresh Kumar wrote:
> On 21 May 2014 02:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> +     /* Duplicate OPPs ? */
> >> +     if (new_opp->rate == opp->rate) {
> >> +             int ret = (new_opp->u_volt == opp->u_volt) && opp->available ?
> >> +                     0 : -EEXIST;
> >
> > The parens are not necessary.  And is the direction correct?
> 
> What do you mean by direction here ?

The case in which we want to return 0.  Never mind, it's OK.  The parens are still
not necessary, though.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
