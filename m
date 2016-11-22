From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Tue, 22 Nov 2016 09:19:22 +0530
Message-ID: <20161122034922.GC3070@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161118030636.GA3110@vireshk-i7>
 <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34281 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbcKVDt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 22:49:27 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so2702781pgx.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2016 19:49:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com

On 18-11-16, 10:43, Mark Brown wrote:
> On Fri, Nov 18, 2016 at 08:36:36AM +0530, Viresh Kumar wrote:
> 
> > Can we please get this series reviewed quickly and come to a conclusion? It has
> > already taken a lot of time getting this merged and the present code seems to be
> > the best possible shot we have, AFAIU.
> 
> There already seems to be extensive, ongoing discusion about this...

And I am quite sure we are stuck again :)

I just wanted to say that we should get it to some sort of conclusion. And yes I
want to say thanks to all who invested their time on this thread :)

So the LAST remaining question is:

"How do we know (from the DT) the order in which entries for multiple regulators
are present in the OPP table?"

And I am not sure if we can do that without having a property like:

+               supply-names = "vcc0", "vcc1", "vcc2";

in the OPP table or the consumer device. And surely it isn't a clean enough
solution and that's why this series relied on the code to get such details.

Does someone have an alternative? If NO, can we go ahead with this series as is?

-- 
viresh
