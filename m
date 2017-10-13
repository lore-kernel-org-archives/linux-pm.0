From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH 0/3] tools/thermal: tmon: Makefile improvements
Date: Fri, 13 Oct 2017 13:39:47 -0700
Message-ID: <CAGt4E5tmKCLD_bcHe6_vTxqG=UApdfZZNTQOFh_d2VY2gKW7TQ@mail.gmail.com>
References: <20170927230237.62199-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52650 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdJMUjt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 16:39:49 -0400
Received: by mail-wm0-f46.google.com with SMTP id k4so23915231wmc.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2017 13:39:48 -0700 (PDT)
In-Reply-To: <20170927230237.62199-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 27 September 2017 at 16:02, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
>
> This series introduces a number of improvements to tmon's Makefile. The
> changes are meant to make it easier to cross-compile tmon on a greater
> number of platforms by giving more control to the person performing the
> build.
>
> At the same time, sensible defaults are retained so that building tmon
> will continue to work without any customizations on platforms on which
> it currently builds.

Rui, is there any chance you would be able to take this?

Thanks,
-Markus

> Markus Mayer (3):
>   tools/thermal: tmon: use "-fstack-protector" only if supported
>   tools/thermal: tmon: allow $(CC) to be defined externally
>   tools/thermal: tmon: use $(PKG_CONFIG) instead of hard-coding
>     pkg-config
>
>  tools/thermal/tmon/Makefile | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> --
> 2.7.4
>
