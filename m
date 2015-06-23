From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 22:03:16 +0200
Message-ID: <1435089796.4528.53.camel@tiscali.nl>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
	 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
	 <1435046411.4528.6.camel@tiscali.nl> <20150623082857.GG3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb2-smtp-cloud3.xs4all.net ([194.109.24.26]:40082 "EHLO
	lb2-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754988AbbFWUDZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 16:03:25 -0400
In-Reply-To: <20150623082857.GG3245@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Tue, 2015-06-23 at 09:28 +0100, Lee Jones wrote:
> BTW, do you have a script that does this now, or are you still
> hand-rolling these?

There was a script detecting Kconfig problems that is basically
retired. (The messages I sent were always manually written.) That
script's function is now performed, much better, by the undertaker
-checkpatch bot (courtesy of a group of people apparently all
affiliated with the university of Erlangen, Germany). We're in virtual
contact but that group is doing fine so I'm basically not contributing.

Anyhow, my reply to your patch was the result of a manual scan for a
small set of common (and mostly trivial) mistakes in patches that I try
to do regularly. All pretty basic stuff, otherwise I wouldn't been able
to spot these mistakes.

Does this answer your question?


Paul Bolle
