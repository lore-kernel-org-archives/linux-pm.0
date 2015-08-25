From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Make pm_genpd_init() available to modules
Date: Tue, 25 Aug 2015 11:08:16 -0700
Message-ID: <7hegirckbz.fsf@deeprootsystems.com>
References: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org>
	<CAMuHMdW2=+sNHFcBHNTGZrVT8Otx-LKyfywzo_q-ep1J1zic+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36056 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbHYSIZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 14:08:25 -0400
Received: by pacgr6 with SMTP id gr6so957443pac.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2015 11:08:25 -0700 (PDT)
In-Reply-To: <CAMuHMdW2=+sNHFcBHNTGZrVT8Otx-LKyfywzo_q-ep1J1zic+Q@mail.gmail.com>
	(Geert Uytterhoeven's message of "Fri, 14 Aug 2015 09:56:32 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Thu, Aug 13, 2015 at 8:21 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> Export symbol pm_genpd_init so it can be used in loadable
>> kernel modules
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Assuming you're aware of the consequences:
>   - Modular PM Domain drivers don't work for "critical" devices where the
>     driver is started from *OF_DECLARE(),
>   - This may depend on "PM / Domains: Return -EPROBE_DEFER if we fail to
>     init or turn-on domain" in pm/linux-next
>     https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=311fa6adf92c5110057daa439fdaff012864aa2b
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Right, things can get "interesting" and there are known limitations, but
we shouldn't prevent it, and also it might help us fix the above
limitations.

Acked-by: Kevin Hilman <khilman@linaro.org>

Rafael, can you pick this one up?  I think it's better to go through the
PM tree.  v4.2 would be ideal, but I realize it's probably a bit late
for that.

Kevin
