From: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/3] arm64: Enable OPP
Date: Fri, 9 May 2014 12:17:23 -0500
Message-ID: <CAGo_u6oL06G7jk8_X-SH73oWCAHX5vTj7ViC1AyaDhDLJEvWmw@mail.gmail.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
	<CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
	<20140509171120.GS12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59259 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbaEIRRY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 13:17:24 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so1673415wiv.7
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2014 10:17:23 -0700 (PDT)
In-Reply-To: <20140509171120.GS12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>

On Fri, May 9, 2014 at 12:11 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 09, 2014 at 12:02:12PM -0500, menon.nishanth@gmail.com wrote:
>> On Fri, May 9, 2014 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Some of the generic drivers used on ARM class systems use OPP so allow it
>> > to be selected in Kconfig. No code is required for this, it is not clear
>> > to me why there is config for this option.
>
>> If you mean why we have ARCH_HAS_OPP,
>> http://lists-archives.com/linux-kernel/27401148-pm-hide-opp-configuration-when-socs-do-not-provide-an-implementation.html
>
> That's for the user visible symbol but OPP is also enableable via select
> - the fix here may be to remove both the visibility check and the
> dependency.
That is reasonable.
Regards,
Nishanth Menon
