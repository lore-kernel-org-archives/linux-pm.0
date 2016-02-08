From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Mon, 8 Feb 2016 18:46:25 +0530
Message-ID: <20160208131625.GI8294@vireshk>
References: <56B4D4BE.2040008@free.fr>
 <45004963.Im3DmqJ5ez@wuerfel>
 <20160208124127.GF8294@vireshk>
 <22002072.L04zy0K2AP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34060 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbcBHNQ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:16:29 -0500
Received: by mail-pa0-f53.google.com with SMTP id uo6so74922043pac.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 05:16:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <22002072.L04zy0K2AP@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>

On 08-02-16, 14:10, Arnd Bergmann wrote:
> I don't remember the exact discussion, but the compatible string is
> exactly meant to do one thing: it tells you what you can or cannot do
> with one device.

Yeah, and many people argued that we can't add two values to that
string like: "cpufreq-dt" and "cpufreq-big-little" for same kind of
OPP bindings, as a different compatible string should be required only
if there is a difference in the bindings.

For example, if a platform (like ST did recently) adds more
platform-specific properties, then they can define a new value of
those strings.

> I had not realized that we don't even have a compatible string
> for opp-v2, so if we are missing that, we obviously can't compare
> against that string.

The binding says that we can have a string, but its not compulsory
yet. Its only used by STM as they have some specific properties of
their own.

> I thought there was a compatible property in there that told us
> whether the operating-points-v2/cooling-min-level/#cooling-cells/...
> properties were considered valid.

Yeah, "OPP-v2" DT node can have a compatible string, which isn't
compulsory as of now, but because of the reasons mentioned earlier, we
can't use it to differentiate between drivers that use exactly same
version of bindings.

-- 
viresh
