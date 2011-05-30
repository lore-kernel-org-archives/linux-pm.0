From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 8/8] x86 idle: deprecate
 mwait_idle() and "idle=mwait" cmdline param
Date: Mon, 30 May 2011 17:25:47 +0800
Message-ID: <20110530092547.GE11601__41110.6761581779$1306748179$gmane$org@kroah.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
	<5d4c47e0195b989f284907358bd5c268a44b91c7.1306662035.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d4c47e0195b989f284907358bd5c268a44b91c7.1306662035.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, May 29, 2011 at 05:41:50AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> mwait_idle() is a C1-only idle loop intended to be more efficient
> than HLT on SMP hardware that supports it.
> 
> But mwait_idle() has been replaced by the more general
> mwait_idle_with_hints(), which handles both C1 and deeper C-states.
> ACPI uses only mwait_idle_with_hints(), and never uses mwait_idle().
> 
> Deprecate mwait_idle() and the "idle=mwait" cmdline param
> to simplify the x86 idle code.
> 
> After this change, kernels configured with
> (!CONFIG_ACPI=n && !CONFIG_INTEL_IDLE=n) when run on hardware
> that support MWAIT will simply use HLT.  If MWAIT is desired
> on those systems, cpuidle and the cpuidle drivers above
> can be used.
> 
> cc: x86@kernel.org
> cc: stable@kernel.org # .39.x

Also not going to apply this one.

greg k-h
