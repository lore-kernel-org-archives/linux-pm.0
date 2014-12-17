From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Thermal Management updates for 3.19-rc1
Date: Wed, 17 Dec 2014 10:29:13 -0800
Message-ID: <CA+55aFyLpbx8MhNYvQvp74VjmvPEeJTFAw25cnPYFG1B-CLexQ@mail.gmail.com>
References: <1418807145.5983.27.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:62085 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaLQS3O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 13:29:14 -0500
Received: by mail-qa0-f45.google.com with SMTP id i13so3849414qae.32
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 10:29:13 -0800 (PST)
In-Reply-To: <1418807145.5983.27.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Pulled, but:

On Wed, Dec 17, 2014 at 1:05 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt   |   8 --
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt |  68
> ++++++++++++++

Please fix your pull request generation.

It *looks* like you are doing the diffstat in a very wide window, and
then doing a cut-and-paste into email.

Resulting in all these huge long lines that wrap in a very ugly way. Like this:

>  drivers/thermal/rockchip_thermal.c                             | 693
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

that's not exactly legible, is it?

In order to use your screen estate to full advantage, "git diff
--stat" will default to the terminal width, but it does default to the
normal 80 columns if you just output to a file.

Or if you really want to cut-and-paste and do this from a terminal,
just use "--stat=72" instead of just plain "--stat". Or use "export
COLUMNS=80" or something.

                           Linus
