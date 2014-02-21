From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Fri, 21 Feb 2014 15:59:11 -0800
Message-ID: <20140221235911.14777.13919@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140221183956.29890.80931@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140221183956.29890.80931@capellas-linux>
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

- Cyril Chemparathy as his email is bouncing back to me. 

Quoting Sebastian Capella (2014-02-21 10:39:56)
> Quoting Lorenzo Pieralisi (2014-02-20 08:27:55)
> > > > > +     cpu_switch_mm(idmap_pgd, &init_mm);
  [ ... ]
> I can try removing it and seeing if there are side effects.

FYI, It's definitely hanging with this removed, still looking.

> In this state I believe:
>   - our stack is safe because it's in nosave.
>   - userspace is frozen, those pages are 'don't care', as we're
>     discarding its state.
>   - our instructions and globals are ok, because they're in the
>     same place as last boot and are not getting restored.  None are in
>     modules.
>      - Globals: restore_pblist, idmap_pgd, init_mm, swapper_pg_dir

Sorry, this last bit about the globals is not correct.  Of course
they're getting restored.  What I meant to say is that they shouldn't
be affected by the mmu switch as they remain at the same address.

For our purposes, I think we won't care about their state as we're not
referencing them after we start restoring.  We start the list
with restore_pblist, but after following the initial pointer, we don't
reference it again.  From then on, we're walking safe memory lists.

Sorry for the misleading statements.

Sebastian
