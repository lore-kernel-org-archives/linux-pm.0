From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH RFC 1/5] ACPI / containers : add support for ACPI0010
 processor container
Date: Fri, 08 May 2015 16:50:10 +0800
Message-ID: <554C78C2.706@linaro.org>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com> <1430922690-6966-2-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430922690-6966-2-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 2015=E5=B9=B405=E6=9C=8806=E6=97=A5 22:31, Sudeep Holla wrote:
> ACPI 6.0 adds support for optional processor container device which m=
ay
> contain child objects that are either processor devices or other proc=
essor
> containers. This allows representing hierarchical processor topologie=
s.
>
> It is declared using the _HID of ACPI0010. It may also have _CID of
> PNP0A05, which represents a generic container device.

Container device helps support hotplug of nodes, CPUs, and memory,
does this container device ACPI0010 used for the same purpose?

=46or my understanding, ACPI0010 is used to abstract CPU topology
like cluster, not for hotplug purpose, maybe I missed something,
or you just need this container driver for later use?

Thanks
Hanjun

>
> This patch enables the support for these ACPI processor containers.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   Documentation/memory-hotplug.txt | 2 +-
>   drivers/acpi/container.c         | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/memory-hotplug.txt b/Documentation/memory-=
hotplug.txt
> index ce2cfcf35c27..bdbf7bb88d5d 100644
> --- a/Documentation/memory-hotplug.txt
> +++ b/Documentation/memory-hotplug.txt
> @@ -124,7 +124,7 @@ config options.
>
>   - As a related configuration, if your box has a feature of NUMA-nod=
e hotplug
>     via ACPI, then this option is necessary too.
> -    ACPI0004,PNP0A05 and PNP0A06 Container Driver (under ACPI Suppor=
t menu)
> +    ACPI0004, ACPI0010, PNP0A05 and PNP0A06 Container Driver (under =
ACPI Support menu)
>       (CONFIG_ACPI_CONTAINER).
>       This option can be kernel module too.
>
> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> index c8ead9f97375..8c041b9ac359 100644
> --- a/drivers/acpi/container.c
> +++ b/drivers/acpi/container.c
> @@ -36,6 +36,7 @@ ACPI_MODULE_NAME("container");
>
>   static const struct acpi_device_id container_device_ids[] =3D {
>   	{"ACPI0004", 0},
> +	{"ACPI0010", 0},
>   	{"PNP0A05", 0},
>   	{"PNP0A06", 0},
>   	{"", 0},
>
