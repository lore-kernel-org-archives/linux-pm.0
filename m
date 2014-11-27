From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Thu, 27 Nov 2014 01:48:27 +0100
Message-ID: <13263114.169IokuYNX@vostro.rjw.lan>
References: <cover.1416910766.git.viresh.kumar@linaro.org> <11530150.5svHxl9OuM@vostro.rjw.lan> <CAKohpomz-kekRU7YD8_TYbeVRRs7WmrqLFT0yALxXwFGjwqNOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58088 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751659AbaK0A1L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:27:11 -0500
In-Reply-To: <CAKohpomz-kekRU7YD8_TYbeVRRs7WmrqLFT0yALxXwFGjwqNOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On Thursday, November 27, 2014 05:56:21 AM Viresh Kumar wrote:
> On 27 November 2014 at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > That should work if I'm not mistaken, but I'm wondering if we could
> > settle on using one RCU type for this (later, though).
> 
> We can convert all call sites to use SRCU then. Once we are sure about it.

Yes, later.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
