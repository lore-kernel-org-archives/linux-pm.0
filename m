From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Wed, 12 Jul 2017 19:38:04 +0530
Message-ID: <20170712140804.GG1679@vireshk-i7>
References: <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
 <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
 <20170712034150.GD17115@vireshk-i7>
 <9476e8ee-24ae-1676-067b-18a867892894@free.fr>
 <20170712100942.GF1679@vireshk-i7>
 <19d1613b-aea0-1ddf-e5b4-11e027402de1@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36388 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdGLOII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 10:08:08 -0400
Received: by mail-pg0-f46.google.com with SMTP id u62so13589940pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 07:08:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19d1613b-aea0-1ddf-e5b4-11e027402de1@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 12-07-17, 13:25, Mason wrote:
> I will test your patch on my 4.9 branch.
> 
> Does tango-cpufreq.c look acceptable to you?
> (I am aware the patch needs work in the the Kconfig/Makefile part.
> That was quick and dirty.)

Mostly yes. Just make sure everything is well handled when u send it.

-- 
viresh
