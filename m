From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Date: Mon, 25 Jun 2018 23:56:43 +0200
Message-ID: <CAJZ5v0jBh_0Uz54-Y2-qwdJNeD+KMpGEsH7q0XOdbCq5VCP1Ng@mail.gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com> <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd> <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
 <20180621190401.GA14623@amd> <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
 <20180625115405.GB17001@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625115405.GB17001@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Ted Ts'o <tytso@mit.edu>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Stephan Mueller <smueller@chronox.de>, Eric Biggers <ebiggers3@gmail.com>, Denis Kenzior <denkenz@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 25, 2018 at 1:54 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> > It can already do encryption. If you see problems there, patches will
>> >> > be gladly accepted to fix them.
>> >>
>> >> By whom?
>> >
>> > By me.
>>
>> Well, OK
>>
>> Where's the repository the patches will go to when you accept them?
>
> On sourceforge.

No, it's not there or at least it's outdated AFAICS.

>> >> > If you want to maintain uswsusp in kernel tree, I guess that would be
>> >> > an option, too.
>> >>
>> >> No, it isn't an option due to the dependencies on crypto libraries.
>> >
>> > Why not?
>>
>> You need a specific set of devel libraries for the utilities to build
>> and that need not be present on all systems I suppose?
>>
>> Besides, s2disk is currently tangled with s2ram which is obsolete, so
>> I'd rather not.
>
> Its not tangled.

Yes, it is.
