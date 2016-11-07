From: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 0/2] set specific ddr frequency when stop ddr dvfs
Date: Mon,  7 Nov 2016 14:23:07 +0800
Message-ID: <1478499789-21589-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

We need ddr run a specific frequency when ddr dvfs stop working. So we
implement get suspend frequency function in devfreq framework, and call
it in rk3399 dmc driver. 

Lin Huang (2):
  PM/devfreq: add suspend frequency support
  PM/devfreq: rk3399: get devfreq suspend frequency

 drivers/devfreq/devfreq.c                 | 18 ++++++++++++++++--
 drivers/devfreq/governor_simpleondemand.c |  9 +++++++++
 drivers/devfreq/rk3399_dmc.c              |  2 +-
 include/linux/devfreq.h                   |  8 ++++++++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
1.9.1
