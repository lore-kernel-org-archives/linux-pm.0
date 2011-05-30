From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 5/8] x86 idle floppy: deprecate
	disable_hlt()
Date: Mon, 30 May 2011 17:24:54 +0800
Message-ID: <20110530092454.GC11601__35311.33833244$1306748062$gmane$org@kroah.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
	<3b70b2e5fcf6315eb833a1bcc2b810bdc75484ff.1306662035.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3b70b2e5fcf6315eb833a1bcc2b810bdc75484ff.1306662035.git.len.brown@intel.com>
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

On Sun, May 29, 2011 at 05:41:47AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Plan to remove floppy_disable_hlt in 2012, an ancient
> workaround with comments that it should be removed.
> 
> This allows us to remove clutter and a run-time branch
> from the idle code.
> 
> WARN_ONCE() on invocation until it is removed.
> 
> cc: x86@kernel.org
> cc: stable@kernel.org # .39.x

What?  We don't do this for stable kernels, do we?  I can't ever
remember doing it before, and I really don't want to start doing it now,
sorry.

greg k-h
