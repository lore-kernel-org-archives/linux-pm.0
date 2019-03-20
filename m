From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 0/2] tools/power turbostat: Add support for AMD Fam 17h
 (Zen) RAPL
Date: Wed, 20 Mar 2019 19:35:55 -0400
Message-ID: <CAJvTdKnsv8zyq8ndKWFezx7sgYmp7ZwD5yMdYW5jYbUbPLr+WA@mail.gmail.com>
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Walton <calvin.walton@kepstin.ca>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Applied, thanks!

On Fri, Aug 17, 2018 at 12:35 PM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> This is an updated version of my RAPL patchset for Zen CPUs, rebased on
> top of the current state of kernel/git/lenb/linux.get turbostat branch.
> (In particular, this fixes conflicts with the AMD APIC-id patch)
>
> I've split it into two patches now. The first patch only adds Cores
> power reporting, since I'm fairly confident that this'll work on all of
> the Zen chips. I think this part is ready to apply now.
>
> The second part is still a work in progress until I'm able to (or I'm
> able to find someone else to) test the package power reporting on a
> multi-die Zen chip.
>
> Calvin Walton (2):
>   tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
>   [WIP] tools/power turbostat: Also read package power on AMD F17h (Zen)
>
>  tools/power/x86/turbostat/turbostat.c | 167 +++++++++++++++++++++-----
>  1 file changed, 138 insertions(+), 29 deletions(-)
>
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
