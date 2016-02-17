From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Documentation: cpufreq: intel_pstate: fix typo
Date: Wed, 17 Feb 2016 10:38:32 -0800
Message-ID: <1455734312.7375.168.camel@linux.intel.com>
References: <1455733473-1856-1-git-send-email-felipe@nutanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6664 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030205AbcBQSkA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Feb 2016 13:40:00 -0500
In-Reply-To: <1455733473-1856-1-git-send-email-felipe@nutanix.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Franciosi <felipe@nutanix.com>, linux-pm@vger.kernel.org

On Wed, 2016-02-17 at 18:24 +0000, Felipe Franciosi wrote:
> This just fixes a typo in the intel_pstate documentaion.
>=20
You are adding typo in the commit message..
Also I will not call the change a typo, rather remove trailing colon
from policy "performance".

> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
> =C2=A0Documentation/cpu-freq/intel-pstate.txt |=C2=A0=C2=A0=C2=A0=C2=A0=
2 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/cpu-freq/intel-pstate.txt
> b/Documentation/cpu-freq/intel-pstate.txt
> index f7b12c0..e6bd1e6 100644
> --- a/Documentation/cpu-freq/intel-pstate.txt
> +++ b/Documentation/cpu-freq/intel-pstate.txt
> @@ -25,7 +25,7 @@ callback, so cpufreq core can't request a
> transition to a specific frequency.
> =C2=A0The driver provides minimum and maximum frequency limits and
> callbacks to set a
> =C2=A0policy. The policy in cpufreq sysfs is referred to as the "scal=
ing
> governor".
> =C2=A0The cpufreq core can request the driver to operate in any of th=
e two
> policies:
> -"performance: and "powersave". The driver decides which frequency to
> use based
> +"performance" and "powersave". The driver decides which frequency to
> use based
> =C2=A0on the above policy selection considering minimum and maximum
> frequency limits.
> =C2=A0
> =C2=A0The Intel P-State driver falls under the latter category, which
> implements the
