From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Tue, 26 Jun 2018 00:14:57 +0200
Message-ID: <CAJZ5v0jPp5GyrHCGLxXzbUOM2MzSL1ikkiEAMt32mcsuY1Gp4Q@mail.gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com> <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd> <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
 <20180625115913.GD17001@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625115913.GD17001@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 25, 2018 at 1:59 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
>
>> > Well, AFAICT in this case userland has the key and encrypted data are
>> > on disk. That does not seem to be improvement.
>>
>> Not really.
>>
>> With the encryption in the kernel, if the kernel is careful enough,
>> use space will not be able to read the image even if it knows the
>> passphrase, unless it can also add itself to the initramfs image
>> loaded by the restore kernel, which (at least) can be made way more
>> difficult than simply reading the plain-text image data via an I/F
>> readily provided by the kernel.
>
> I still do not see the improvement. If you are root, you can modify
> the initramfs and decrypt the data.

Even so, this requires additional effort which already makes the life
of attackers harder.

> Please explain in the changelog how this is better than existing solution.

That can be done.

>> >> Besides, the user space part of what you are calling uswsusp has not
>> >> been actively maintained for years now and honestly I don't know how
>> >> many users of it there are.
>> >
>> > I'd assume distros want progress bars so they still use it?
>>
>> I'd rather not speak for distros, but if hibernation images are
>> written to fast storage, progress bars are not that useful any more.
>> They are not used on Windows any more, for one.
>>
>> > Anyway, there's solution for encrypted hibernation.
>>
>> Which is suboptimal and you know it.
>
> If this is better, please explain how in the changelog.
>
>> > If Intel wants to invent different solution for that, and put it into kernel, they
>> > should explain what the advantages are, relative to existing solution.
>>
>> I'm not sure what "they" is supposed to mean here, but the advantages
>> are quite clear to me: better security and reduced syscall overhead.
>
> Better security against which attack?

If kernel memory is encrypted by the kernel, it doesn't have to worry
about bugs in user space utilities and similar, for example.

> Syscall overhead is not a problem for hibernation, and you know it.

Oh well.

I wrote the majority of the code you seem to be defending and I don't
really share your enthusiasm about it.  It was good enough at the time
it was written, but not today and this discussion is over as far as
I'm concerned.
