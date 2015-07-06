From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 1/4] PM / devfreq: Add function to set max/min frequency
Date: Mon, 6 Jul 2015 09:47:36 +0100
Message-ID: <20150706084736.GA2772@e104805>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
 <1435928310-15938-2-git-send-email-javi.merino@arm.com>
 <CAJ0PZbQgW3hPuk-PXWqUrVfYhM1MWHDrRDOQE9vGxkS1Wb=AGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:46268 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751563AbbGFIro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 04:47:44 -0400
Content-Disposition: inline
In-Reply-To: <CAJ0PZbQgW3hPuk-PXWqUrVfYhM1MWHDrRDOQE9vGxkS1Wb=AGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, =?utf-8?B?w5hyamFu?= Eide <Orjan.Eide@arm.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Sat, Jul 04, 2015 at 03:44:08AM +0100, MyungJoo Ham wrote:
> On Fri, Jul 3, 2015 at 9:58 PM, Javi Merino <javi.merino@arm.com> wro=
te:
> > From: =C3=98rjan Eide <orjan.eide@arm.com>
> >
> > Factor out the logic to set minimum and maximum frequency for the d=
evice
> > so that it can be used by other parts of the kernel.
> >
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: =C3=98rjan Eide <orjan.eide@arm.com>
>=20
> Dear Javi,
>=20
> Is there reasons to name the function "devfreq_qos_set_[min|max]"? no=
t
> "devfreq_set_[min|max]"? The functions may be used by non-PM-qos
> components as well (e.g., thermal).

No, there are no reasons for those names.  I'll rename them to
devfreq_set_[min|max]

> And I like the idea of using devfreq devices as cooling devices. :)

Yes, we would like to be able to use them as passive cooling devices,
like what we do with cpufreq for the cpus.=20

> ps. I will be on a trip starting hours later for 8 days and then in a
> military training for 3 days. Please expect that my responses during
> the next 11-12 days will be very slow.

No worries.  Thanks,
Javi
