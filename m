From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: 2.6.31-rc2+: Interrupts enabled after cpufreq_suspend
Date: Sat, 11 Jul 2009 16:33:13 +0200
Message-ID: <4A58A2A9.7020707__40203.959917608$1247322873$gmane$org@gmail.com>
References: <4A561074.5080407@gmail.com> <20090710192511.GB6240@redhat.com>
	<20090710201308.GA11075@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090710201308.GA11075@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>, Marcin Slusarz <marcin.slusarz@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Dave Jones wrote:
> On Fri, Jul 10, 2009 at 03:25:11PM -0400, Dave Jones wrote:
> 
>  >     [PATCH] Add suspend method to cpufreq core
>  >     
>  >     In order to properly fix some issues with cpufreq vs. sleep on
>  >     PowerBooks, I had to add a suspend callback to the pmac_cpufreq driver.
>  >     I must force a switch to full speed before sleep and I switch back to
>  >     previous speed on resume.
>  > 
>  > 
>  > Ben, is there something better we can do here ?
>  > 
>  > I really don't want to add an #ifdef __powerpc__ to core code if we can help it.
>  > I'd rather we didn't call into driver guts at all from the suspend path.
> 
> Marcin,
>  Unless we get a better solution proposed, try running with this, which just
> skips doing all that code entirely.

Now it produces only:
powernow-k8: error - out of sync, fix 0x2 0xc, vid 0x12 0x6
(arch/x86/kernel/cpu/cpufreq/powernow-k8.c: powernowk8_target)
but works fine.

If it's nothing to worry about, you can add:
Tested-by: Marcin Slusarz <marcin.slusarz@gmail.com>

Thanks,
Marcin
