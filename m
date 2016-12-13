From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: Re: [PATCH v3 0/2] power: supply: add sbs-charger driver
Date: Tue, 13 Dec 2016 11:41:01 +0100
Message-ID: <dd0728de-822a-0aee-0aea-8256843b39d0@prodys.net>
References: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24/11/16 13:33, Nicolas Saenz Julienne wrote:
> Hi,
> 
> This series adds support for all SBS compatible battery chargers, as defined
> here: http://sbs-forum.org/specs/sbc110.pdf.
> 
> The first patch changes the sbs-battery device name in order to be able to
> create a proper supplier/supplied relation between the two of them.
> 
> The second introduces the driver.
> 
> Regards,
> Nicolas
> 
> changes since v2:
> - updated driver and dt-binding with Sebatian's comments
> 
> changes since v1:
> - added dt bindings
> - updated driver with Sebastian's comments
> - s/Nicola/Nicolas/ in commits
> 
> Nicolas Saenz Julienne (2):
>   power: supply: add sbs-charger driver
>   dt-bindings: power: add bindings for sbs-charger
> 
>  .../bindings/power/supply/sbs_sbs-charger.txt      |  24 ++
>  drivers/power/supply/Kconfig                       |   6 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/sbs-charger.c                 | 275 +++++++++++++++++++++
>  4 files changed, 306 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
>  create mode 100644 drivers/power/supply/sbs-charger.c
> 
Hi,
any update?

Kind Regards,
Nicolas
