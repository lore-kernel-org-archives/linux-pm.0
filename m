Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF373AD539
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803186; cv=none; b=WRaiiTu+C3VgXo/HBnzWbjuItwLaG4rhOwcugW/dTQTlmGiUFisN0S2N60YxvN1x98eOsHC42BYigl5AppUxBPi6HNdNVhHn48eqCTOWQuTcsBv7vMVqXarFfzqTTYI/L0QoetlG+RH2Bgu2gGF0bBlhZ1fbNerh18dEAOLg2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803186; c=relaxed/simple;
	bh=j46M7g0vNOQzBzUqX8jRhq3wp7B2WecemH7BOSH5u+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEGvgu6KgxLy6fi4XfbLxPT10U09l4Rv6AcSgbkF0eam0cxfhI7twnV9pQbg1w+IOl78m1mLsQIoGbQKHFZ/VXmaJPuxGKd5bIMM15okxGHDujtPVUR3kqrR8MYROueUliws5fTWOsTsboA7HcXZHJ1O4OY+8teHncgvpbYpGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=FP2ppxtw; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="FP2ppxtw"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50b9e8a45so852732a12.2
        for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1789803181; x=1790407981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KLllryddbvlzfJ9iiqvVmRzOK72twRQNaoO0m17eONQ=;
        b=FP2ppxtwoUHLYnH2HEZIRcRqMzm/aF12bPrQoPqCG0Ofu2Ncwv2mXA6KW3D1sEmJrt
         Q5lpqLyIaioY0emDeb5tv/o1w+dWSWiU6Jf4Um2ERZuRMc+kBw+EnST60U/9rWqSkkPW
         KapJYcvm6sxlgXd5igqcP5I5fnTf5L5hUaVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789803181; x=1790407981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLllryddbvlzfJ9iiqvVmRzOK72twRQNaoO0m17eONQ=;
        b=jQ7GSMsk1B7tVAOz3ZKOsyyUdJypXmXyFbCHwXLK7bA9J9k5TUH6n0o+79WuYdN/9v
         gjXEcF5DFCF45Zk0xfMEaeOdZ+bxLO4BK87YJD2VRnaKP2XKtO9iJ5A6WJiJHHPb8ez6
         QAwMatmlRSBzIh94x8KlcDSuNT6pz70967u89nxwnX/O2vLw4RD1Vc0TdKta241Si+zM
         ngGt9oUy4V1TT76ejOn6/zCEPOdhqRckKGala0TnvcGNVfgNuMyVN1ARcjlSkkz6avDg
         69gsOT+ObHnNaLbW/Ta114XICnoU+Qotz1lZvStxcqkF5sfzKJTAbyX3PVh59e/wuC7i
         ZDLw==
X-Forwarded-Encrypted: i=1; AKwUvByXT/cbMd0XDJ4gRCrdg592WAvm43GR6NTCx9spbir/HTqHUPKBw56V58SoDi6/Q+sw5Fithk8R3g==@vger.kernel.org
X-Gm-Message-State: AFuF++n4MDfQ+s5nMgIL9QEJZm2sgsOZdvZrH8IvbuUjXPJG8TgIZ4gJ
	iCRxLLWmqIC9+v0xT1dyNfhbOTHsnWKnQ/WFWIUHQcpxEm74kFK1cv+L0P9Myc1i4js=
X-Gm-Gg: AYBFou3+4+JJ5KuTWWZpJXCTO8q4AeVAzn39s+6gOPuO5aSZFpJRQamyQucSTKDnGa9
	oQNNb6/ogKzcWksSKPKSheLlK+D15vpcig0xZ5Llf4xiGreTs1Rfcee5lxr1+Q5qLJlIz5evKP1
	wUhcoclK7CUIill3LGG17zRhsNimZoTXN/kz2u8v3Dq+IAT8SRLXsyDvkWUMWuMEl2Xie3nI8Zv
	yk3+ahiZVLbgArMUy/RsSnAGCnFQnrSxf4fouh1gTJIIyQJG5kjyUkcqXE7Qk12F8+2vqIuqTQI
	wTck//zAkGiLka/SWQpAfCzMwPkMqykbcLBtIhAmko8GOBuk3Qjw3pBo2PKF4RSsaIuMg+19so9
	o16Ax4ZEfSxDor8v87PT0rebG83qgx9hfjN83z54HAOuUF2F25S2gzqqPt4rbSydYM5lN0Ww3k/
	xRBAUGLlkMUa+a7ZwyOBc0vqa2tOkEJgJRGns5m1zx7OCXgsvWmlSrVIik8QWEkjsjEcOA4oOy0
	g==
