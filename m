From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC] Migrate to Hz resolution for OPP binding
Date: Thu, 22 May 2014 08:36:58 -0700
Message-ID: <7a3a47bd-db95-4255-8507-e6494607ea69@BL2FFO11FD018.protection.gbl>
References: <672dd8e9-2857-49fb-848f-d38d38b23c9b@BN1BFFO11FD024.protection.gbl>
 <CAL_Jsq+1_W_d1WWkMUsHZYKXV=t9MN70iR25bnA8Emzh8zb2mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:21487
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751088AbaEVPjM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 May 2014 11:39:12 -0400
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+1_W_d1WWkMUsHZYKXV=t9MN70iR25bnA8Emzh8zb2mg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Rob,

On Thu, 2014-05-22 at 08:27AM -0500, Rob Herring wrote:
> On Tue, May 20, 2014 at 5:30 PM, S=C3=B6ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> > Hi,
> >
> > I guess this is just to evaluate how big the lynch mob will be. Any=
way:
> > Triggered by this discussion https://lkml.org/lkml/2014/5/15/46, I
> > looked a little into what it would take to migrate everybody to Hz
> > frequency resolutions to avoid all the conversions between cpufreq,=
 CCF,
> > OPPs, etc.
> > Turns out, OPPs are already stored in Hz resolution in the kernel, =
but the DT
> > bindings use kHz resolution to specify them in DT. So, code-wise th=
ere
> > is just a removal of a multiplication in the OPP parser (see below)=
, but
> > then there are the DT bindings...
>=20
> Add this to the list of issues with the current OPP binding and defin=
e
> a new binding, not a band-aid.
>=20
> > As plan B, I was thinking to add the property 'operating-points-hz'=
=2E..
> >
> > Any better ideas?
>=20
> Fix clk_round_rate to specify how you want to round. There are
> usecases for both rounding up and down. Don't you have the same
> rounding problem with hz? Assume the person filling in OPP values
> knows nothing about the kernel and you could have values rounded both
> ways.

Yes the issue would not be resolved by this alone. But currently the CC=
=46
and OPPs in the kernel use Hz. And if you look at the interaction
between those frameworks with cpufreq, there are plenty of
multiplications/divisions by 1000 to convert between those, with even a
greater loss of accuracy. So, I think agreeing on using Hz as smallest
reasonable frequency resolution across all these frameworks would be a
first step into the right direction.

	Thanks,
	S=C3=B6ren
