From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 14:23:02 -0800
Message-ID: <5696CE46.1000802@zytor.com>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <alpine.DEB.2.11.1601131042590.3575@nanos> <20160113082113.3314fa92@icelake>
 <20160113163610.GH12897@pd.tnic> <20160113095124.186ff487@yairi>
 <20160113180412.GN12897@pd.tnic> <20160113102138.4e34e890@yairi>
 <20160113191622.GP12897@pd.tnic> <20160113121003.3e9c2108@yairi>
 <20160113212602.GT12897@pd.tnic> <1452722083.3092.92.camel@linux.intel.com>
 <alpine.DEB.2.11.1601132257550.3575@nanos> <20160113141115.59535b45@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113141115.59535b45@yairi>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 01/13/16 14:11, Jacob Pan wrote:
>
> The balance of pros and cons depends on the number of occurrence. The
> lib call overhead is constant where saving from the callers are
> multiplied. Anyway, I will go back to my original code until we have
> enough callers to tip the balance.
> 

The thing about premature librarization is that it can cause very
unnatural code to end up being written.  Until it is clear what the APIs
we actually need are, we shouldn't force them into a mold.  Of course,
it often makes sense to make these *local* APIs that, if useful, can get
globalized.

	-hpa
