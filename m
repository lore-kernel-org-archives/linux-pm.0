From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] Urgent power management fixes for v4.18
Date: Wed, 1 Aug 2018 12:06:34 +0200
Message-ID: <CAJZ5v0iGA=oVV9eaF=JkmK4iY20x44qjkOKDLJa_f6CPUHK=ng@mail.gmail.com>
References: <CAJZ5v0jHpO3werjy2f1RVuFSNCpJReSi3QzxDT1Vuz5fAGd_Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jHpO3werjy2f1RVuFSNCpJReSi3QzxDT1Vuz5fAGd_Ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 1, 2018 at 12:03 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> urgent power management fixes for final 4.18.
>
> These fix the scope of a recent intel_pstate driver optimization
> used incorrectly on some systems due to processor identification
> ambiguity and fix a few issues in the turbostat utility, including
> three recent regressions.
>
> Specifics:
>
>  - Use ACPI FADT preferred PM Profile to distinguish Skylake
>    desktop processors from some server ones with the same model
>    number in order to limit the scope of the recent IO-wait boost
>    optimization to servers, as intended (Srinivas Pandruvada).
>
>  - Fix several issues in the turbostat utility:
>    * Fix the -S option on 1-CPU systems (Len Brown).
>    * Fix computations using incorrect processor core counts (Artem
>      Bityutskiy).
>    * Fix the x2apic debug message (Len Brown).
>    * Fix logical node enumeration to allow for non-sequential
>      physical nodes (Prarit Bhargava).
>    * Fix reported family on modern AMD processors (Calvin Walton).
>    * Clarify the RAPL column information in the man page (Len Brown).

Sorry for the broken message, I'll send the correct one shortly.
