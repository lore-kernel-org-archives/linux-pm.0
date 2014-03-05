From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: spear-cpufreq + multiplatform?
Date: Wed, 5 Mar 2014 09:58:27 +0800
Message-ID: <CAOh2x=k6uo23O23RFE5Ld__q=FtQUnbNyJA1O72yf3r_dd8f-A@mail.gmail.com>
References: <20140303180809.GA28282@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:43765 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbaCEB62 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Mar 2014 20:58:28 -0500
Received: by mail-vc0-f170.google.com with SMTP id hu8so373861vcb.15
        for <linux-pm@vger.kernel.org>; Tue, 04 Mar 2014 17:58:27 -0800 (PST)
In-Reply-To: <20140303180809.GA28282@joshc.qualcomm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: Shiraz Hashim <shiraz.hashim@st.com>, Deepak Sikri <deepak.sikri@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, spear-devel <spear-devel@list.st.com>, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Tue, Mar 4, 2014 at 2:08 AM, Josh Cartwright <joshc@codeaurora.org> wrote:
> Hey folks-
>
> I noticed booting today's next on a non-spear platform, that I'm seeing
> the following in my logs:
>
>         [    2.126494] spear_cpufreq: Invalid cpufreq_tbl
>
> Looking closer, it looks like the spear-cpufreq driver has a
> late_initcall() that's not too multiplatform friendly.  Perhaps the
> spear cpufreq initialization routine should be called explicitly from
> some platform-specific code, or explicitly check to ensure it's running
> on SPEAr?

So sorry for that. I can't get it fixed right now as am busy with some
conferences but will mark that in my todo list. Thanks for reporting it.
