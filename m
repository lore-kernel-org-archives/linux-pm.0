From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Fri, 21 Feb 2014 20:37:14 -0800
Message-ID: <20140222043714.19852.67450@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140221183956.29890.80931@capellas-linux>
 <20140221235911.14777.13919@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140221235911.14777.13919@capellas-linux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Russ Dill <Russ.Dill@ti.com>, Pavel Machek <pavel@ucw.cz>, Catalin Marinas <Catalin.Marinas@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Quoting Sebastian Capella (2014-02-21 15:59:11)
> - Cyril Chemparathy as his email is bouncing back to me. 
> 
> Quoting Sebastian Capella (2014-02-21 10:39:56)
> > Quoting Lorenzo Pieralisi (2014-02-20 08:27:55)
> > > > > > +     cpu_switch_mm(idmap_pgd, &init_mm);
>   [ ... ]
> > I can try removing it and seeing if there are side effects.
> 
> FYI, It's definitely hanging with this removed, still looking.

I see when we reach this call, the 1st level page table @ TTBR0 is located
at different memory locations each run (expected).  If we omit the
cpu_switch_mm we're corrupting the page table causing the observed
intermittent failures.  I believe these match the corruption you expected.

The reason this doesn't happen when I leave the call is that idmap_pgd
is always at the same memory location.  I expect this is because it's
allocated during init.  I've seen the same address 50/50 times for
idmap_pgd.  I don't think it is correct to rely on this behavior.

Would it be appropriate to use the swapper_pg_dir directly in place
of idmap_pgd?
  - I do not see any modification to the swapper_pg_dir contents in the
    code that would change from init time.
  - swapper_pg_dir is always at the same offset.

Ideally we should have no issue with overwriting it with identical data.

I've run a couple hundred test loops using swapper_pg_dir and so far
there are no failures.

Thanks,

Sebastian
