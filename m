From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's
 option
Date: Wed, 3 Apr 2019 22:55:41 +0000
Message-ID: <20190403225539.wgytklr6ndpzbrlu@pburton-laptop>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Content-Language: en-US
Content-ID: <9F76AB0D364FC842ABC1B5D5590BEE17@namprd22.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexey Brodkin <alexey.brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Russell King <linux@armlinux.org.uk>, "edubezval@gmail.com" <edubezval@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Ralf Baechle <ralf@linux-mips.org>, Guenter Roeck <groeck@chromium.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "open list:MIPS" <linux-mips@vger.kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Andrew Morton <akpm@linux-foundation.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Tue, Apr 02, 2019 at 06:12:44PM +0200, Daniel Lezcano wrote:
> The module support for the thermal subsystem makes little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the thermal
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot time
>    in order to mitigate

Nit: mitigate what? High temperatures? It feels like this sentence was
cut short.

> Usually the subsystems framework are compiled-in and the plugs are as module.
> 
> Remove the module option. The removal of the module related dead code will
> come after this patch gets in or is acked.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <groeck@chromium.org>
> For mini2440:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS part

Thanks,
    Paul
