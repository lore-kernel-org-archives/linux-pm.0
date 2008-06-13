From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm 1/2] kexec jump -v11: kexec jump
Date: Fri, 13 Jun 2008 09:04:00 +0800
Message-ID: <1213319040.20431.8.camel__8528.32554742253$1213319081$gmane$org@caritas-dev.intel.com>
References: <1213082104.22608.29.camel@caritas-dev.intel.com>
	<20080612192015.GH9654@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080612192015.GH9654@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2008-06-12 at 15:20 -0400, Vivek Goyal wrote:
> On Tue, Jun 10, 2008 at 03:15:04PM +0800, Huang, Ying wrote:
> > This patch provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Backup/restore memory used by the original kernel before/after
> >   kexec.
> > 
> > - Save/restore CPU state before/after kexec.
> > 
> > The features of this patch can be used as a general method to call
> > program in physical mode (paging turning off). This can be used to
> > call BIOS code under Linux.
> > 
> > 
> 
> Hi Huang,
> 
> I was testing these patches and I get following error on my machine.
> 
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: Device i8042 failed to freeze: error -22
> Restarting tasks ... done.
> 
> Any idea why keyboard controller would not freeze?

Which kernel version do you use?

Does original hibernation work? It can be setup easily. Just add
following parameters to kernel command line:

resume=/dev/<xxx>

Where <xxx> is the swap partition.

And execute following command:

echo reboot > /sys/power/disk
echo disk > /sys/power/state

Best Regards,
Huang Ying
