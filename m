From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RESEND PATCH 0/5] cpufreq: db8500: Rename driver and update some parts
Date: Wed, 12 Dec 2012 12:56:48 -0800
Message-ID: <CAPtuhTgcmdxtG9B6L5NMyLCrhQh2o0DFkq47e_YCMoBzVhaF=g@mail.gmail.com>
References: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61091 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab2LLU5J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Dec 2012 15:57:09 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so1312142vcd.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Dec 2012 12:57:08 -0800 (PST)
In-Reply-To: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon, Dec 10, 2012 at 7:25 AM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patchset starts by renaming the db8500 cpufreq driver to a more generic
> name. There are new variants which rely on it too, so instead we give it a
> family name of dbx500.
>
> On top of that a fixup patch for initialization of the driver and some minor
> cleanup patches are included as well.
>
> These patches can be material for 3.8.
>
> Since some patches for the db8500 cpufreq driver has recently been merged
> through Mike Turquette's clk tree, I decided to base these patches on top
> of the clk-next branch. So I hope Mike is fine by merging these patches
> through his tree.
>
> So I will try to collect ACKs from Rafael for the cpufreq patches. The
> mfd patch has already been ACKED by Samuel.
>

Ulf,

Just FYI clk-next has been pulled by Linus for 3.8.  I can still take
this branch once Rafael ACKs the CPUfreq bits if you want, but I think
you have more options now that clk-next is merged in.  It's up to you.

Regards,
Mike
