From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Date: Thu, 21 Jun 2018 14:10:06 +0200
Message-ID: <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com> <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621090142.GB21807@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>, Ted Ts'o <tytso@mit.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Stephan Mueller <smueller@chronox.de>, Eric Biggers <ebiggers3@gmail.com>, Denis Kenzior <denkenz@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 21, 2018 at 11:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> On Wed 2018-06-20 17:40:51, Chen Yu wrote:
>> crypto_hibernate is a user-space utility to generate
>> 512bits AES key and pass it to the kernel via ioctl
>> for hibernation encryption.(We can also add the key
>> into kernel via keyctl if necessary, but currently
>> using ioctl seems to be more straightforward as we
>> need both the key and salt transit).
>
> Ah, here you go:
>
> https://en.wikipedia.org/wiki/Uswsusp

No, not really.

> It can already do encryption. If you see problems there, patches will
> be gladly accepted to fix them.

By whom?

> If you want to maintain uswsusp in kernel tree, I guess that would be
> an option, too.

No, it isn't an option due to the dependencies on crypto libraries.

> If you want to just help swsusp, I have some patches that reduce
> duplicities between x86-32 and x86-64. It would be cool to clean them
> up and get them merged.

Sure, please submit them then.

Thanks,
Rafael
