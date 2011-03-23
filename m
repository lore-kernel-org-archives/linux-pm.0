From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 2/2 2.6.37.stable] intel_idle:
 disable Atom/Lincroft HW C-state auto-demotion
Date: Wed, 23 Mar 2011 15:55:29 -0700
Message-ID: <20110323225529.GF27334__27292.559881653$1300922254$gmane$org@kroah.com>
References: <alpine.LFD.2.02.1103222222490.10489@x980>
	<alpine.LFD.2.02.1103222224530.10489@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103222224530.10489@x980>
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
Cc: linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 22, 2011 at 10:26:59PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> upstream bfb53ccf1c734b1907df7189eef4c08489827951
> 
> Just as we had to disable auto-demotion for NHM/WSM,
> we need to do the same for Atom (Lincroft version).
> 
> In particular, auto-demotion will prevent Lincroft
> from entering the S0i3 idle power saving state.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=25252
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

This one also doesn't apply to the .38 tree, can you provide a copy of
it as well?

thanks,

greg k-h
