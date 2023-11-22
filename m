Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA268112;
	Wed, 22 Nov 2023 12:51:19 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
	id 75B8148F4A; Wed, 22 Nov 2023 12:51:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7503D48F41;
	Wed, 22 Nov 2023 12:51:19 -0800 (PST)
Date: Wed, 22 Nov 2023 12:51:19 -0800 (PST)
From: Christoph Lameter <cl@linux.com>
To: Mihai Carabas <mihai.carabas@oracle.com>
cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, 
    mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
    pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com, 
    rafael@kernel.org, daniel.lezcano@linaro.org, akpm@linux-foundation.org, 
    pmladek@suse.com, peterz@infradead.org, dianders@chromium.org, 
    npiggin@gmail.com, rick.p.edgecombe@intel.com, joao.m.martins@oracle.com, 
    juerg.haefliger@canonical.com, mic@digikod.net, arnd@arndb.de, 
    ankur.a.arora@oracle.com
Subject: Re: [PATCH 7/7] cpuidle/poll_state: replace cpu_relax with
 smp_cond_load_relaxed
In-Reply-To: <1700488898-12431-8-git-send-email-mihai.carabas@oracle.com>
Message-ID: <6bd5fd43-552d-b020-1338-d89279f7a517@linux.com>
References: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com> <1700488898-12431-8-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mon, 20 Nov 2023, Mihai Carabas wrote:

> cpu_relax on ARM64 does a simple "yield". Thus we replace it with
> smp_cond_load_relaxed which basically does a "wfe".

Well it clears events first (which requires the first WFE) and then does a 
WFE waiting for any events if no events were pending.

WFE does not cause a VMEXIT? Or does the inner loop of 
smp_cond_load_relaxed now do 2x VMEXITS?

KVM ARM64 code seems to indicate that WFE causes a VMEXIT. See 
kvm_handle_wfx().
