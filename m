From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable HWP by default
Date: Thu, 25 Feb 2016 15:33:51 -0800
Message-ID: <1456443231.17628.24.camel@linux.intel.com>
References: <1456441759-4877-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <7409824.yRBnCff0bU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9858 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbcBYXfW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 18:35:22 -0500
In-Reply-To: <7409824.yRBnCff0bU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org

On Fri, 2016-02-26 at 00:19 +0100, Rafael J. Wysocki wrote:
> On Thursday, February 25, 2016 03:09:19 PM Srinivas Pandruvada wrote:
> > If the processor supports HWP, enable it by default without
> > checking
> > for the cpu model. This will allow to enable HWP in all supported
> > processors without driver change.
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
>=20
> Isn't that a bit risky in the face of recent experience?
Good question. The current systems which are commercial, already have
cpuid added in our list, so HWP will be enabled anyway.
The one system we know there is an issue, hope we can debug before
merge window start.
If I don't do, I have to add few more ids to the list.

Let's wait for few more weeks to review and merge this. I will let
anybody from the community comment, who are using Skylake.

Thanks,
Srinivas

>=20
> Rafael
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
