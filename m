From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 0/1] ARM: cpuidle: heterogeneous systems extension
Date: Wed, 22 Apr 2015 09:55:07 +0100
Message-ID: <20150422085507.GA22601@red-moon>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48732 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813AbbDVIzK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Apr 2015 04:55:10 -0400
Content-Disposition: inline
In-Reply-To: <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Howard Chen <howard.chen@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>

On Tue, Apr 21, 2015 at 07:24:54PM +0100, Kevin Hilman wrote:
> On Thu, Apr 16, 2015 at 9:10 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> [...]
> 
> > This patch sets the maximum number of static CPUidle drivers allowed to
> > two, since it is hard to foresee systems with more than two sets of CPUs
> > having different idle states
> 
> It's not hard to forsee anymore:
> 
>    http://www.cnx-software.com/2015/04/21/mediatek-helio-x20-deca-core-processor/
>    https://liliputing.com/2015/04/closer-look-at-mediateks-upcoming-10-core-helio-x20-processor.html

Eheh I stand corrected :). Not a big deal, drivers can be allocated
dynamically; it seems that the designs above leave us no choice, the
idle states are the only differentiating factor when it comes
to CPUidle driver logical cpumask creation, happy to hear more
opinions on this, but I do not really see what we can use instead.

Thanks,
Lorenzo
