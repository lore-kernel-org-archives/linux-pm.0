From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_idle and turbostat patches for Linux 3.15 merge
Date: Tue, 08 Apr 2014 13:43:17 +0200
Message-ID: <465654157.6jzXs2R7pb@vostro.rjw.lan>
References: <CAJvTdKmg+oS2ikeGZ3eGVSn7=XPey465ZMz_RSC32iBt0Qzyzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55623 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756040AbaDHL1R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Apr 2014 07:27:17 -0400
In-Reply-To: <CAJvTdKmg+oS2ikeGZ3eGVSn7=XPey465ZMz_RSC32iBt0Qzyzg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Monday, April 07, 2014 11:48:40 PM Len Brown wrote:
> Hi Rafael,
> 
> Please pull these ACPI & Power Management patches for 3.15.
> They have been in in linux-next for some time via my next branch.
> 
> get-send-email seems to have failed me in getting these onto the list.
> I'll try to figure out why and get the re-posted tomorrow.
> 
> thanks!
> Len Brown, Intel Open Source Technology Center
> 
> The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:
> 
>   Linux 3.14 (2014-03-30 20:40:15 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release
> 
> for you to fetch changes up to 23a299cd93781a190cdca0d7d16034837b7dfd86:

Pulled, thanks!

>   Merge branches 'turbostat' and 'intel_idle' into release (2014-04-04
> 13:05:22 -0400)
> 
> ----------------------------------------------------------------
> 
> Jan Kiszka (1):
>       intel_idle: Add CPU model 54 (Atom N2000 series)
> 
> Len Brown (7):
>       ACPI idle: permit sparse C-state sub-state numbers
>       intel_idle: allow sparse sub-state numbering, for Bay Trail
>       intel_idle: support Bay Trail
>       tools/power turbostat: simplify output, add Avg_MHz
>       tools/power turbostat: Run on Broadwell
>       intel_idle: fine-tune IVT residency targets
>       Merge branches 'turbostat' and 'intel_idle' into release
> 
>  arch/x86/kernel/acpi/cstate.c         |   4 +-
>  drivers/idle/intel_idle.c             | 204 ++++++++++++++++++++++++++++-
>  tools/power/x86/turbostat/turbostat.8 | 127 +++++++-----------
>  tools/power/x86/turbostat/turbostat.c | 240 ++++++++++++++++------------------
>  4 files changed, 362 insertions(+), 213 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
