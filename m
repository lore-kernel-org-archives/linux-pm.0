From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] ACPI and power management fixes for v3.11-rc4
Date: Fri, 2 Aug 2013 16:31:37 -0500
Message-ID: <CAMP44s2DNkkBP4G2oD+yRwxPYUDx6HAQyAEetLkBTe3mEpLR=A@mail.gmail.com>
References: <2052880.bHfzt6NKt5@vostro.rjw.lan>
	<CAMP44s2a2HqohWL9d+i3cpifJiUfidTw_ZfO3PttvhMn_hGE1A@mail.gmail.com>
	<1820071.Lqgn6ZcLbB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1820071.Lqgn6ZcLbB@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 2, 2013 at 4:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, August 02, 2013 02:12:49 PM Felipe Contreras wrote:

>> You forgot this patch:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=3706231332d57072e0e2c0e59975443f3f18e673
>>
>> Or do you think it's fine to boot these machines into a black screen?
>
> Seriously, what's wrong with you?!
>
> I didn't forget about it, I just didn't include it into this particular
> pull request.
>
> And I'm not even sure I will push it for 3.11, because I prefer to revert
> efaa14c for 3.11 if that's necessary to make your broken box work as before.

The issue happens in more than just "my broken box", and yes,
reverting that patch would help (in more than just my box), in the
sense that at least Linux won't boot into a black screen.

But the backlight control still wouldn't work, as it hasn't worked
since v3.7, possibly in many ASUS laptops, for that you need more than
just reverting efaa14c.

> Well, perhaps I just won't push it at all so that you actually can go and
> complain to Linus about that ...

That is very responsible from you. Screw the users, right?

-- 
Felipe Contreras
