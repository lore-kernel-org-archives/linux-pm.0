From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Wed, 2 Mar 2016 15:58:31 +0530
Message-ID: <20160302102831.GE2891@vireshk-i7>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
 <20160302025016.GS18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35996 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbcCBK2m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 05:28:42 -0500
Received: by mail-pf0-f170.google.com with SMTP id 63so2365935pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 02:28:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160302025016.GS18327@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>

On 02-03-16, 11:50, Mark Brown wrote:
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.

Okay. I thought keeping that on linux-pm would be sufficient for
interested folks to follow.

> I'm really not sure what I can say here that I've not already said
> repeatedly, what's new here?

Yeah, you have raised some genuine concerns earlier, like the sequence
in which the voltages of multiple supplies should be changed, and if
we should rely on some DT sequence for that.

I started it again, because we have a real case now (not like the
virtual case earlier) where a platform has multiple supplies for a
device (CPU). I just wanted to hear from all of you on how should we
go ahead and solve it.

TI guys had some crazy ideas, like using OPP-notifiers to update the
second regulator, etc and I really hated it :)

-- 
viresh
