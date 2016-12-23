From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Fri, 23 Dec 2016 13:10:56 +0100
Message-ID: <CAJZ5v0hPYkF0CkhN7aWmvmhVcnq5SbwjQFgbJwK_9gbW-Ci2hw@mail.gmail.com>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
 <20161212085620.GA738@amd> <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
 <1481567955.1764.28.camel@perches.com> <20161212222216.GA18201@amd>
 <20161212232043.vc5alwqzvspg2ade@lostoracle.net> <1481584942.29291.9.camel@perches.com>
 <20161213190001.GA8676@amd> <20161223031942.jrgjt567m6bdeke3@lostoracle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161223031942.jrgjt567m6bdeke3@lostoracle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 23, 2016 at 4:19 AM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> On Tue, Dec 13, 2016 at 08:00:01PM +0100, Pavel Machek wrote:
>> Actually.. the ACPI cleanup is fine. You did well :-).
>>                                                                       Pavel
>
> Cool, so (forgive the naive question) what happens next?  Maybe I'm too
> used to the immediate gratification from Github of having a Pull Request
> get merged.  Is this something that you have cherry picked into your
> tree, then will ask Linus to pull from at the end of the merge window?
>
> Do you have a tree that public that I am able to view? On
> git.kernel.org, there seems to be one tree with your name on it but it
> seems to be related to the (Nokia?) n900 and it's latest updated branch
> is from 9 weeks ago.
>
> Or is there more approvals I have to get to get the patch merged?

Somebody has to decide that your patch is worth merging and take it.

For ACPI-related patches that usually is me, but I haven't looked at
it yet.  I'll do that next week and let you know if all goes well.

Thanks,
Rafael
