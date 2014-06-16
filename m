From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 3/4] drm/tegra: Request memory bandwidth for the
 display controller
Date: Mon, 16 Jun 2014 14:06:43 -0600
Message-ID: <539F4E53.6080205@wwwdotorg.org>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1402925713-25426-4-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@linaro.org>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-pm@vger.kernel.org

On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> Request it based solely on the current mode's refresh rate. More
> accurate requirements can be requested in future patches.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c

> +	bandwidth = mode->clock * window.bits_per_pixel / 8;
> +	err = tegra124_emc_reserve_bandwidth(TEGRA_EMC_CONSUMER_DISP1, bandwidth);

DISP1 shouldn't be hard-coded here; the code should use DISP1 or DISP2
based on head or DC identity. We certainly have some boards capable of
dual-head operation.
