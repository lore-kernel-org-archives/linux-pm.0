From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: another software suspend issue,
	seems to be caused by i915/KMS
Date: Sun, 1 Aug 2010 17:52:38 +0200
Message-ID: <201008011752.38959.rjw__19479.6644537293$1280678061$gmane$org@sisk.pl>
References: <i33g00$ros$1@dough.gmane.org>
	<201008011626.23440.rjw__44091.8515356772$1280673174$gmane$org@sisk.pl>
	<20100801154206.47ECB18DF72@ogre.sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100801154206.47ECB18DF72@ogre.sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Willi Mann <foss-ml@wm1.at>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, August 01, 2010, Willi Mann wrote:
> Rafael J. Wysocki wrote:
> 
> > On Sunday, August 01, 2010, Willi Mann wrote:
> >> Hi!
> >> 
> >> On my Thinkpad T500 with Debian-compiled kernel
> >> 2.6.35~rc6-1~experimental.1, I still get OOpses on suspend.
> > 
> > Did it happen with 2.6.34 or previous kernels?
> 
> Yes, the suspend/resume also failed with 2.6.34, although I only tried 
> suspending from X, which almost always leads to a blank screen, so I can't 
> say whether the symptoms are the same. Of course I can test that if you 
> think this is useful. However, rc5 and rc6 contained a fix for i915 related 
> to suspend/resume, which might hide this remaining problem. So it might not 
> be particularly useful to test 2.6.34.
> 
> As far as I remember, KMS always led to problems related to suspend/resume, 
> but the both the highly patched Debian Kernel 2.6.32-18 (Debian version) and 
> 2.6.35-rc6 fail very often on suspend. I'd like to avoid testing earlier 
> 2.6.32 kernels, because some of them even cause file system corruption on 
> suspend. (If really required, I could set up a small test partition, and 
> hope that the filesystem corruption was no arbitrary write on the disk, but 
> only on the partition.)
> 
> The last time I had no problems with suspend/resume was with some kernel 
> 2.6.29 version, which of course used User Mode Setting. I actually didn't 
> cold-boot my notebook for 180 days back then.

Thanks for the reply, but please keep the CC list when replying next time.

Rafael
