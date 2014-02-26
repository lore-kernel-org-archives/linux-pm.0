From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Wed, 26 Feb 2014 19:03:33 +0000
Message-ID: <20140226190333.GD22839@e102568-lin.cambridge.arm.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
 <20140223200208.12998.47604@capellas-linux>
 <20140225113251.GB6855@e102568-lin.cambridge.arm.com>
 <20140225175531.18229.77850@capellas-linux>
 <20140226102427.GA22839@e102568-lin.cambridge.arm.com>
 <20140226175055.3502.49656@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140226175055.3502.49656@capellas-linux>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Russ Dill <Russ.Dill@ti.com>, Cyril Chemparathy <cyril@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 26, 2014 at 05:50:55PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-26 02:24:27)
> > On Tue, Feb 25, 2014 at 05:55:31PM +0000, Sebastian Capella wrote:
> > 
> > Please add:
> > 
> > "swsusp_save() is executed in the suspend finisher so that the CPU context
> > pointer and memory are part of the saved image, which is required by the
> > resume kernel image to restart execution from swsusp_arch_suspend()"
> > 
> > >  * soft_restart is not technically needed, but is used
> > >  * to get success returned from cpu_suspend.
> > >  * After resume, the hibernation snapshot is written out.
> > 
> > "When soft reboot completes, the hibernation snapshot is written out."
> > 
> > Resume is confusing since this code is resuming twice :D on image saving
> > and on kernel image restoration.
> 
> Thanks Lorenzo!
> 
> Here's what I've got.
> 
> /*
>  * Snapshot kernel memory and reset the system.
>  *
>  * swsusp_save() is executed in the suspend finisher so that the CPU
>  * context pointer and memory are part of the saved image, which is
>  * required by the resume kernel image to restart execution from
>  * swsusp_arch_suspend().
>  *
>  * soft_restart is not technically needed, but is used to get success
>  * returned from cpu_suspend.
>  * 
>  * When soft reboot completes, the hibernation snapshot is
>  * written out.
>  */
> 
> Does this look ok?  I'll prepare a v4 patchset.

Yes it does, I will wait and review v4 then.

Thank you,
Lorenzo
