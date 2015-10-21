From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / Domains: Don't measure ->start|stop() latency in system PM callbacks
Date: Thu, 22 Oct 2015 01:47:12 +0200
Message-ID: <3805270.x8nYq75MCT@vostro.rjw.lan>
References: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org> <20151021103126.GA16738@amd> <CAPDyKFp=qjqOY2w8ftNLWDWEG3V1MC7G9VQDwMcsQ8P-swDdow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53568 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755522AbbJUXSU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 19:18:20 -0400
In-Reply-To: <CAPDyKFp=qjqOY2w8ftNLWDWEG3V1MC7G9VQDwMcsQ8P-swDdow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Wednesday, October 21, 2015 02:47:12 PM Ulf Hansson wrote:
> On 21 October 2015 at 12:31, Pavel Machek <pavel@ucw.cz> wrote:
> > On Thu 2015-10-15 17:02:06, Ulf Hansson wrote:
> >> Measure latency does by itself contribute to an increased latency, thus we
> >> should avoid it when it isn't needed.
> >>
> >> Genpd measures latencies in the system PM phase for the ->start|stop()
> >> callbacks and is thus affecting the system PM suspend/resume time.
> >> Moreover these latencies are validated only at runtime PM suspend/resume.
> >>
> >> To this reasoning, let's decide to leave these measurements out of the
> >> system PM phase. There should be plenty of occasions during runtime PM to
> >> perform these measurements anyway.
> >
> > How much latency does the latency measure cause? Something like 0.000
> > msec?
> 
> Me and Lina did some measurement by hand a couple of weeks ago. If I
> remember correctly the results where in the range of a couple of us. I
> will check again and update you with some refreshed data.
> 
> For system PM the time saved might be negligible, depending on the
> number of devices that are attached to a genpd and on what level you
> try to optimize things for.
> 
> Perhaps this change then becomes more of a policy decision, rather
> than an a noticeable improvement. I certainly think dealing with
> device PM QoS constraints should belong to runtime PM and I think it's
> wrong/useless to do deal with this during system PM.

Right.  It should be used for runtime PM only.

Thanks,
Rafael

