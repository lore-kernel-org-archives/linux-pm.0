From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5/5] cpuidle: stop depending on pm_idle
Date: Wed, 03 Aug 2011 15:36:19 -0700
Message-ID: <4E39CD63.409__42619.2283900038$1312411050$gmane$org@zytor.com>
References: <1312400648-17636-1-git-send-email-lenb@kernel.org>
	<619b3f9e65307529dd4bbc98efe9d2f3b632646c.1312400543.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <619b3f9e65307529dd4bbc98efe9d2f3b632646c.1312400543.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/03/2011 12:44 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> cpuidle users should call cpuidle_call_idle() directly
> rather than via (pm_idle)() function pointer.
> 
> Architecture may choose to continue using (pm_idle)(),
> but cpuidle need not depend on it:
> 
>   my_arch_cpu_idle()
> 	...
> 	if(cpuidle_call_idle())
> 		pm_idle();
> 
> cc: x86@kernel.org
> cc: Kevin Hilman <khilman@deeprootsystems.com>
> cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
