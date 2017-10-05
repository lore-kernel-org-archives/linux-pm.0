From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kbuild: revert $(realpath ...) to $(shell cd ... && /bin/pwd)
Date: Fri, 6 Oct 2017 05:17:01 +0900
Message-ID: <CAK7LNARStcxr=Htuje15+Hh0mZ_km42j8V1LQ=nYyqGKvuKWXA@mail.gmail.com>
References: <1506931648-15511-1-git-send-email-yamada.masahiro@socionext.com> <ea8b93e6-2ce3-2c32-fbe3-f6570c523f1b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:44672 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdJEUR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2017 16:17:58 -0400
In-Reply-To: <ea8b93e6-2ce3-2c32-fbe3-f6570c523f1b@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Michal Marek <mmarek@suse.com>, David Carrillo-Cisneros <davidcc@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

2017-10-02 20:27 GMT+09:00 Julien Grall <julien.grall@arm.com>:
> Hello,
>
> On 02/10/17 09:07, Masahiro Yamada wrote:
>>
>> I thought commit 8e9b46679923 ("kbuild: use $(abspath ...) instead of
>> $(shell cd ... && /bin/pwd)") was a safe conversion, but it changed
>> the behavior.
>>
>> $(abspath ...) / $(realpath ...) does not expand shell special
>> characters, such as '~'.
>>
>> Here is a simple Makefile example:
>>
>>    ---------------->8----------------
>>    $(info /bin/pwd: $(shell cd ~/; /bin/pwd))
>>    $(info abspath: $(abspath ~/))
>>    $(info realpath: $(realpath ~/))
>>    all:
>>            @:
>>    ---------------->8----------------
>>
>>    $ make
>>    /bin/pwd: /home/masahiro
>>    abspath: /home/masahiro/workspace/~
>>    realpath:
>>
>> This can be a real problem if 'make O=~/foo' is invoked from another
>> Makefile or primitive shell like dash.
>>
>> This commit partially reverts 8e9b46679923.
>>
>> Fixes: 8e9b46679923 ("kbuild: use $(abspath ...) instead of $(shell cd ...
>> && /bin/pwd)")
>> Reported-by: Julien Grall <julien.grall@arm.com>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> Tested-by: Julien Grall <julien.grall@arm.com>


Applied to linux-kbuild/fixes.


-- 
Best Regards
Masahiro Yamada
