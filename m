From: Borislav Petkov <bp@suse.de>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 16:04:42 +0200
Message-ID: <20160726140442.GA2832@nazgul.tnic>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16541580.dFLT14ScxF@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org, Thomas Garnier <thgarnie@google.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 26, 2016 at 01:32:28PM +0200, Rafael J. Wysocki wrote:
> Hi,
>=20
> The following commit:
>=20
> commit 13523309495cdbd57a0d344c0d5d574987af007f
> Author: Josh Poimboeuf <jpoimboe@redhat.com>
> Date:   Thu Jan 21 16:49:21 2016 -0600
>=20
>     x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
>    =20
>     do_suspend_lowlevel() is a callable non-leaf function which doesn=
't
>     honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
>    =20
>     Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.
>=20
> is reported to cause a resume-from-hibernation regression due to an a=
ttempt
> to execute an NX page (we've seen quite a bit of that recently).
>=20
> I'm asking the reporter to try 4.7, but if the problem is still there=
, we'll
> need to revert the above I'm afraid.

So I can't resume properly from disk too, on the Intel laptop this time=
=2E Top
commit is from tip/master:

commit 516f48acf59722429acd323b3d283f74f02891fe (refs/remotes/tip/maste=
r)
Merge: a4823bbffc96 dd9506954539
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Jul 25 08:39:43 2016 +0200

    Merge branch 'linus'


So I thought it might be Josh's patch above and reverted it. No joy.

Then I remembered that I enabled CONFIG_RANDOMIZE_MEMORY for the
microcode loader breakage which we've been debugging. Turned that off
and machine resumes fine again.

It looks like

  0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")

broke a bunch of things. Off the top of my head, we probably should mak=
e
suspend to disk and CONFIG_RANDOMIZE_MEMORY mutually exclusive, like it
was the case with ASLR previously, AFAIR.

Adding more people to CC and leaving in the rest for reference.

> Date: Mon, 25 Jul 2016 21:16:29 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: rjw@rjwysocki.net
> Subject: [Bug 150021] New: kernel panic: "kernel tried to execute
>  NX-protected page" when resuming from hibernate to disk
> Message-ID: <bug-150021-76231@https.bugzilla.kernel.org/>
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D150021
>=20
>             Bug ID: 150021
>            Summary: kernel panic: "kernel tried to execute NX-protect=
ed
>                     page" when resuming from hibernate to disk
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 4.6.x
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>           Assignee: rjw@rjwysocki.net
>           Reporter: shuzzle@mailbox.org
>         Regression: No
>=20
> Created attachment 226381
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D226381&action=3D=
edit
> last working .config
>=20
> Overview:=20
>=20
> When commit 13523309495cdbd57a0d344c0d5d574987af007f is applied to my=
 kernel
> sources my kernel panics when trying to resume from hibernate to disk=
=2E
>=20
>=20
> Steps to Reproduce:=20
>=20
> 1. have a working hibernate/resume setup
> 2. compile 4.6.x kernel
> 3. boot and hibernate to disk
> 4. test various kernels using "git bisect".
>=20
>=20
> Actual Results: kernel panics when trying to resume from hibernate to=
 disk.
>=20
> Expected Results: Resume from hibernate to disk like kernels without =
commit
> 13523309495cdbd57a0d344c0d5d574987af007f did.
>=20
>=20
> I attached my working .config of my 4.5.7 kernel.
>=20
> Any help will be appreciated. Thanks!
>=20
> --=20
> You are receiving this mail because:
> You are the assignee for the bug.


--=20
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
