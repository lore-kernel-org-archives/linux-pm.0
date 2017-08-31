From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kbuild: use $(abspath ...) instead of $(shell cd ... && /bin/pwd)
Date: Fri, 1 Sep 2017 08:52:21 +0900
Message-ID: <CAK7LNARntwzEggrv4nNgppnDgzpoZHwLgjVt_G7+G+W-K5h5hw@mail.gmail.com>
References: <1503209051-16477-1-git-send-email-yamada.masahiro@socionext.com>
 <20170821084930.GA7678@ulmo> <CAK7LNAS73Or9G82-8zT=7XjKfP_zEK2+TgutaOHw7SPeeO9_CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:35962 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdHaXxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 19:53:14 -0400
In-Reply-To: <CAK7LNAS73Or9G82-8zT=7XjKfP_zEK2+TgutaOHw7SPeeO9_CA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.com>, linux-pm@vger.kernel.org, Kieran Bingham <kieran@ksquared.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

2017-08-21 18:04 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-08-21 17:49 GMT+09:00 Thierry Reding <treding@nvidia.com>:
>> On Sun, Aug 20, 2017 at 03:04:11PM +0900, Masahiro Yamada wrote:
>>> Kbuild conventionally uses $(shell cd ... && /bin/pwd) idiom to get
>>> the absolute path of the directory because GNU Make 3.80, the minimal
>>> supported version at that time, did not support $(abspath ...) or
>>> $(realpath ...).
>>>
>>> Commit 37d69ee30808 ("docs: bump minimal GNU Make version to 3.81")
>>> dropped the GNU Make 3.80 support, so we are now allowed to use those
>>> make-builtin helpers.
>>>
>>> This conversion will provide better portability without relying on
>>> the pwd command or its location /bin/pwd.
>>>
>>> I am intentionally using $(realpath ...) instead $(abspath ...) in
>>> some places.  The difference between the two is $(realpath ...)
>>> returns an empty string if the given path does not exist.  It is
>>> convenient in places where we need to error-out if the makefile fails
>>> to create an output directory.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>

Applied to linux-kbuild.
