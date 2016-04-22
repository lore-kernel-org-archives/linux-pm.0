From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V4] intel_pstate: Use avg_pstate instead of
 current_pstate
Date: Fri, 22 Apr 2016 09:26:29 -0700
Message-ID: <1461342389.4435.30.camel@linux.intel.com>
References: <1459754617-8872-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1662176.YWLDtbbot1@vostro.rjw.lan>
	 <1461286745.8946.203.camel@linux.intel.com>
	 <CAJZ5v0hMTanSQQ9VX2YbTgRvtUkkTDJAJSYcHGxAdtm=xEHE6g@mail.gmail.com>
	 <004701d19caa$4644c360$d2ce4a20$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5286 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbcDVQ3r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 12:29:47 -0400
In-Reply-To: <004701d19caa$4644c360$d2ce4a20$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Philippe Longepe' <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>

Hi Doug,

On Fri, 2016-04-22 at 08:18 -0700, Doug Smythies wrote:
> Srinivas,
>=20
> Recall a couple of months ago, on the "Increase hold-off time before
> busyness is scaled"
> thread, Stephane suggested we try applying this method on the
> get_target_pstate_use_performance
> branch of the intel_pstate driver, as opposed to just on the
> get_target_pstate_use_cpu_load branch.
>=20
> It didn't make any difference with respect to the hold-off time
> issue.
> However, I did spend considerable time testing it in other scenarios.
> It does somewhat temper the occasional tendency to suddenly have a
> ridiculously high
> scaled busy number with virtually no load (the same issue from the
> "[intel-pstate driver regression] processor frequency very high even
> if in idle" thread,
> that continued in https://bugzilla.kernel.org/show_bug.cgi?id=3D11577=
1=20
> )
> I didn't find any significant regression, and did observe some small
> energy savings
> in some scenarios (admittedly, small enough to have possibly been
> simply test to test
> variations, and I didn't do enough tests to extract a definite
> trend).
>=20
> I am suggesting to consider extending the patch to
> get_target_pstate_use_performance also.
>=20
Many core platforms have per core P states. So here the assumption that
we get a boost of P State on one core because some activity on other
core will not hold true.

We are experimenting with algorithm to improve core performance
(similar approach as yours + IO boost), hopefully we can publish soon.

Thanks,
Srinivas


> ... Doug
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
