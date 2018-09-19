From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 04/12][RFC v3] x86, hibernate: Extract the common code of
 64/32 bit system
Date: Wed, 19 Sep 2018 12:34:05 +0200
Message-ID: <20180919103405.GA19621@gmail.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, kookoo.gu@intel.com
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> > index 000000000000..fbde8f0e8fe0
> > --- /dev/null
> > +++ b/arch/x86/power/hibernate.c
> > @@ -0,0 +1,249 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Hibernation support for x86
> > + *
> > + * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> > + * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
> > + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
> 
> I don't think this "copyright" information has any legal bearing any
> more at this point.

I think that's wrong in general, and it's routine for corporate legal
departments to insist on specific boilerplate copyright notices when
OSS code is contributed.

Copying code and then removing copyright notices is frowned upon
independently as well.

While you can probably talk for your own copyright notice, I'm not sure
it's true of the two other historic copyright notices that were copied.

So I think it's best practice to preserve all copyright notices as-is.

Thanks,

	Ingo
