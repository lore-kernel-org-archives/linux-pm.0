From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 0/5] thermal: fixes the rockchip thermal
Date: Wed, 23 Nov 2016 22:29:29 +0800
Message-ID: <1479911374-22006-1-git-send-email-wxt@rock-chips.com>
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
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

There are five patches posted for upstream.
89267b5 thermal: rockchip: improve conversion error messages
a0b5649 thermal: rockchip: don't pass table structs by value
bceed92 thermal: rockchip: fixes invalid temperature case
30be6d0 thermal: rockchip: optimize the conversion table
35636e9 thermal: rockchip: handle the set_trips without the trip points.
--

Brain posted the below patches for upstream.
89267b5 thermal: rockchip: improve conversion error messages
a0b5649 thermal: rockchip: don't pass table structs by value
That make sense to improve efficiency

Caesar post the below patches for upstream.
bceed92 thermal: rockchip: fixes invalid temperature case
30be6d0 thermal: rockchip: optimize the conversion table
35636e9 thermal: rockchip: handle the set_trips without the trip points.
That will fixes some issue in special cases.
--

Anyway, this series patches should can improve the rockchip thermal driver.


Changes in v2:
- As Brian commnets that restructure this to pass error codes back to the
  upper layers.
- Improve the commit message.
- improve the commit as Brian commnets on https://patchwork.kernel.org/patch/9440985
- Fixes something as Brian comments on
  https://patchwork.kernel.org/patch/9440989.

Changes in v1:
- The original Brian posted on https://patchwork.kernel.org/patch/9437686
  Note: it'd probably be even nicer to know which sensor this was, but we've
  kinda abstracted that one away by this point...
- The original Brian posted on https://patchwork.kernel.org/patch/9437687

Brian Norris (2):
  thermal: rockchip: improve conversion error messages
  thermal: rockchip: don't pass table structs by value

Caesar Wang (3):
  thermal: rockchip: fixes invalid temperature case
  thermal: rockchip: optimize the conversion table
  thermal: rockchip: handle set_trips without the trip points

 drivers/thermal/rockchip_thermal.c | 147 +++++++++++++++++++++++++------------
 1 file changed, 101 insertions(+), 46 deletions(-)

-- 
2.7.4
