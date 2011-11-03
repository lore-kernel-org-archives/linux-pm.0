From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/3 v3] ARM: EXYNOS4: Support for generic I/O
 power domains on EXYNOS4210/4212
Date: Thu, 03 Nov 2011 11:24:34 +0100
Message-ID: <4EB26BE2.2060508__13852.9128431857$1320315890$gmane$org@samsung.com>
References: <4EA690EF.4000703@samsung.com>
	<013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Sylwester Nawrocki' <snjw23@gmail.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Kgene,

On 11/03/2011 03:09 AM, Kukjin Kim wrote:
> As I said, I don't think we should control/gate the clocks with regarding power domain. 

As far as I know there is a plan to let the drivers override start/stop_device callbacks,
moreover the clock control can be disabled globally by not implementing start/stop_device
callbacks or per device by not adding clkdev entities to the device clock list at runtime 
PM core. So IMHO, there is/going to be enough flexibility.

> It should be controlled by each regarding device driver and in addition, as I know,
> to handle block of clock is not recommended on EXYNOS4 now.

What do you mean by this ? I couldn't find such information in any documentation.
Shouldn't "clock gate block" registers be touched by boot loader and the kernel?
Our boot loaders disable all clocks, and if the global clock gate is not enabled
by the kernel there is no chance any multimedia device will work.

Should the global clock block gate be always enabled then ? I'm afraid it is not
optimal form power management POV.

-- 
Thanks,
Sylwester
