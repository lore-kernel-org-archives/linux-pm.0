From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: AC/battery: Add quirk to avoid using PMIC
Date: Fri, 16 Feb 2018 09:40:43 +0100
Message-ID: <CAJZ5v0iP5o9-eeyB9JTvPSR97Z+d+=or_5F5QB107GipvteuAw@mail.gmail.com>
References: <20180216082616.25084-1-carlo@caione.org> <20180216082616.25084-2-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180216082616.25084-2-carlo@caione.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Linux Upstreaming Team <linux@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 16, 2018 at 9:26 AM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> With commits af3ec837 and dccfae6d a blacklist was introduced to avoid
> using the ACPI drivers for AC and battery when a native PMIC driver was
> already present. While this is in general a good idea (because of broken
> DSDT or proprietary and undocumented ACPI opregions for the ACPI
> AC/battery devices) we have come across at least one CherryTrail laptop
> (ECS EF20EA) shipping the AXP288 together with a separate FG controller
> (a MAX17047) instead of the one embedded in the AXP288.
>
> The net effect of blacklisting the ACPI drivers is that on this platform
> the AC/battery reporting is broken since the information is coming from
> the AXP288 FG driver, not actually used in hardware.
>
> In this case we want to keep using the ACPI AC/battery driver that is
> able to interface correctly with the real FG controller.
>
> We introduce therefore a new quirk to avoid the blacklist.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

First, please don't split the patches the way you have split them.

Put all battery material into one patch and all AC material into the
next one.  It is better to introduce things like
ac_not_use_pmic_quirk() along with the quirks actually using them.

> ---
>  drivers/acpi/ac.c      | 26 ++++++++++++++++++--------
>  drivers/acpi/battery.c | 26 ++++++++++++++++++--------
>  2 files changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 47a7ed557bd6..b9a4ca720309 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -87,6 +87,7 @@ static int acpi_ac_open_fs(struct inode *inode, struct file *file);
>
>
>  static int ac_sleep_before_get_state_ms;
> +static bool ac_not_use_pmic;

I would use a different name here, this one is confusing IMO.

Something like ac_skip_pmic_blacklist would be better.
