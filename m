From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] ACPI fixes for v4.19-rc3
Date: Fri, 7 Sep 2018 11:40:35 +0200
Message-ID: <CAJZ5v0gwBEWeQ6ONkRh84UEO8yBtW6m_ttSzR61YUfUR0Qs6Ug@mail.gmail.com>
References: <CAJZ5v0jWX3mBgeQdhGJr8_Okt_bouG+azeFORh=XiMTLvyimPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jWX3mBgeQdhGJr8_Okt_bouG+azeFORh=XiMTLvyimPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 7, 2018 at 11:37 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> two ACPI fixes for 4.19-rc3.
>
> These fix a regression from the 4.18 cycle in the ACPI driver
> for Intel SoCs (LPSS) and prevent dmi_check_system() from being
> called on non-x86 systems in the ACPI core.
>
> Specifics:
>
>  - Fix a power management regression in the ACPI driver for Intel
>    SoCs (LPSS) introduced by a system-wide suspend/resume fix during
>    the 4.18 cycle (Zhang Rui).
>
>  - Prevent dmi_check_system() from being called on non-x86 systems in
>    the ACPI core (Jean Delvare).
>
> Thanks!
>
>
> ---------------
>
> Jean Delvare (1):
>       ACPI / bus: Only call dmi_check_system() on X86
>
> Zhang Rui (1):
>       ACPI / LPSS: Force LPSS quirks on boot

Sorry for the incomplete message, I will send the correct one momentarily.

Rafael