X-Received: by 2002:a05:6a20:9f05:b0:3d0:e034:a26f with SMTP id adf61e73a8af0-3dd8c331ce1mr9065318637.17.1789803180426;
        Sat, 19 Sep 2026 00:33:00 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae8eae3sm658733a12.14.2026.09.19.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:32:59 -0700 (PDT)
Date: Sat, 19 Sep 2026 16:32:39 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org, 
	zhangqing@rock-chips.com, royalnet026@gmail.com, abel.vesa@oss.qualcomm.com, 
	sebastian.reichel@collabora.com, u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
Message-ID: <aq41BAp-6P0HMFBB@rock-5b-plus>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>

On Tue, Sep 15, 2026 at 10:43:14PM +1200, Jiaxing Hu wrote:
> This adds the RK3576 NPU to accel/rocket, which today supports RK3588
> only. The RK3576 carries two cores of the same RKNN block, wired up
> differently. Two extra convolution buffer clocks, two power domains per
> core, one reset where the RK3588 has two, no NPU SRAM rail, and a
> PC_TASK_CON that packs the task number into sixteen bits, not twelve.
> 
> 1/14 is Igor Paunovic's "[PATCH v2] accel/rocket: request the core clocks
> by name", carried in the series since v11 so it applies to a plain
> next-20260914 with nothing outside it to follow. It keeps his authorship
> and its four tags, which name RK3588 boards. Everything else here was
> tested on a Radxa ROCK 4D.
> 
> Two things changed since v12: a correction to what 3/14 CLAIMS, and a fix to
> what 3/14 DOES. The first is why this respin exists; the second is a review
> finding on the version I was about to send.
> 
> Igor Paunovic re-ran his induced-reset protocol on v12 as posted and
> found an error in his own reports, which v12's 3/14 carried. His script
> kept the scorer output of every inference per round and never aggregated
> it, and his summaries scored only the one inference after the forced
> autosuspend. Aggregated, the constant-0x80 result is in the rounds of
> nearly every run, on every arm, on all three dates.
> 
> So the all-0x80 buffer is not a differential signal: it is what a job
> cancelled by the reset looks like from userspace, whatever made it miss its
> deadline. 3/14 says why, from the code, and his kprobe on
> drm_sched_fence_finished() is the direct witness.
> 
>   3/14   loses the claim that 19 August showed no manifestation on either
>          arm with the oracle 48/48 throughout, and "one event in 53
>          differential resets against zero in 49" as a bound. His own
>          summary replaces them, quoted as he wrote it, with the caveat
>          that the protocol bounds and does not prove as the last sentence
>          of the quote so that "it" has its referent. His 2026-09-12
>          message is a third Link.
> 
>   3/14   drops "differential base" from its Tested-by comment, and 2/14
>          gains "induced reset, JOB_TIMEOUT_MS=2". 4/14 already read
>          that. All three now say the same thing, which is what he
>          tested: one protocol, three patches, no differential.
> 
>   4/14   loses "45 induced resets across three cores". He corrected that
>          in the same mail: all 45 landed on core 0, the other two being
>          bound but idle in his single client protocol. Nothing else in
>          that patch changes.
> 
> Thirteen of the fourteen diffs are byte for byte what v12 posted. 3/14's is
> not: it is the one code change, four lines of lock scope, described below.
> Two further commit messages moved and neither changes a line of code.
> 9/14 gained the answer below to Sashiko's [High], and corrected its own
> sentence about the twelve rk3576 boards that declare no domain-supply: they
> never reach a first power-on, so the dummy regulator and the dev_warn it
> described do not happen there. 13/14 corrected one number of its own,
> derived from its own table, and dropped a claim about boot-to-boot drift
> that one boot's own spread cannot support.
> 
> This is worth a respin, not a note in the thread: a commit message is the
> permanent record, and v12's states something its own witness has
> retracted.
> 
> And the code change, which is 3/14's own doing. That patch adds two PC
> register writes to rocket_reset() -- masking INTERRUPT_MASK and clearing the
> raw status before synchronize_irq() -- and in v12 they sat outside job_lock.
> rocket_job_hw_submit() arms the same register and always runs under that
> lock; reset.pending is set in rocket_job_timedout() without it and read in
> hw_submit() with it, and both are plain atomics. So a submit that has
> already passed its reset.pending check can re-arm the mask after the reset
> clears it, leaving the block running a task with its interrupt live while
> synchronize_irq() fences a handler that has already finished. The next
> completion then stops a task that has only just started, which is the
> failure 2/14 exists to prevent -- on the other register. In v13 the mask and
> the clear are inside a scoped_guard(mutex, &core->job_lock); the
> synchronize_irq() stays outside it, where it has to be.
> 
> It needs a multi-task job, so hw_submit() is running from the IRQ thread
> rather than the scheduler thread and drm_sched_stop() does not fence it.
> 
> THIS CHANGE POSTDATES IGOR PAUNOVIC'S Tested-by ON 3/14. His runs were
> against the v12 form, outside the lock. The tag is kept because the path and
> the protocol are the same and the change only narrows when the two writes
> may happen, but say if you would rather it were dropped until he has run the
> new one.
> 
> Sashiko reviewed v12 on 12 September, ten mails. No code in v13 answers any
> of it. Three findings are new; the fourth below, on 8/14, is not, and is here
> because it lands on a binding this cover calls Acked and unchanged. The
> answers to all four are arguments rather than changes. The one code change
> in this version came from a different review, and is the next section:
> 
>   4/14  [High] the runtime PM put is asynchronous, and drm_sched_start()
>         at the end of rocket_reset() lets the next job's
>         pm_runtime_resume_and_get() cancel the pending autosuspend.
>         pm_runtime_put_sync_suspend() is suggested. This is the v11
>         finding below with a second mechanism attached.
>   9/14  [High] forcing the NPU parent domain off at probe bypasses the
>         idle sequence for its child domains, risking AXI bus hangs, and
>         can make pm_genpd_add_subdomain() fail. 9/14 had not been
>         reviewed before this.
>   9/14  [Medium] need_regulator is being hijacked to force that
>         power-off, which warns on the boards that declare no
>         domain-supply.
> 
>   8/14  [High] rockchip,rk3568-iommu is called an unsafe fallback for
>         rockchip,rk3576-npu-iommu, because a driver older than the July
>         2026 devm_clk_bulk_get_all change binds the fallback and enables
>         two of the five clocks. That is against a binding this cover
>         calls unchanged since v9 and Acked, so it belongs here and not
>         only in the thread.
> 
> All four have an answer below. Three of them are reasons the finding does
> not stand, one of those being a reason not to make the change suggested.
> The fourth, on 4/14, is incomplete coverage rather than a regression, and
> the change that would close it is offered there for you to choose.
> 
> 9/14's is in the patch. RK3588_PD_NPU has carried need_regulator since it
> was added, with req_mask 0 exactly as RK3576_PD_NPU has, so
> rockchip_pd_power(pd, false) has been running at probe on every rk3588
> board and rockchip_pmu_set_idle_request() has been returning immediately
> because there is no request to make. Of the forty-nine in-tree rk3588 board
> files, twenty-one enable an NPU core and declare the supply, two enable one
> with no supply and take the dummy and the warn today (quartzpro64 and
> youyeetoo-yy3588), and twenty-six enable no core at all, so ->power_on never
> runs there and nothing warns. If the -EINVAL half held,
> rockchip_pm_domain_probe() would fail on all forty-nine. The idle handshake
> lives in the child domains and both SoCs keep it.
> 
> 4/14's outcome is right and the mechanism is not. rpm_resume() does not
> cancel a running autosuspend timer: there is a comment in runtime.c saying
> so, and it only deactivates the timer when timer_autosuspends is clear.
> What defeats the suspend is the usage count, which is 1 once the next job
> has resumed the device, so when the 50 ms timer fires
> rpm_check_suspend_allowed() returns -EAGAIN. The end result is the one
> Sashiko describes: no power-off, so 10/14's reset pulse and 9/14's delay do
> not run.
> 
> The scope is narrower than the finding suggests. drm_sched_start()
> completes the detached jobs with -ECANCELED rather than re-running them, so
> with an empty entity queue nothing takes a new reference and the timer
> fires cleanly, which is what the measurement above shows. The gap opens
> only when a client has a second job queued or resubmits inside 50 ms. That
> is incomplete coverage, not a regression: the patch is still
> strictly better than the pm_runtime_put_noidle() it replaces, which
> requested nothing at all. pm_runtime_put_sync_suspend() would close it, but
> it would run a genpd power-off and a regulator disable under job_lock;
> latching in_flight_job inside the guard and doing the synchronous put after
> it would be cleaner. Say which you would rather have and it goes in the
> next version.
> 
> 8/14's [High] does not stand, and acting on it would take the series with
> it. rk_iommu_dt_ids[] has two entries, rockchip,iommu and
> rockchip,rk3568-iommu, and rockchip,rk3576-iommu and rockchip,rk3588-iommu
> already bind only through that fallback: dropping it leaves the NPU with no
> IOMMU and 12/14 to 14/14 dead. The premise is right, in that before
> 841363ebb508 the driver took only aclk and iface by name. The conclusion is
> not. Every MMIO site in rockchip-iommu.c sits behind
> pm_runtime_get_if_in_use() except rk_iommu_suspend() and rk_iommu_resume(),
> which are the runtime PM callbacks themselves and run only on a resume. On
> such a kernel the device never resumes,
> because the only thing that could wake it is the device link from its master
> and the master compatible rockchip,rk3576-rknn-core is added by 12/14 of this
> series. 841363ebb508's own message says writes to DTE_ADDR are silently
> dropped until the extra clocks run, and reads work: not the hang described.
> 121 in-tree bindings have this shape, a fallback plus a compatible-gated
> clock count, arm,mali-bifrost being the closest.
> 
> 9/14's [Medium] does not stand either. need_regulator exists only in
> pm-domains.c and has two documented meanings there, both pre-existing, and
> the dev_warn it names is a one-line warning from the regulator core in
> ->power_on, not at the probe-time power-off.
> 
> Still open from v11, and the measurement below is the half of it that could
> be measured. pm_runtime_put_autosuspend() is asynchronous with a 50 ms
> delay, so on a workload whose submit gap is shorter the domain does not
> cycle after a reset, 10/14's power-on pulse never fires, and
> rocket_core_reset()'s own resets are all that run. Measured on the domain
> rather than on the device, over one 60.8 s decode of Phi-3.5-mini on a ROCK
> 4D, genpd's npu domain took 46.8 s active and 14.2 s idle, accounting for
> the wall clock to within 0.2 s, and its idle-state usage count rose by 202.
> The domain cycles about two hundred times a minute under a real decode, and
> the pulse fires. Whether it cycles after a timed-out job depends on the gap
> to the next submit, and inducing one needs a kernel with JOB_TIMEOUT_MS
> lowered and a flash, so that half is still an argument.

