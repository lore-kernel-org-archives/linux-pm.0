From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Thermal] Need confirmation for the pending thermal soc patches
Date: Tue, 6 Sep 2016 12:13:11 +0200
Message-ID: <CAMuHMdVxCyy+ULdnzWTBFuCrP4E77H7JxS25QL_RSeOgtV5bVQ@mail.gmail.com>
References: <1471788540.2188.19.camel@intel.com> <20160905131600.GA24253@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35263 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbcIFKNN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2016 06:13:13 -0400
In-Reply-To: <20160905131600.GA24253@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>

Hi Eduardo,

On Mon, Sep 5, 2016 at 3:16 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Sun, Aug 21, 2016 at 10:09:00PM +0800, Zhang Rui wrote:
>> As Eduardo is quite busy recently, I will take all the thermal soc
>> driver changes this time.
>
> Thanks for helping me out. I am slowing coming back to upstream
> activities. I have refreshed my branches, removing the rework and
> locking patches works out of the integration branches so we do not have
> merge conflicts or further delays on outstanding patches.
>
>> Currently, I have cherry picked all the patches that Eduardo has
>> already applied in thermal-soc tree and reviewed all the pending
>
> Great! This makes things easier for me.
>
>> patches in patchwork. Now, there are four patches queued for next -rc (
>> https://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/log/?h=fo
>> r-rc),
>
> I checked this branch. Can you please cherry-pick the following patch
> for rc:
> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=4ba16f1256bd13efa2f3179ff1f4ab16a4ad3c7f

That patch is indeed missing.

While preparing today's renesas-drivers release, I noticed it had disappeared
from thermal-soc/next. Then I found your email...

Thanks for re-applying it!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
