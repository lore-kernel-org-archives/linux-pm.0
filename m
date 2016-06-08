From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Fix set_policy interface for
 no_turbo
Date: Wed, 08 Jun 2016 08:39:53 -0700
Message-ID: <1465400393.25099.8.camel@linux.intel.com>
References: <1465346333-3104-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465346333-3104-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0g+9HAhfcdB30J16OugfbyvmS7eQokB9V0UCOjBuLDW-A@mail.gmail.com>
	 <CAJZ5v0gWgiur3J4kkCd4SNATke+7Qbxk14EJkmoXQm0kvaQuqA@mail.gmail.com>
	 <CAJZ5v0iUvAxH6kJYuKO0Ty7WiHtTPMUSOoMYFsLR26evvu_jCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36106 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbcFHPiT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jun 2016 11:38:19 -0400
In-Reply-To: <CAJZ5v0iUvAxH6kJYuKO0Ty7WiHtTPMUSOoMYFsLR26evvu_jCQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, 2016-06-08 at 03:24 +0200, Rafael J. Wysocki wrote:
> >=C2=A0

[...]
> On Wed, Jun 8, 2016 at 3:10 AM, Rafael J. Wysocki <rafael@kernel.org>
> wrote:
> > > policy->cpuinfo.max_freq =3D limits->turbo_disabled ?
> > > cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
> > > policy->cpuinfo.max_freq *=3D cpu->pstate.scaling;
> > But of course without GMail-induced whitespace breakage.
> So I went on and changed it this way before applying.=C2=A0=C2=A0Plea=
se check
> the result in bleeding-edge.
Checked. Looks good.

Thanks,
Srinivas
