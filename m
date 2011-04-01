From: Andreas Herrmann <andreas.herrmann3@amd.com>
Subject: Re: [PATCH 9/9] x86 idle: delete mwait_idle()
Date: Fri, 1 Apr 2011 13:02:43 +0200
Message-ID: <20110401110243.GN11175__24456.5082401552$1301676794$gmane$org@alberich.amd.com>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>
	<9797d1edfe558e20297785ce5b4e26339b74ea2c.1301550524.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9797d1edfe558e20297785ce5b4e26339b74ea2c.1301550524.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 31, 2011 at 02:03:24AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> For ACPI mode, mwait_with_hints() in cstate.c is used instead of
> process.c's mwait_idle().
> 
> For INTEL_IDLE mode, the mwait in intel_idle() is used instead of
> process.c's mwait_idle().
> 
> So delete process.c's mwait_idle().
> This will change the behaviour of SMP sysgtems that are
> running !ACPI and !INTEL_IDLE kernels -- they will use
> HALT instead of MWAIT.
> 
> This deletes the "idle=mwait" parameter, and thus the
> boot_option_idle_override == IDLE_FORCE_MWAIT flag.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Andreas Herrmann <andreas.herrmann3@amd.com>


Regards,
Andreas
