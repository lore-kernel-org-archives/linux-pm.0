From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Tue, 15 Dec 2015 15:34:17 -0800
Message-ID: <003a01d13791$1edfbce0$5c9f36a0$@net>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com> <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan> <48DF4267-671B-40E2-8C95-CCF5795F8B26@linux.intel.com> <001c01d136bc$a4a78a90$edf69fb0$@net> <566FEBB8.5090008@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta15.telus.net ([209.171.16.88]:54628 "EHLO cmta15.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932286AbbLOXeW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 18:34:22 -0500
In-Reply-To: <566FEBB8.5090008@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Philippe Longepe' <philippe.longepe@linux.intel.com>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>
Cc: 'Thomas Renninger' <trenn@suse.de>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Len Brown' <lenb@kernel.org>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 'Prarit Bhargava' <prarit@redhat.com>, viresh.kumar@linaro.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>

On 2015.12.15 02:30 Philippe Longepe wrote:
> On 14/12/2015 23:13, Doug Smythies wrote:
>> On 2015.12.14 08:15 Stephane Gasparini wrote:
>>
> In the table sent by stephane, "performance" meant "original algorith=
m"=20
> based on average pstate (aperf/mperf).

Oh.

> On Atoms, a setpoint of 60 is not too high. With higher setpoints we'=
ll=20
> not be able to reach meet some performance KPIs

Define "KPI"

> (some frames are dropped mainly for gaming use cases). However, we ar=
e=20
> working on a more power conservative algorithm).

I do not think the issue / challenge is specific to Atom.

>>
>> I think that a more comparable test would be a 50% (or whatever) loa=
d
>> calibrated to a nominal CPU frequency (I use the max non-turbo CPU
>> frequency, but it can be anything.) Meaning that the once the fixed
>> packet of work is done, the CPU can go idle sooner or later, dependi=
ng
>> on the CPU frequency.
> Are you using an existing tool for doing that or did you developed yo=
ur=20
> own tool ?

While he would not recognize it now, I mainly use a simple program that
Peter Zijlstra gave me a few years ago, consume.c. However, I added fix=
ed
work packet mode, to satisfy a need for something more representative o=
f
real world periodic workflows.

I'll send it to you off-list.

On 2015.12.15 05:07 Stephane Gasparini wrote:

> Well you misunderstood the power numbers I guess
> e.g. if you watch a movie for 1h30, it will last 1h30 not matter what=
 is the=20
> average power, so the lower is the average power the better it is.

O.K. I didn=E2=80=99t know all of those tests had to run for whatever t=
ime.
But for the performance list of tests, there is no energy information.
I'm just saying that it might matter for some, as in ffmpeg example I g=
ave.

> Here are the detail for Application install
>
> Intel PState    Intel PState   =20
> Performance     CPU Load     =20
> =E2=89=85 799 mW (28 s)	=E2=89=85 383 mW (34 s)
> =E2=89=85 29 mW/s	=E2=89=85 11 mW/s

Wouldn't the correct terminology be 22.4 Joules and 13.0 Joules
to do the job?
Or 42% energy saved at a cost of 21% extra time.

Anyway, you made your point.

=2E.. Doug


