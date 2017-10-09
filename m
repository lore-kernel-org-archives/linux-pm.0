From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/2] detect identical chip data arrays
Date: Mon, 9 Oct 2017 18:11:49 +0900
Message-ID: <CAK7LNAT3aS2Ad3RxM9m=t4wAW2Zq=aAc_poww_qutFc09F5T7A@mail.gmail.com>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <20171008203258.y7kqx7ipondxlsix@earth> <alpine.DEB.2.20.1710082243140.2160@hadrien>
 <CAK7LNATGdz52SbYWD2bv7uYBQGVAHAK7xb9oJOgUVsTQJEPN5Q@mail.gmail.com> <alpine.DEB.2.20.1710091038340.3252@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1710091038340.3252@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Breck <liam@networkimprov.net>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

2017-10-09 17:40 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Mon, 9 Oct 2017, Masahiro Yamada wrote:
>
>> 2017-10-09 5:44 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>> >
>> >
>> > On Sun, 8 Oct 2017, Sebastian Reichel wrote:
>> >
>> >> Hi,
>> >>
>> >> On Sun, Oct 08, 2017 at 09:18:39PM +0200, Julia Lawall wrote:
>> >> > Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warning
>> >> > messages to indicate that some structures are the same, in response to
>> >> > feedback from Liam Breck.
>> >> >
>> >> > Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, which
>> >> > is not yet released, it actually works with the version currently available
>> >> > on Github, eg from Coccinelle commit 3ba77b3a0f91.
>> >>
>> >> I think the rename makes sense, but I would expect the move to
>> >> happen in one go with "git send-email -M", so that it detects the
>> >> rename.
>> >
>> > I'm not actually sure what is the status of the previous version.
>> > Masahiro said applied, but I downloaded his tree and it was not there.  So
>> > I thought this way would be easier.
>>
>> My tree is here:
>> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>>
>> I had applied your patch a few days before.
>
> OK, I got that tree, but it seemed to go only up to October 1.  But maybe
> I did not pick the right branch.


Oct 1 is the date you submitted it.
According to "git log --pretty=fuller", I applied it Oct 5.
I do not not remember when I pushed it, though.

commit ffb11fd663a2b9cefbe24e8e3dd2ebcacd338d69
Author:     Julia Lawall <Julia.Lawall@lip6.fr>
AuthorDate: Sun Oct 1 14:42:48 2017 +0200
Commit:     Masahiro Yamada <yamada.masahiro@socionext.com>
CommitDate: Thu Oct 5 08:37:12 2017 +0900

    coccinelle: api: detect duplicate chip data arrays



>>
>>
>> BTW, how should I handle this series?
>>
>> 1/2 is reverting it.
>>
>> So, I can drop the previous one entirely,
>> then pick up 2/2 only.
>>
>> Is this a good thing to do?
>
> That would be perfectly fine with me.  You can drop 1/2 already.  For 2/2,
> it would be nice to have an Ack from Liam first.
>
> thanks,
> julia


OK.  I will drop the previous one.

I will hold back 2/2 until it gets Ack from Liam.





-- 
Best Regards
Masahiro Yamada
