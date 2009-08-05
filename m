From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 2/5] pda-power: switch to new dev_pm_ops
Date: Wed, 5 Aug 2009 21:49:52 +0200
Message-ID: <200908052149.55567.elendil__22669.4833524109$1249501960$gmane$org@planet.nl>
References: <1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-1-git-send-email-daniel@caiaq.de>
	<1249496971-9019-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-To: <1249496971-9019-2-git-send-email-daniel@caiaq.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: spyro@f2s.com, linux-kernel@vger.kernel.org, cbou@mail.ru, mreimer@vpop.net, daniel@caiaq.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Daniel Mack wrote:
> +static struct dev_pm_ops pda_power_pm_ops = {
> +       .suspend        = pda_power_suspend,
> +       .freeze         = pda_power_freeze,

Hmmm. Where's pda_power_freeze defined? Forgot to (compile)test the 
patches?

> +       .resume         = pda_power_resume,
> +       .thaw           = pda_power_resume,
