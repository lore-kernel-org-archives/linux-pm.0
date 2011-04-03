From: Borislav Petkov <borislav.petkov@amd.com>
Subject: Re: [PATCH 07/18] x86 idle: clarify AMD erratum 400
	workaround -v2
Date: Sun, 3 Apr 2011 11:00:43 +0200
Message-ID: <20110403090043.GA4315__35602.1713502288$1301940136$gmane$org@aftab>
References: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
	<68477f71a39cd0ba9acd40e94e49969cbe1bec79.1301724243.git.len.brown@intel.com>
	<20110402082316.GA21804@liondog.tnic>
	<alpine.LFD.2.02.1104021442460.18682@x980>
	<alpine.LFD.2.02.1104021521330.18682@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1104021521330.18682@x980>
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
Cc: Len Brown <len.brown@intel.com>, "Rosenfeld, Hans" <Hans.Rosenfeld@amd.com>, "Herrmann3, Andreas" <Andreas.Herrmann3@amd.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 02, 2011 at 03:22:39PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The workaround for AMD erratum 400 uses the term "c1e" falsely suggesting:
> 1. Intel C1E is somehow involved
> 2. All AMD processors with C1E are involved
> 
> Use the string "amd_c1e" instead of simply "c1e" to clarify that
> this workaround is specific to AMD's version of C1E.
> Use the string "e400" to clarify that the workaround is specific
> to AMD processors with Erratum 400.
> 
> This patch is text-substitution only, with no functional change.
> 
> cc: x86@kernel.org
> cc: Hans Rosenfeld <hans.rosenfeld@amd.com>
> cc: Andreas Herrmann <andreas.herrmann3@amd.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

Looks good, thanks.

Acked-by: Borislav Petkov <borislav.petkov@amd.com>

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Gemeinde Aschheim, Landkreis Muenchen
Registergericht Muenchen, HRB Nr. 43632
