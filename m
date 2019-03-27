From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 12:49:17 +0100
Message-ID: <20190327114917.GD32571@zn.tnic>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
 <20190327101133.GQ22899@mtr-leonro.mtl.com>
 <20190327101815.GB32571@zn.tnic>
 <20190327105024.GR22899@mtr-leonro.mtl.com>
 <20190327111452.GC32571@zn.tnic>
 <20190327113628.GS22899@mtr-leonro.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327113628.GS22899@mtr-leonro.mtl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Romanovsky <leon@kernel.org>
Cc: Joe Perches <joe@perches.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 27, 2019 at 01:36:28PM +0200, Leon Romanovsky wrote:
> At the end, it is reduced to our usage, we are running QEMU inside
> docker to test kernel changes with limitation on number of CPUs to use.
> The systems are optimized to boot kernel as soon as possible in order
> to run tests and on my machine (64 CPUs) reduce is visible: from ~2.6
> sec to ~2.3 sec from execution to kernel boot.

You're kidding, right?

0.3 sec boot time "improvement" for a kernel on which you run tests
which take orders of magnitude longer (I assume). And you want to hide
this message in the upstream kernel because you want to minimally speed
up *your* *specific* usage ?

And we still are wasting time talking about this?!

Oh boy.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
