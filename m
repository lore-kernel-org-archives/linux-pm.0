From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Wed, 12 Jul 2017 15:39:42 +0530
Message-ID: <20170712100942.GF1679@vireshk-i7>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
 <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
 <20170712034150.GD17115@vireshk-i7>
 <9476e8ee-24ae-1676-067b-18a867892894@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34816 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756180AbdGLKJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 06:09:50 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so10651774pfk.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 03:09:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9476e8ee-24ae-1676-067b-18a867892894@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 12-07-17, 11:58, Mason wrote:
> I would object to the characterization of "just a PLL" :-)
> 
> The PLL outputs "garbage" before actually "locking" a target
> frequency. It is not possible for the CPU to blindly change
> the PLL settings, because that crashes the system.
> 
> The bootloader implements the steps required to change said
> settings, so the strategy has been: have Linux use whatever
> PLL frequency the bootloader programs.
> 
> Behind the PLL, there is a glitch-free divider, which is able
> to divide the PLL output without crashing the system. I've
> been using that divider for DFS.
> 
> drivers/clk/clk-tango4.c

Okay, got it now.

Yes, you *really* need to create these OPPs dynamically. I am
convinced now :)

-- 
viresh
