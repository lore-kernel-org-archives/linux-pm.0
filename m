From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/5] cpuidle: replace xen access to x86
	pm_idle and default_idle
Date: Wed, 03 Aug 2011 15:35:40 -0700
Message-ID: <4E39CD3C.8010801__7119.00754035941$1312411004$gmane$org@zytor.com>
References: <1312400648-17636-1-git-send-email-lenb@kernel.org>
	<0c70c6b12c37ececbfa9b7734495835514f273a4.1312400543.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <0c70c6b12c37ececbfa9b7734495835514f273a4.1312400543.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/03/2011 12:44 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> When a Xen Dom0 kernel boots on a hypervisor, it gets access
> to the raw-hardware ACPI tables.  While it parses the idle tables
> for the hypervisor's beneift, it uses HLT for its own idle.
> 
> Rather than have xen scribble on pm_idle and access default_idle,
> have it simply disable_cpuidle() so acpi_idle will not load and
> architecture default HLT will be used.
> 
> cc: xen-devel@lists.xensource.com
> Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/xen/setup.c      |    3 ++-
>  drivers/cpuidle/cpuidle.c |    4 ++++
>  include/linux/cpuidle.h   |    2 ++
>  3 files changed, 8 insertions(+), 1 deletions(-)
> 

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
