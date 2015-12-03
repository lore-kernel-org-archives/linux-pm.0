From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 06/10] thermal: rockchip: consistently use int for
 temperatures
Date: Wed, 2 Dec 2015 16:49:03 -0800
Message-ID: <20151203004903.GA9543@google.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <1447044542-30859-7-git-send-email-wxt@rock-chips.com>
 <20151202183851.GA91131@google.com>
 <565F8FFE.3080807@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565F8FFE.3080807-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

On Thu, Dec 03, 2015 at 08:42:38AM +0800, Caesar Wang wrote:
> ? 2015?12?03? 02:38, Brian Norris ??:
> 
> [.....]
> >  	if (thermal->tshut_temp > INT_MAX) {
> >      CID 1341498:  Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
> >      "thermal->tshut_temp > 2147483647 /* (int)(~0U >> 1) */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
> >
> >I don't think this condition is even useful any more, so maybe we should
> >just kill the 'if' block.
> 
> See the patch to fix
> it.----->(https://patchwork.kernel.org/patch/7720601/)
> <https://patchwork.kernel.org/patch/7720601/>

-	if (thermal->tshut_temp > INT_MAX) {
+	if (!(thermal->tshut_temp < INT_MAX)) {

Huh? That still doesn't make much sense. The condition is still
impossible, since thermal->tshut_temp is an int. You've just made it
slightly harder for static analyzers to notice the impossibility.

> This patch is merged into kernel 4.4-rc3.

No it isn't, and I'm glad. The patch is silly.

Brian
