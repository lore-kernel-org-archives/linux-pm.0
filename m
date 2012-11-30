From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] cpufreq: db8500: Rename driver and update some parts
Date: Fri, 30 Nov 2012 13:04:29 +0100
Message-ID: <CAPDyKFr9hLkzg6VMsZSr_0bafJydL__Q-=3cf6Mx5d8ry3Zbiw@mail.gmail.com>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59601 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030377Ab2K3MEb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Nov 2012 07:04:31 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so118798wey.19
        for <linux-pm@vger.kernel.org>; Fri, 30 Nov 2012 04:04:30 -0800 (PST)
In-Reply-To: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Mike Turquette <mturquette@linaro.org>, Mike Turquette <mturquette@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On 28 November 2012 11:27, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patchset starts by renaming the db8500 cpufreq driver to a more generic
> name. There are new variants which rely on it too, so instead we give it a
> family name of dbx500.
>
> On top of that a fixup patch for initialization of the driver and some minor
> cleanup patches are included as well.
>
> These patches can be material for 3.8, thus I think it should be fine if the
> patches are merged through different trees. Unless some of the maintainers
> are of other opinions.
>
> Jonas Aaberg (1):
>   cpufreq: dbx500: Minor code cleanup
>
> Lee Jones (3):
>   cpufreq: Give driver used for dbx500 family a more generic name
>   mfd: db8500: Update cpufreq device name
>   cpufreq: dbx500: Update file header
>
> Ulf Hansson (1):
>   cpufreq: dbx500: Move clk_get to probe
>
>  drivers/cpufreq/Makefile         |    2 +-
>  drivers/cpufreq/db8500-cpufreq.c |  179 -------------------------------------
>  drivers/cpufreq/dbx500-cpufreq.c |  180 ++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/db8500-prcmu.c       |    4 +-
>  4 files changed, 183 insertions(+), 182 deletions(-)
>  delete mode 100644 drivers/cpufreq/db8500-cpufreq.c
>  create mode 100644 drivers/cpufreq/dbx500-cpufreq.c
>
> --
> 1.7.10
>

Thanks to Samuel I realized that of course these patches would need to
go through Mike Turquette's clock tree. They are applying there.
This since we have merged clock patches which had dependencies to both
mfd and cpufreq.

Thus I will instead try to collect acks as a way forward.

Mike, please tell me if you are not happy with this setup or if you
would like me to resend.

Kind regards
Ulf Hansson
