From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 11:42:18 -0800
Message-ID: <AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+__21448.2445772321$1295725522$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
	<AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
	<201101222017.40389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101222017.40389.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Jesse Barnes <jbarnes@virtuousgeek.org>, Chris Wilson <chris@chris-wilson.co.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 22, 2011 at 11:17 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>
>> First off, I think I've already noted that I don't think I get lockups
>> with the usual "echo mem > /sys/power/state". So I've mentioned that
>> maybe it's something about the lid event messing things up.

I take this partly back after some more testing

I do get the "have to press a key during suspend problem" with "echo
mem". But at least when I just tested, the suspend after that worked
fine - and I could do another "echo mem" suspend (which _also_ needed
a keypress).

When I then did a "pm-suspend" after that, it just locked up.

So doing "echo mem" once after boot is not a sure-fire way to make
suspend work reliably. But it does seem to work better than
"pm-suspend" does.

>> I also _think_ (and this is where it gets a bit speculative, because
>> my trials so far have been pretty limited) that I can work around the
>> problem by doing that "echo mem" suspend once, and after that the
>> "pm-suspend" approach works.

Ok, so see above. It's not a work-around, but it does have slightly
different behavior.

>> I wonder what else differs between pm-suspend and just the final "echo
>> mem"? But I do wonder if some of the i915 code is getting confused by
>> being touched both as fbcon and then with the "real" suspend code..
>
> Hmm. =A0If there is s2ram on your system and it's actually being used, it=
's
> better to disable it completely. =A0I'm not sure how you are supposed to =
do
> that on Fedora, but for openSUSE it's sufficient to clear the "executable=
" bit
> on /usr/sbin/s2ram.

There's no s2ram in my F-14 at all. And almost all of the fbcon
suspend games in the pm-suspend scripts are disabled when it notices a
kernel-modesetting setup. But the pm-suspend scripts do still end up
doing a lot of other things (like trying to switch vt's etc - but
disabling that didn't do anything for me).

One more comment: when I disable the VT switching, I end up seeing the
kernel messages during suspend, but they obviously stop at
"suspend_console()". When I use "no_console_suspend" to show mssages,
the last message I see before the machine needs a keypess is the one
where we disable the i915 IRQ.

Which probably doesn't mean anything, since it's probably just a
direct result of me saying "try to print stuff even over the suspend"
together with the i915 driver then not being able to due to not having
interrupts. So I suspect the "no_console_suspend" thing just doesn't
much help - it just results in more problems for the  suspend, and it
probably never works at all.

Annoying. So close. Yet so far.

                Linus
