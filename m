From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] psci: add CPU_IDLE dependency
Date: Mon, 31 Jul 2017 07:34:43 -0500
Message-ID: <ab4a0f46-6b8a-9198-8a4f-898834685b16@ti.com>
References: <20170731085523.320244-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170731085523.320244-1-arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Carlo Caione <carlo@endlessm.com>, Olof Johansson <olof@lixom.net>, Thierry Reding <treding@nvidia.com>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-pm@vger.kernel.org

On 07/31/2017 03:55 AM, Arnd Bergmann wrote:
> I ran into a build error for the psci_checker:
> 
> drivers/firmware/psci_checker.o: In function `psci_checker':
> psci_checker.c:(.init.text+0x528): undefined reference to `cpuidle_devices'
> 
> As far as I can tell, this is simply a very rare combination of options,
> but the problem has existed since the code was initially added.
> Adding a Kconfig dependency makes it build properly.
> 
> Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/firmware/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 6e4ed5a9c6fd..1983e6e0106f 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -10,7 +10,7 @@ config ARM_PSCI_FW
>   
>   config ARM_PSCI_CHECKER
>   	bool "ARM PSCI checker"
> -	depends on ARM_PSCI_FW && HOTPLUG_CPU && !TORTURE_TEST
> +	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
>   	help
>   	  Run the PSCI checker during startup. This checks that hotplug and
>   	  suspend operations work correctly when using PSCI.
> 
Ccying linux-arm and linux-pm

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
