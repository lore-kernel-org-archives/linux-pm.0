From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix too early/late system
 suspend/resume callbacks
Date: Wed, 4 Apr 2018 11:24:21 +0530
Message-ID: <20180404055420.GE15443@localhost>
References: <1522342412-10126-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522342412-10126-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dan Williams <dan.j.williams@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 29, 2018 at 06:53:32PM +0200, Geert Uytterhoeven wrote:
> If serial console wake-up is enabled ("echo enabled >
> /sys/.../ttySC0/power/wakeup"), and any serial input is received while
> the system is suspended, serial port input no longer works after system
> resume.
> 
> Note that:
>   1) The system can still be woken up using the serial console,
>   2) Serial port input keeps working if the system is woken up in some
>      other way (e.g. Wake-on-LAN or gpio-keys), and no serial input was
>      received while suspended.
> 
> To fix this, replace SET_LATE_SYSTEM_SLEEP_PM_OPS() by
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(), as the callbacks installed by the
> former happen too early resp. late in the suspend resp. resume process.

Applied, thanks

-- 
~Vinod
