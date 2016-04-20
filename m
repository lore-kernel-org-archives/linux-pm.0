From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 1/2] perf/x86/intel/rapl: support Skylake RAPL domains
Date: Wed, 20 Apr 2016 08:54:26 -0700
Message-ID: <1461167666.8946.107.camel@linux.intel.com>
References: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1460930581-29748-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160420154320.GE3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43956 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbcDTPyC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Apr 2016 11:54:02 -0400
In-Reply-To: <20160420154320.GE3408@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org

On Wed, 2016-04-20 at 17:43 +0200, Peter Zijlstra wrote:
> On Sun, Apr 17, 2016 at 03:03:00PM -0700, Srinivas Pandruvada wrote:
> >=20
> > @@ -729,6 +771,11 @@ static int __init rapl_pmu_init(void)
> > =C2=A0		rapl_cntr_mask =3D RAPL_IDX_SRV;
> > =C2=A0		rapl_pmu_events_group.attrs =3D
> > rapl_events_srv_attr;
> > =C2=A0		break;
> > +	case 78: /* Skylake client */
> > +	case 94: /* Skylake H/S */
> > +		rapl_cntr_mask =3D RAPL_IDX_SKL_CLN;
> > +		rapl_pmu_events_group.attrs =3D
> > rapl_events_skl_attr;
> > +		break;
> > =C2=A0	case 87: /* Knights Landing */
> > =C2=A0		apply_quirk =3D true;
> > =C2=A0		rapl_cntr_mask =3D RAPL_IDX_KNL;
> Please post this against tip/perf/core, all this code got munged in
> patch:
>=20
> =C2=A0 4b6e2571bf00 ("x86/perf/intel/rapl: Make the Intel RAPL PMU dr=
iver
> modular")
I will repost.

>=20
> Also; what about 85 (skl-server)?
I didn't get chance to test RAPL on SKL server. It should follow BDW
server, but want to test before.

Thanks,
Srinivas

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
