From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/2] detect identical chip data arrays
Date: Mon, 9 Oct 2017 17:31:48 +0900
Message-ID: <CAK7LNATGdz52SbYWD2bv7uYBQGVAHAK7xb9oJOgUVsTQJEPN5Q@mail.gmail.com>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <20171008203258.y7kqx7ipondxlsix@earth> <alpine.DEB.2.20.1710082243140.2160@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:24489 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbdJIIcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 04:32:41 -0400
In-Reply-To: <alpine.DEB.2.20.1710082243140.2160@hadrien>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Breck <liam@networkimprov.net>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>

2017-10-09 5:44 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Sun, 8 Oct 2017, Sebastian Reichel wrote:
>
>> Hi,
>>
>> On Sun, Oct 08, 2017 at 09:18:39PM +0200, Julia Lawall wrote:
>> > Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warning
>> > messages to indicate that some structures are the same, in response to
>> > feedback from Liam Breck.
>> >
>> > Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, which
>> > is not yet released, it actually works with the version currently available
>> > on Github, eg from Coccinelle commit 3ba77b3a0f91.
>>
>> I think the rename makes sense, but I would expect the move to
>> happen in one go with "git send-email -M", so that it detects the
>> rename.
>
> I'm not actually sure what is the status of the previous version.
> Masahiro said applied, but I downloaded his tree and it was not there.  So
> I thought this way would be easier.

My tree is here:
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git

I had applied your patch a few days before.


BTW, how should I handle this series?

1/2 is reverting it.

So, I can drop the previous one entirely,
then pick up 2/2 only.

Is this a good thing to do?

-- 
Best Regards
Masahiro Yamada
