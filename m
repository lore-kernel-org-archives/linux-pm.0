From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Thu, 21 Jun 2018 14:08:40 +0200
Message-ID: <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com> <20180621085332.GA21807@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621085332.GA21807@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> As security becomes more and more important, we add the in-kernel
>> encryption support for hibernation.
> ...
>> There was a discussion on the mailing list on whether this key should
>> be derived in kernel or in user space. And it turns out to be generating
>> the key by user space is more acceptable[1]. So this patch set is divided
>> into two parts:
>> 1. The hibernation snapshot encryption in kernel space,
>> 2. the key derivation implementation in user space.
>
> uswsusp was created so that this kind of stuff could be kept in
> userspace. You get graphical progress bar (etc) too. As you already
> have userspace component for key derivation, I see no advantages to
> uswsusp.
>
> If you have some, please explain.

Not having to transfer plain text kernel memory to user space is one IMO.

Besides, the user space part of what you are calling uswsusp has not
been actively maintained for years now and honestly I don't know how
many users of it there are.
