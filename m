From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [git pull 2.6.36.stable] intel_idle patches
 for 2.6.36.stable
Date: Mon, 22 Nov 2010 10:45:59 -0800
Message-ID: <20101122184559.GA10879__18371.5929896154$1290451726$gmane$org@kroah.com>
References: <alpine.LFD.2.00.1011151227190.2939@x980>
	<alpine.LFD.2.00.1011170322270.24426@x980>
	<alpine.LFD.2.00.1011170331150.24426@x980>
	<alpine.LFD.2.00.1011221318230.19247@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1011221318230.19247@x980>
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
Cc: linux-pm@lists.linux-foundation.org, stable@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 22, 2010 at 01:36:31PM -0500, Len Brown wrote:
> Hi Greg,
> 
> I retract my intel_idle pull requests for .stable
> 
> The idle-release branches in...
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/
> 	linux-idle-2.6.32.git
> 	linux-idle-2.6.35.git
> 	linux-idle-2.6.36.git
> 
> are for distros and others that want to run the latest intel_idle
> driver on the specified release.  The backports in these trees
> contain every upstream patch that touch the driver, including new
> platform support and any dependent cosmetic patches.
> 
> So they are optimized for the maintenance task of comparing
> the backport versus the upstream driver to verify the release
> includes everything that is upstream.
> However, as it does not exclude cosmetic or trivial patches,
> the backports do not qualify for inclusion in .stable.
> 
> Sorry to bother you.

No problem at all, glad to see you change your mind :)

thanks,

greg k-h
