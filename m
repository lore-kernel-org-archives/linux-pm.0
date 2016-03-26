From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] Power management fix for v4.6-rc1
Date: Sat, 26 Mar 2016 01:09:51 +0100
Message-ID: <CAJZ5v0g88qpdo3M3NfMDp3d1kLLzJE6iMG47fg_-mB=0524WVQ@mail.gmail.com>
References: <CAJZ5v0jMF=76ZvF3Er_iCt4hnOxf-b96Uy-PzsO=kQ7Dyy1FYQ@mail.gmail.com>
	<CA+55aFxG4efV1U69zHt9SOUJnWmhWPSzv14hPxGBZ_b-tD6Bhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxG4efV1U69zHt9SOUJnWmhWPSzv14hPxGBZ_b-tD6Bhg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 26, 2016 at 12:55 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 25, 2016 at 3:08 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> One of commits in my previous pull request changed the permissions
>> of drivers/power/avs/rockchip-io-domain.c to executable by mistake.
>
> Hmm. The signed tag contents was garbage - it was your previous
> message. The commit it pointed to was fine.

Yes, sorry about the broken tag.

> Was it intentional?

No, it wasn't.  I forgot to update the message file when creating the tag.

> I had already pulled your previous tag, so it made
> very little sense from my viewpoint..
>
> I ended up just ignoring the signed tag part.

Thanks a lot for pulling and sorry for the breakage.

Rafael
