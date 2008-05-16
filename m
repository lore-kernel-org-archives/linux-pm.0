From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 21:51:42 -0400
Message-ID: <20080516015142.GB6926__14951.9823877656$1210902935$gmane$org@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210818762.23707.102.camel@caritas-dev.intel.com>
	<20080515200923.GC9718@redhat.com>
	<1210902514.23707.161.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1210902514.23707.161.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 16, 2008 at 09:48:34AM +0800, Huang, Ying wrote:
> On Thu, 2008-05-15 at 16:09 -0400, Vivek Goyal wrote:
> [...]
> > Ok, You want to make BIOS calls. We already do that using vm86 mode and
> > use bios real mode interrupts. So why do we need this interface? Or, IOW,
> > how is this interface better?
> 
> It can call code in 32-bit physical mode in addition to real mode. So It
> can be used to call EFI runtime service, especially call EFI 64 runtime
> service under 32-bit kernel or vice versa.
> 
> The main purpose of kexec jump is for hibernation. But I think if the
> effort is small, why not support general 32-bit physical mode code call
> at same time.
> 

In general what's the environment requirements for EFI runtime 
services? I mean, just that processor should be in protected mode with
paging disabled or one need to stop all other cpus and devices and then make
the call (as we are doing in this case?). 

Thanks
Vivek
