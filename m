From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH V5 27/30] Documentation: thermal: Explain the exynos
 thermal driver model
Date: Tue, 11 Jun 2013 12:22:05 -0500
Message-ID: <1370971325.2776.99@driftwood>
References: <1370955220-2949-1-git-send-email-amit.daniel@samsung.com>
	<1370955220-2949-28-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370955220-2949-28-git-send-email-amit.daniel@samsung.com>
	(from amit.daniel@samsung.com on Tue Jun 11 07:53:37 2013)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/11/2013 07:53:37 AM, Amit Daniel Kachhap wrote:
> This patch updates the documentation to explain the driver model
> and file layout.
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  Documentation/thermal/exynos_thermal |   43  
> ++++++++++++++++++++++++++-------
>  1 files changed, 34 insertions(+), 9 deletions(-)
...
> -TMU(Thermal Management Unit) in EXYNOS4 generates interrupt
> +TMU(Thermal Management Unit) in EXYNOS4/5 generates interrupt
>  when temperature exceeds pre-defined levels.
> -The maximum number of configurable threshold is four.
> +The maximum number of configurable threshold is five.

Was that a driver change or was that a chipset change that only applies  
to version 5?

Rob