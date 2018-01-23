From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/2] thermal: cpu_cooling: use power models from the
 OPP library
Date: Tue, 23 Jan 2018 08:17:57 +0530
Message-ID: <20180123024757.GB13020@vireshk-i7>
References: <20180119094549.5468-1-quentin.perret@arm.com>
 <20180119094549.5468-3-quentin.perret@arm.com>
 <CAJWu+orOoq3uKeaBnTjS+PytwXS3MwK+gasOCLNqj+QxXXZ7Ug@mail.gmail.com>
 <20180122051126.GD2421@vireshk-i7>
 <CAJWu+oqdS9LUqaKMWpS5gG-HAD5UGL8SW2ZxED55BR6Pvmbu=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:41717 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeAWCsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 21:48:02 -0500
Received: by mail-pf0-f173.google.com with SMTP id c6so5573293pfi.8
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2018 18:48:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJWu+oqdS9LUqaKMWpS5gG-HAD5UGL8SW2ZxED55BR6Pvmbu=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, Amit Kachhap <amit.kachhap@gmail.com>, javi.merino@kernel.org, rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On 22-01-18, 13:30, Joel Fernandes wrote:
> I think I wasn't articulating well enough what I meant but sorry if I
> missed something...
> 
> In the current code, if capacitance is not available, then
> update_freq_table -> dev_pm_opp_find_freq_ceil isn't called. However
> in the new code, with this patch, you're calling update_freq_table
> anyway and later discovering through the new 'found_power' variable
> that capacitance isn't possibly available. It seems the new code will
> be slower than the older one.
> 
> Instead of doing that, if you queried that capacitance isn't available
> in advance, then you could avoid finding that out later. Admittedly, I
> am new to these code paths so forgive me if I'm noisy, just trying to
> help. And thanks for explaining anything I missed.

No, you are correct. But this is init code and executes only once per cooling
device and so speed isn't a big issue for us right now. We may eventually have a
helper like that, just that we wanted to add it only after more than one user
needs it.

-- 
viresh
