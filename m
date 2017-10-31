From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Tue, 31 Oct 2017 11:02:51 -0500
Message-ID: <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
References: <cover.1509453284.git.viresh.kumar@linaro.org> <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdJaQDN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Oct 2017 12:03:13 -0400
In-Reply-To: <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Oct 31, 2017 at 7:47 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On some platforms the exact frequency or voltage may be hidden from the
> OS by the firmware. Allow such configurations to pass magic values in
> the "opp-hz" or the "opp-microvolt" properties, which should be
> interpreted in a platform dependent way.

Why not a new property for magic values? opp-magic? Don't we want to
know when we have magic values?

Wouldn't magic values in opp-hz get propagated to user space? I can
see the complaints now. "My 4GHz processor is running at 6Hz!" Just
like people complain when BogoMIPS is not high enough.

Rob
