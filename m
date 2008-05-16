From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 20:51:21 -0400
Message-ID: <20080516005121.GA6926__10232.1749240675$1210899550$gmane$org@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1210830110.23707.141.camel@caritas-dev.intel.com>
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

On Thu, May 15, 2008 at 01:41:50PM +0800, Huang, Ying wrote:
> Hi, Vivek,
> 
> On Wed, 2008-05-14 at 16:52 -0400, Vivek Goyal wrote:
> [...]
> > Ok, I have done some testing on this patch. Currently I have just
> > tested switching back and forth between two kernels and it is working for
> > me.
> > 
> > Just that I had to put LAPIC and IOAPIC in legacy mode for it to work. Few
> > comments/questions are inline.
> 
> It seems that for LAPIC and IOAPIC, there is
> lapic_suspend()/lapic_resume() and ioapic_suspend()/ioapic_resume(),
> which will be called before/after kexec jump through
> device_power_down()/device_power_up(). So, the mechanism for
> LAPIC/IOAPIC is there, we may need to check the corresponding
> implementation.
> 

ioapic_suspend() is not putting APICs in Legacy mode and that's why
we are seeing the issue. It only saves the IOAPIC routing table entries
and these entries are restored during ioapic_resume().

But I think somebody has to put APICs in legacy mode for normal 
hibernation also. Not sure who does it. May be BIOS, so that during
resume, second kernel can get the timer interrupts.

Thanks
Vivek
