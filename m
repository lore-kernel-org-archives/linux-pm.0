From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Tue, 25 Feb 2014 09:55:31 -0800
Message-ID: <20140225175531.18229.77850@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
 <20140223200208.12998.47604@capellas-linux>
 <20140225113251.GB6855@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140225113251.GB6855@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Russ Dill <Russ.Dill@ti.com>, Cyril Chemparathy <cyril@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Quoting Lorenzo Pieralisi (2014-02-25 03:32:51)
> On Sun, Feb 23, 2014 at 08:02:08PM +0000, Sebastian Capella wrote:
> > I'll go with leaving the soft_restart as is unless someone feels
> > strongly against.
> 
> Leaving it as it is is fine for now, but should be commented, because that's
> not clear why it is needed by just reading the code.

Hi Lorenzo,

How is something like this?

/*
 * Snapshot kernel memory and reset the system.
 * soft_restart is not technically needed, but is used
 * to get success returned from cpu_suspend.
 * After resume, the hibernation snapshot is written out.
 */
static int notrace __swsusp_arch_save_image(unsigned long unused)
{
        int ret;

        ret = swsusp_save();
        if (ret == 0)
                soft_restart(virt_to_phys(cpu_resume));
        return ret;
}

Thanks again for all of the feedback!

Sebastian
