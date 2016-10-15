From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 6/6] cpufreq: pxa: convert to clock API
Date: Sat, 15 Oct 2016 21:42:26 +0200
Message-ID: <87wph95rh9.fsf@belgarion.home>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
        <1476130149-31834-7-git-send-email-robert.jarzmik@free.fr>
        <20161012023601.GC19385@vireshk-i7> <87mvia6q8p.fsf@belgarion.home>
        <20161012063247.GH19385@vireshk-i7> <87insy6kdq.fsf@belgarion.home>
        <20161012084044.GK19385@vireshk-i7> <87eg3l755x.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <87eg3l755x.fsf@belgarion.home> (Robert Jarzmik's message of
        "Wed, 12 Oct 2016 21:12:26 +0200")
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

>> In that case, what about making this driver depends_on !CONFIG_OF ? So
>> that the DT users don't use it anymore.
> Good idea, let me try it.
> I'll see if it actually works before make another iteration of this patch.

Okay, it works all right.

I'll split out this patch into several others, and make their review
independently of the clock serie.

Cheers.

-- 
Robert
