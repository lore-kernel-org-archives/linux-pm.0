From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.14.0-rc7: cpufreq interface in sysfs removed ?
Date: Wed, 1 Nov 2017 21:24:01 +0100
Message-ID: <CAJZ5v0gJa0-YRHVhKWE5GeY1D7W0FSPjxSx8UHqCK=wTir3PEw@mail.gmail.com>
References: <CADDKRnDjXzSU=toFVH6pYOS9co4rp-hQ8rv6U9zBnChj_bLAvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:51471 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdKAUYD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 16:24:03 -0400
In-Reply-To: <CADDKRnDjXzSU=toFVH6pYOS9co4rp-hQ8rv6U9zBnChj_bLAvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Nov 1, 2017 at 6:06 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> In 4.14.0-rc7-00009-g287683d cpufreq directory under
> /sys/devices/system/cpu/cpufreq
> is empty. Also link /sys/devices/system/cpu/cpu0/cpufreq is missing.
>
> Is this change intentional?

Sure not.

What's the last good kernel you tested before this one?

Thanks,
Rafael
