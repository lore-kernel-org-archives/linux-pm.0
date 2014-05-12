From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFC PATCH] cpufreq: intel_pstate: Change the calculation of
 next pstate
Date: Tue, 13 May 2014 04:01:40 +0800
Message-ID: <20140512200140.GA10676@intel.com>
References: <5368255D.3090207@semaphore.gr>
 <536BEE89.3040602@gmail.com>
 <536CECB4.1090109@semaphore.gr>
 <53712F4B.7000101@semaphore.gr>
 <20140512193453.GB9351@intel.com>
 <537198AE.3050100@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34875 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbaEMEGp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 00:06:45 -0400
Content-Disposition: inline
In-Reply-To: <537198AE.3050100@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Tue, May 13, 2014 at 06:59:42AM +0300, Stratos Karafotis wrote:
> Hi,
>=20
> On 12/05/2014 10:34 =CE=BC=CE=BC, Yuyang Du wrote:
> > On Mon, May 12, 2014 at 11:30:03PM +0300, Stratos Karafotis wrote:
> >> On 09/05/2014 05:56 =CE=BC=CE=BC, Stratos Karafotis wrote:
> >>
> >> Next performance state =3D min_perf + (max_perf - min_perf) * load=
 / 100
> >>
> > Hi,
> >=20
> > This formula is fundamentally broken. You need to associate the loa=
d with its
> > frequency.
>=20
> Could you please explain why is it broken? I think the load should be
> independent from the current frequency.

Why independent? The load not (somewhat) determined by that?

