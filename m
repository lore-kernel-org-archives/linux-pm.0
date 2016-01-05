From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/2] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Tue, 5 Jan 2016 16:16:30 +0530
Message-ID: <20160105104630.GB30120@ubuntu>
References: <cover.1449627691.git.viresh.kumar@linaro.org>
 <e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
 <CAMuHMdUXHU7d_X9PpWTVDc9iE3knd0N-iQKT2FeDhX6mOg13tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34483 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbcAEKqf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 05:46:35 -0500
Received: by mail-pf0-f178.google.com with SMTP id e65so165594140pfe.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2016 02:46:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMuHMdUXHU7d_X9PpWTVDc9iE3knd0N-iQKT2FeDhX6mOg13tg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>

On 05-01-16, 11:31, Geert Uytterhoeven wrote:
> Any chance an attacker can overflow name[] by providing a very long
> dev_opp->prop_name?
> 
> Better safe than sorry:
> 
>         snprintf(name, sizeof(name), ...);

Sent a patch to you..

-- 
viresh
