From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] PM / ACPI: Split acpi_lpss_suspend_late|resume_early()
Date: Sat, 7 Oct 2017 08:46:20 +0200
Message-ID: <CAPDyKFqFKC_fvzJ1Xu-N6ZoU0kxT0HsGFXa6X8XU8LCO1Q8o9A@mail.gmail.com>
References: <1507014669-1502-1-git-send-email-ulf.hansson@linaro.org>
 <1507014669-1502-5-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0gPHmQgfwcGJ2wCC-V1Rd=mdc8=ABLSJdCq2Ku+Xym27Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gPHmQgfwcGJ2wCC-V1Rd=mdc8=ABLSJdCq2Ku+Xym27Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 6 October 2017 at 14:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Oct 3, 2017 at 9:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Move the code which is special to ACPI LPSS into separate functions. This
>> may clarify the code a bit, but the main purpose of this change, is instead
>> to prepare for additional changes on top. Ideally the following changes
>> should then become easier to review.
>
> I'm not sure what changes this is talking about.

Right, I forgot to update the changelog.

>
> I have the device flags patches in the works, but I don't think they
> will need this ATM.

Okay, then let's just ignore this one.

Kind regards
Uffe
