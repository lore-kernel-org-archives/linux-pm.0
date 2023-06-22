Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A5EB64D8
	for <linux-pm@archiver.kernel.org>; Thu, 22 Jun 2023 05:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFVFk7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Jun 2023 01:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjFVFk6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2023 01:40:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888181997;
        Wed, 21 Jun 2023 22:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1557161760;
        Thu, 22 Jun 2023 05:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC473C433C8;
        Thu, 22 Jun 2023 05:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687412456;
        bh=oIPcrom9RqnsniQYSNMgR+p6MdFu/DtvKCZ1Np/Z/MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOU8ZhlcoAkP8nqsDOygni2780rD+fJLmpvx9N/Vp+lrGl6qxSUs+Dqjaava1gJLe
         gbaqREU6LCg8yTR9Dzt+cDe/3OlcSaOYmyMQ5n9Hh0tLBfQiMP9D1sqMcPCh0KU1oh
         z0r+2hj+Flc/onfvY8jaWBtlJnVQNWtinrObH18jHAxb+61/fgGqNh2p97HDJcdLtx
         gyDTuGt2vDO8HlXtXOn9pcKrEyvI7Rp/tI7rV4dsCKilSf+/fb80BFSa051x3zZJN9
         G8eQq0iDri2O4c9PoeYvpZVFq0Paw97AcxT/hMJr0vNVayRXN1fYWdIHbhi/ONe7lj
         rXfeCGbgGmiTw==
Date:   Wed, 21 Jun 2023 22:40:53 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v3 1/3] x86/idle: Disable IBRS when cpu is offline
Message-ID: <20230622054053.uy577qezu5a65buc@treble>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230622003603.1188364-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 21, 2023 at 08:36:01PM -0400, Waiman Long wrote:
> +/*
> + * naitve_play_dead() is essentially a __noreturn function, but it can't
> + * be marked as such as the compiler may complain about it.
> + */

FWIW, we could in theory do so by marking the smp_ops.play_dead function
pointer as __noreturn, but it would be tricky to teach objtool how to
understand that.

>  void native_play_dead(void)
>  {
> +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
> +		this_cpu_write(x86_spec_ctrl_current, 0);
> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +	}

Can update_spec_ctrl() be used instead?

-- 
Josh
