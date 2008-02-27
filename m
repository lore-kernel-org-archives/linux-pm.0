From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: broken suspend to ram with velocity driver
Date: Wed, 27 Feb 2008 13:08:20 +0000
Message-ID: <20080227130819.GA28528__15510.8551415198$1204117822$gmane$org@srcf.ucam.org>
References: <20080224162309.3e67dd22.sfr@canb.auug.org.au>
	<47C1B52B.3080104@gmail.com> <200802242100.46474.rjw@sisk.pl>
	<47C1FF2E.4060600@gmail.com> <20080225092628.GA493@elf.ucw.cz>
	<47C35C53.5010609@gmail.com> <20080226214950.GD10280@elf.ucw.cz>
	<47C4AEB7.1030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47C4AEB7.1030404@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Winchester <kjwinchester@gmail.com>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 26, 2008 at 08:28:39PM -0400, Kevin Winchester wrote:
> I haven't done too much looking at what the tool on that site does,
> but I was under the impression that I should be able to do:
> 
> echo mem > /sys/power/state
> 
> and then bring the system back up and have it work.  

Not if you want video to come back on most hardware - the kernel has no 
idea how to reinitialise your graphics card. s2ram and similar tools 
attempt to deal with this by reprogramming it from userspace. On the 
other hand, if it did work on the same hardware with earlier kernels, 
then that's a bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
