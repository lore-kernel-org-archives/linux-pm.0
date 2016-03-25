From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Power management fix for v4.6-rc1
Date: Fri, 25 Mar 2016 16:55:13 -0700
Message-ID: <CA+55aFxG4efV1U69zHt9SOUJnWmhWPSzv14hPxGBZ_b-tD6Bhg@mail.gmail.com>
References: <CAJZ5v0jMF=76ZvF3Er_iCt4hnOxf-b96Uy-PzsO=kQ7Dyy1FYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34546 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcCYXzO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 19:55:14 -0400
In-Reply-To: <CAJZ5v0jMF=76ZvF3Er_iCt4hnOxf-b96Uy-PzsO=kQ7Dyy1FYQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Mar 25, 2016 at 3:08 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> One of commits in my previous pull request changed the permissions
> of drivers/power/avs/rockchip-io-domain.c to executable by mistake.

Hmm. The signed tag contents was garbage - it was your previous
message. The commit it pointed to was fine.

Was it intentional? I had already pulled your previous tag, so it made
very little sense from my viewpoint..

I ended up just ignoring the signed tag part.

            Linus
