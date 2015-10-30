From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/3] PM / OPP: opp-supported-hw and <prop>-name bindings
Date: Fri, 30 Oct 2015 12:26:22 -0500
Message-ID: <CAL_JsqLpGhvE44du+_oGb+3S9DvbxwOd47FdmXnhwNoiq3V3Cg@mail.gmail.com>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48689 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbbJ3R0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Oct 2015 13:26:47 -0400
In-Reply-To: <cover.1446167359.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 29, 2015 at 8:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rob/Stephen/Rafael,
>
> These bindings are discussed in detail earlier:
> http://marc.info/?l=linux-kernel&m=144237804923159&w=2
>
> and I was waiting for the multi-regulator series to get applied first,
> to post these patches.
>
> But that series is not moving at fast pace and probably its time to get
> other things going at least.
>
> These are already kind of approved by Rob and Stephen (these are the
> bindings we came up with for solving the issues reported by Lee Jones),
> but a formal Ack is still required to get them merged.
>
> The first patch enables us to select only a subset of OPPs from the
> bigger table, based on what version of the hardware we are running on.
>
> The second one enables us to select slightly different values for
> multiple properties, based on what kind of hardware they are running on.
>
> And the last one removes an (unused) binding, which is replaced by the
> second patch with a better solution.
>
> @Stephen/Rob: I already have working code for these bindings, which I
> shared with Lee earlier. Just that I need to rebase that without the
> multi-regulator series, will do that in coming days. But please see if
> we can get these Acked/merged before that :)

It looks okay to me, but I'll defer to Stephen and Lee as they are the users.

I'd imagine Rafael will tell you the same thing, but it is too late
for 4.4 anyway.

Rob

>
> Viresh Kumar (3):
>   PM / OPP: Add "opp-supported-hw" binding
>   PM / OPP: Add
>     {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
>   PM / OPP: Remove 'operating-points-names' binding
>
>  Documentation/devicetree/bindings/opp/opp.txt | 101 ++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 22 deletions(-)
>
> --
> 2.6.2.198.g614a2ac
>
