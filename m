From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Fri, 12 May 2017 21:48:28 +0530
Message-ID: <CAKohpomHH+GZ=4zRyVJz7OqGZ0cU=Qpm4f9xScMTDXyDk_brXA@mail.gmail.com>
References: <cover.1493203884.git.viresh.kumar@linaro.org> <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
 <20170428204803.plu467okibtxga4d@rob-hp-laptop> <m2inleux0w.fsf@baylibre.com>
 <20170508041511.GB17010@vireshk-i7> <m2pofeazo4.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38123 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933004AbdELQSa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 May 2017 12:18:30 -0400
Received: by mail-it0-f51.google.com with SMTP id e65so39975388ita.1
        for <linux-pm@vger.kernel.org>; Fri, 12 May 2017 09:18:30 -0700 (PDT)
In-Reply-To: <m2pofeazo4.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, "Nayak, Rajendra" <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 12 May 2017 at 20:29, Kevin Hilman <khilman@baylibre.com> wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:

>> Why should we do that?
>
> For starters, because the lack of it looks very strange upon first read
> (notice that both Rob and I pointed that out), and because you didn't
> explain why in the first place, it draws attention.

:)

>> I don't see why would we like to put some index value in the microvolts
>> property. We are setting the index value in the opp-hz property to avoid adding
>> extra fields and making sure opp-hz is still the unique property for the nodes.
>
> What about the case where firmware wants exact frequencies, and
> microvolts property is just an index?
>
> The point is, you have a very specific SoC and use-case in mind, but the
> goal of a binding change like this is to make something that could be
> generically useful.

I agree, but I am not sure of having such a case in very near future at least.
Wouldn't it be wise to not touch opp-microvolt for now and update it only
when needed? Its not a big change anyway..

>> Hmm, I am not sure how things are going to work in that case. The opp-hz value
>> read from the phandle is passed to the QoS framework in this series, which makes
>> sure that we select the highest requested performance point for a particular
>> power-domain. The index value is required to be present with the OPP framework
>> to make it all work, at least based on the way I have designed it for now.
>
> IMO, this kind of dependency isn't the job of the OPP framework, it's
> the job of the power-domain governor.

Okay. So the way it will work with the current suggestions is:

- OPP framework gets DVFS update request for device X
- OPP framework finds that the device has a power-domain and so it asks
  the power-domain framework to set the device in a particular state
  corresponding to the OPP (if we are going to a higher OPP).
- If the power-domain supports state selection, it does that or returns error.
  (Actually we can optimize this by asking the genpd initially if
state selection
   is possible, only then OPP core calls the genpd API).
- The genpd API will manage a list of all devices in the domain (which it
  already does) and also the states selected for them. It finds the max of
  the requested states and selects that.
- Note that the QoS framework isn't there in the picture anymore.

Will that be fine ?

--
viresh
