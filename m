From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 02/07] dma: rework dw_dmac
	suspend_late()/resume_early()
Date: Fri, 5 Jun 2009 10:18:16 +0200
Message-ID: <20090605101816.6bbe496e__39190.0939438075$1244245738$gmane$org@hskinnemoen-d830>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
	<20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: ben-linux@fluff.org, anemo@mba.ocn.ne.jp, gregkh@suse.de, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

Magnus Damm wrote:
> +static struct dev_pm_ops dw_dev_pm_ops = {
> +	.suspend_noirq = dw_suspend_noirq,
> +	.resume_noirq = dw_resume_noirq,
> +};

Can this be const?

Haavard
