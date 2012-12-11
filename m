From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND PATCH 0/5] cpufreq: db8500: Rename driver and update some parts
Date: Tue, 11 Dec 2012 10:15:51 +0100
Message-ID: <CACRpkdYE+WcOqbB0whqW+bKVOXmdAmF0rCFacsYkREu=gPGXew@mail.gmail.com>
References: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52744 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab2LKJPw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Dec 2012 04:15:52 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1414130eaa.19
        for <linux-pm@vger.kernel.org>; Tue, 11 Dec 2012 01:15:51 -0800 (PST)
In-Reply-To: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon, Dec 10, 2012 at 4:25 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patchset starts by renaming the db8500 cpufreq driver to a more generic
> name. There are new variants which rely on it too, so instead we give it a
> family name of dbx500.
>
> On top of that a fixup patch for initialization of the driver and some minor
> cleanup patches are included as well.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
For all patches.

Yours,
Linus Walleij