Hi, Jiaxing

I'm interested in your userspace runtime. As far as I know, There is no
opensource userspace runtime running LLM on rocket driver. Do you have your
private runtime?

Thanks,
Sidong

> 
> 5/14 moves the iommu_detach_group(NULL, iommu_group_get(core->dev)) line
> out of the IRQ handler and into rocket_job_next_locked().
> ZhaoJinming's "accel/rocket: Fix iommu_group leak and unsafe IRQ
> register access" changes the same line and is marked for stable. It
> carries Fixes: 0810d5ad88a1, which is the tag on our 2/14 and 4/14; our
> 5/14 carries no Fixes tag at all. Whichever lands first the other
> conflicts; say which you would rather take.
> 
> Findings Sashiko labelled pre-existing, for Tomeu. These five recur across
> both rounds, and num_cores was raised to Critical on 12/14 in the v12 one.
> One not in the list is worth naming on its own: a 64-bit DMA address
> truncated to 32 bits, which faults the IOMMU above 4 GB.
> 
>   - the job completion path takes iommu_group_get(core->dev) and never
>     puts it, one group reference a job, flagged on seven of the nine
>     mails the v11 round drew.
>     5/14 moves this call without adding or removing it, so the leak
>     is pre-existing but not untouched;
>   - the shared IRQ handler touches registers without checking the PM
>     state;
>   - runtime suspend has no synchronize_irq();
>   - num_cores is used both as an array length and as the probe index;
>   - rdev is leaked through devres on probe deferral.
> 
> One more, not from Sashiko and not touched by this series, found while
> checking 3/14's reasoning. rocket_core_fini() puts core->iommu_group and
> NULLs it BEFORE rocket_job_fini(), which is what cancels the timeout worker
> through drm_sched_fini(). A timeout in that window reaches
> rocket_reset()'s iommu_detach_group(NULL, core->iommu_group) on the stored
> pointer: a NULL dereference, or a use after free if it read the pointer
> just before the store. It needs an unbind or a module unload with a job in
> flight. Moving the cancellation ahead of the put fixes it, and 3/14 adds a
> synchronize_irq() into that same window.
> 
> Still open from v9, no reply since. 9/14 does three things: it adds the
> settle delay, renames a macro, and gives RK3576_PD_NPU a regulator,
> which also makes every RK3576 board force that domain off at probe. I
> asked whether it wants splitting; Abel Vesa's Reviewed-by may be the
> answer, and I would rather split it than have it merged on my silence.
> 13/14 also gives each core both NPU domains, which is the description
> that has been tested here rather than the topology; if it should be one
> domain per core, 6/14's minItems has to change with it.
> 
> The bindings are unchanged since v9 and both checks were re-run for v13
> rather than quoted from then. dt-doc-validate and yamllint are clean on
> all three, with dtschema 2026.6 and yamllint 1.38.0. CHECK_DTBS was run
> from scratch over every rk3576 and rk3588 device tree the Makefile lists, 15
> and 59, and the only complaint is on rk3588-rock-5b-pcie-ep: a
> vpcie3v3-supply that rockchip,rk3588-pcie-ep does not allow. That one is
> present at the base commit with none of this series applied, and nothing
> here touches an rk3588 dts. 13/14 adds a property to a dts and not to a
> binding, and rock-4d is among those targets.
> 
> Applying order, because this series lands in three trees and 14/14 is not
> safe on its own. 09 and 10 go through pmdomain, 01 to 05 and 11 and 12
> through accel, 13 and 14 through rockchip, and 06, 07 and 08 are bindings
> that can go with whichever tree takes the code they describe. 14/14 sets status = "okay" on
> both cores and both MMUs, so a kernel that has the DTS half and the driver
> half but not the pmdomain half powers the domain on with neither 10/14's
> reset pulse nor 09/14's settle delay and reads PC_VERSION into the async
> SError that 07 and 09 describe. That is an unbootable rock-4d, not a
> degraded feature. 14/14 depends on 09, 10, 12 and 13; the other
> intermediates are safe, since 13/14 alone leaves every node disabled, 11
> and 12 alone add no DT nodes, and 10 alone is inert because no in-tree
> power-domain node carries resets until 13/14. 09 alone is the one that does
> something: giving RK3576_PD_NPU need_regulator makes
> rockchip_pm_add_one_domain() power that domain off at probe on all thirteen
> in-tree rk3576 boards, with or without the rest of the series. 09/14 argues
> that is deliberate and why; it is not a state nothing reaches.
> Holding 14/14 a cycle is fine by me if that is easier than coordinating.
> 
> An index of what this series needs decided, each argued where it is raised:
> 
>   4/14   the shape of the fix, if you want one
>   5/14   ours or ZhaoJinming's; whichever lands first the other conflicts
>   9/14   whether it splits, and the macro suffix scheme it asks about
>   13/14  both NPU domains per core, as tested, or one
>   --     the rocket_core_fini() ordering bug: here or on its own
>   14/14  hold it a cycle, or coordinate the three trees
> 
> Link to v12: https://lore.kernel.org/all/20260912065053.1519165-1-gahing@gahingwoo.com/
> 
> The tags:
> 
>   2/14   Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, JOB_TIMEOUT_MS=2
>   3/14   Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, JOB_TIMEOUT_MS=2
>   4/14   Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, JOB_TIMEOUT_MS=2
>   5/14   Reviewed-by: Igor Paunovic
>   6/14   Reviewed-by: Krzysztof Kozlowski
>   7/14   Acked-by: Conor Dooley
>   8/14   Acked-by: Conor Dooley
>   9/14   Reviewed-by: Abel Vesa
>   10/14  Reviewed-by: Abel Vesa
> 
> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
> 
> Jiaxing Hu (13):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
> 
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 151 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  83 +++++++---
>  12 files changed, 456 insertions(+), 63 deletions(-)
> 
> 
> base-commit: 1a1de54f7369cd2b5bac0f265910e60ad3a6b4c3
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
