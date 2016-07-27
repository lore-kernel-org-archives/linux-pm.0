From: Borislav Petkov <bp@suse.de>
Subject: Re: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute
 NX-protected page" when resuming from hibernate to disk
Date: Wed, 27 Jul 2016 07:39:28 +0200
Message-ID: <20160727053928.GA3142@nazgul.tnic>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
 <2437449.FpDj7DlX4Y@vostro.rjw.lan>
 <CAGXu5jLEbETSntwVQnNt4MZsHiU3E0OCN51VgBScvVAjCP7auA@mail.gmail.com>
 <2264716.77pSArDZvG@vostro.rjw.lan>
 <CAGXu5jLPN4N1f19OXJboepVuJhnXeeWQghanqDwh4bU=SQXZJw@mail.gmail.com>
 <CAJcbSZE0YGP1mpyvRU-3c6jUQsuAhpB5wcyg10hKrNneUtgiPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758554AbcG0Fjk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Jul 2016 01:39:40 -0400
Content-Disposition: inline
In-Reply-To: <CAJcbSZE0YGP1mpyvRU-3c6jUQsuAhpB5wcyg10hKrNneUtgiPg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Garnier <thgarnie@google.com>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

On Tue, Jul 26, 2016 at 02:17:29PM -0700, Thomas Garnier wrote:
> I am sorry, there has been parallel work between KASLR memory
> randomization and hibernation support. That's why hibernation was not
> tested, it was not supported when the feature was created.
> Communication will be better next time.
>=20
> I will work on identifying the problem and pushing a fix.

Would you please do me a favor and stop top-posting. It really disrupts
reading the thread.

Thanks.

--=20
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
