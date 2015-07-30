From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 02/16] PM / OPP: Create a directory for opp bindings
Date: Thu, 30 Jul 2015 19:19:59 +0530
Message-ID: <20150730134959.GB17794@linux>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <4dfe565ff17766b7df127d475d84958e96fdab1b.1438166099.git.viresh.kumar@linaro.org>
 <CAL_Jsq+J41c7qx11L13-g0UyD+hY9W36Wu9P+6O3cnDv7ysY6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33509 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbG3NuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 09:50:06 -0400
Received: by pdbnt7 with SMTP id nt7so25026667pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 06:50:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+J41c7qx11L13-g0UyD+hY9W36Wu9P+6O3cnDv7ysY6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On 30-07-15, 08:18, Rob Herring wrote:
> On Wed, Jul 29, 2015 at 5:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > More platform specific extended opp bindings will follow and it would be
> > easy to manage them with a directory for opp. Lets create that and move
> > the existing opp bindings into it.
> >
> > Cc: Rob Herring <rob.herring@linaro.org>
> 
> Use get_maintainers.pl please so you send to right people and right email.

Already done, you were just cc'd as an extra guy :)

> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/power/{ => opp}/opp.txt | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)
> >
> > diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp/opp.txt
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/power/opp.txt
> > rename to Documentation/devicetree/bindings/power/opp/opp.txt
> 
> "power" seems to be a random collection of things. I'd prefer you move
> this to .../bindings/opp/opp.txt.

Hmm, sure. That would be better I think.

--------------8<-------------------

Message-Id: <29597667e2c8afdbf396c5fcc9269fb27794131c.1438264123.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 27 Jul 2015 10:04:21 +0530
Subject: [PATCH] PM / OPP: Create a directory for opp bindings

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

Cc: Rob Herring <rob.herring@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/{power => opp}/opp.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{power => opp}/opp.txt (100%)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/opp.txt
rename to Documentation/devicetree/bindings/opp/opp.txt
