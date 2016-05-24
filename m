From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Enforce _PPC limits
Date: Tue, 24 May 2016 15:11:45 -0700
Message-ID: <1464127905.4603.11.camel@linux.intel.com>
References: <21572dff-ea5d-c0f3-6f48-66c9d38eda65@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64588 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbcEXWM1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 May 2016 18:12:27 -0400
In-Reply-To: <21572dff-ea5d-c0f3-6f48-66c9d38eda65@hpe.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Linda,

On Tue, 2016-05-24 at 16:37 -0400, Linda Knippers wrote:
> Hi Srinivas,
>=20
> I have a couple of questions about this patch set.
> http://comments.gmane.org/gmane.linux.power-management.general/75263
>=20
> Sorry I'm a bit late to the party but I've just booted 4.6 on my
> system
> and noticed some things.
>=20
> My first question is about enabling the feature by default on
> enterprise
> and performance servers.=C2=A0=C2=A0Is there any way to disable it on=
 these
> servers?
> I didn't see a way.=C2=A0=C2=A0I'm always nervous when something star=
ts looking
> at
> a table that perhaps wasn't used before or introduces a new behavior
> that
> might be unexpected.=C2=A0=C2=A0Having a way out or not making it the=
 default
> for a
> while would be nice.
If you were using acpi-cpufreq ever , this would have been active
anyway.
This was requested by some server vendors to turn on by default as they
want to be able to use node manager to control and don't want to have
any kernel command line addition.

Don't you want to be able to use _PPC to control. If you don't use _PPC
then this will not be effective.
You can turn off from kernel command line=C2=A0processor.ignore_ppc=3D1

>=20
> My second question is about the 48 instances I got of this when I
> booted my
> 2 socket, 48-CPU box:
>=20
> > intel_pstate: _PPC limits will be enforced
> I suppose in theory I could have limits for some CPUs and not others
> but
> even in that case, the message isn't helpful.=C2=A0=C2=A0I think it s=
hould be
> made
> useful or go away, or at least only be printed once.
>=20
Agree, I will downgrade the message to pr_debug.

Thanks,
Srinivas
>=C2=A0
> Thanks,
>=20
> -- ljk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
