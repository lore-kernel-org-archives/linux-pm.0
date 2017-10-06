From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] PM / ACPI: Split acpi_lpss_suspend_late|resume_early()
Date: Fri, 6 Oct 2017 14:59:46 +0200
Message-ID: <CAJZ5v0gPHmQgfwcGJ2wCC-V1Rd=mdc8=ABLSJdCq2Ku+Xym27Q@mail.gmail.com>
References: <1507014669-1502-1-git-send-email-ulf.hansson@linaro.org> <1507014669-1502-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507014669-1502-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 3, 2017 at 9:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Move the code which is special to ACPI LPSS into separate functions. This
> may clarify the code a bit, but the main purpose of this change, is instead
> to prepare for additional changes on top. Ideally the following changes
> should then become easier to review.

I'm not sure what changes this is talking about.

I have the device flags patches in the works, but I don't think they
will need this ATM.

Thanks,
Rafael
