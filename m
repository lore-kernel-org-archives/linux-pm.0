From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 23:34:40 +0200
Message-ID: <200707202334.41665.rjw@sisk.pl>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<40fa2626aff7b6b590ad6aa4737fc873@bga.com>
	<1184942918.13737.23.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184942918.13737.23.camel@caritas-dev.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 20 July 2007 16:48, Huang, Ying wrote:
> On Fri, 2007-07-20 at 09:01 -0500, Milton Miller wrote:
> > Simplifying kjump: the proposal for v3.
> > 
> > The current code is trying to use crash dump area as a safe, reserved 
> > area to run the second kernel.   However, that means that the kernel 
> > has to be linked specially to run in the reserved area.   I think we 
> > need to finish separating kexec_jump from the other code paths.
> > 
> > (1) add a new command line argument that specifies the kexec_jump 
> > target area (or just size?)
> > 
> > (2) add a kjump flag to the flags parameter, used by kexec_load.   When 
> > loading a jump kernel, it is loaded like a normal kernel, however, 
> > additional control pages are allocated to (a) save this kenrel's use of 
> > the kexec_jump target area (b) save the backed up region that is used 
> > by all kernels like crash dump, and (c) space for invoking 
> > relocate_new_kernel that will get its args from the execution entry 
> > point and will restore the kernel then call resume and suspend.
> 
> Backuping target memory before kexec and restoring it after kexec is
> planed feature for kexec jump. But I will work on image writing/reading
> first.

Have you thought about using any existing code, when you're at it?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
