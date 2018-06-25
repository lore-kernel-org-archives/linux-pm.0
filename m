From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Mon, 25 Jun 2018 09:16:16 +0200
Message-ID: <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com> <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com> <20180621191443.GB14623@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621191443.GB14623@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 21, 2018 at 9:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
>> On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> As security becomes more and more important, we add the in-kernel
>> >> encryption support for hibernation.
>> > ...
>> >> There was a discussion on the mailing list on whether this key should
>> >> be derived in kernel or in user space. And it turns out to be generating
>> >> the key by user space is more acceptable[1]. So this patch set is divided
>> >> into two parts:
>> >> 1. The hibernation snapshot encryption in kernel space,
>> >> 2. the key derivation implementation in user space.
>> >
>> > uswsusp was created so that this kind of stuff could be kept in
>> > userspace. You get graphical progress bar (etc) too. As you already
>> > have userspace component for key derivation, I see no advantages to
>> > uswsusp.
>> >
>> > If you have some, please explain.
>>
>> Not having to transfer plain text kernel memory to user space is one
>> IMO.
>
> Well, AFAICT in this case userland has the key and encrypted data are
> on disk. That does not seem to be improvement.

Not really.

With the encryption in the kernel, if the kernel is careful enough,
use space will not be able to read the image even if it knows the
passphrase, unless it can also add itself to the initramfs image
loaded by the restore kernel, which (at least) can be made way more
difficult than simply reading the plain-text image data via an I/F
readily provided by the kernel.

>> Besides, the user space part of what you are calling uswsusp has not
>> been actively maintained for years now and honestly I don't know how
>> many users of it there are.
>
> I'd assume distros want progress bars so they still use it?

I'd rather not speak for distros, but if hibernation images are
written to fast storage, progress bars are not that useful any more.
They are not used on Windows any more, for one.

> Anyway, there's solution for encrypted hibernation.

Which is suboptimal and you know it.

> If Intel wants to invent different solution for that, and put it into kernel, they
> should explain what the advantages are, relative to existing solution.

I'm not sure what "they" is supposed to mean here, but the advantages
are quite clear to me: better security and reduced syscall overhead.
