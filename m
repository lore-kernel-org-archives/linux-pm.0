From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 08:02:19 -0700
Message-ID: <00a001cf8586$24eb5c70$6ec21550$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr> <009b01cf857a$d5032090$7f0961b0$@net> <539862DB.9060905@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:41974 "EHLO cmta18.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbaFKPCX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 11:02:23 -0400
In-Reply-To: <539862DB.9060905@semaphore.gr>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com


On 2104.06.11 07:08 Stratos Karafotis wrote:
> On 11/06/2014 04:41 =CE=BC=CE=BC, Doug Smythies wrote:
>=20
> No.
>=20
> The intent was only ever to round properly the pseudo floating point =
result of the divide.
> It was much more important (ugh, well 4 times more) when FRACBITS was=
 still 6, which also got changed to 8 in a recent patch.
>=20

Are you sure?

Yes.

> This rounding was very recently added.
> As far as I can understand, I don't see the meaning of this rounding,=
 as is.
> Even if FRAC_BITS was 6, I think it would have almost no improvement =
in
> calculations.

Note: I had not seen this e-mail when I wrote a few minutes ago:

You may be correct.
If Dirk agrees, I will re-analyse the entire driver for rounding effect=
s soon.
When FRACBITS was 6 there were subtle cases where the driver would get =
stuck, and not make a final pstate change, with the default PID gains.
Other things have changed, and the analysis needs to be re-done.

=2E.. Doug


