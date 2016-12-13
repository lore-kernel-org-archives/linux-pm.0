From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Tue, 13 Dec 2016 11:00:22 +0100
Message-ID: <87shpsi1xl.fsf@miraculix.mork.no>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
        <20161212085620.GA738@amd>
        <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
        <1481567955.1764.28.camel@perches.com> <20161212222216.GA18201@amd>
        <1481581932.29291.6.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:37715 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932469AbcLMKDC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Dec 2016 05:03:02 -0500
In-Reply-To: <1481581932.29291.6.camel@perches.com> (Joe Perches's message of
        "Mon, 12 Dec 2016 14:32:12 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Pavel Machek <pavel@ucw.cz>, Nick Desaulniers <nick.desaulniers@gmail.com>, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:
> On Mon, 2016-12-12 at 23:22 +0100, Pavel Machek wrote:
>> On Mon 2016-12-12 10:39:15, Joe Perches wrote:
>> > On Mon, 2016-12-12 at 09:56 -0800, Nick Desaulniers wrote:
>> > > A quick cleanup that passes scripts/checkpatch.pl -f <file>.
> []
>> > > diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cs=
tate.c
> []
>> > It's generally better not to convert
>> > these printk(KERN_DEBUG uses.
>> >=20
>> > There are behavior differences between
>> > 	printk(KERN_DEBUG ...);
>> > and
>> > 	pr_debug(...);
>> >=20
>> > The first will always be emitted as long
>> > as the console level is appropriate.
>> >=20
>> > The second depends on a #define DEBUG
>> > before it gets emitted or a kernel=20
>> > with CONFIG_DYNAMIC_DEBUG enabled and
>> > this entry specifically enabled in the
>> > control file.
>>=20
>> Hmm. Perhaps pr_debug should be called pr_c_debug() or something? This
>> is rather nice trap.
>
> Yeah, I've suggested veriants like pr_always_debug (from 2009)
> http://lkml.iu.edu/hypermail/linux/kernel/0910.0/00399.html

The ability to strip the kernel from all debugging messages, or to keep
them and dynamically enabling the interesting ones, are both important
features *on top of* printk(KERN_DEBUG ...); If you add pr_c_debug() or
whatever, then you'll only create a use case for another level of "strip
this out".  Back to square one.

If this is a case of "my debug message is too important to let the user
strip it from the kernel", then just use pr_info().  If not, then live
with the additional debug level features leaving the control in the
hands of the user.

Personally, I want to be able to do dynamic debugging without having to
manually filter out any unconditional debug messages.  Please don't mess
that up.  There are more than enough levels for unconditional messages.
we can afford to reserve KERN_DEBUG for the dynamic debug conditional
ones.

Thanks.


Bj=C3=B8rn
