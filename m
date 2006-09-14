From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: cpufreq terminally broken [was Re: community PM
	requirements/issues and PowerOP]
Date: Thu, 14 Sep 2006 09:30:33 +0400
Message-ID: <acd2a5930609132230u2e8fff88gc172da2504c854de@mail.gmail.com>
References: <450516E8.9010403@gmail.com>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
	<20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	<20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	<20060911225617.GB13474@elf.ucw.cz>
	<20060912001701.GC14234@linux.intel.com>
	<20060912033700.GD27397@kroah.com>
	<b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9/14/06, David Singleton <daviado@gmail.com> wrote:

> OpPoint constructs operating points for all supported frequency, voltage
> and suspend states for PC and SoC solutions running Linux.

...producing very hard-to-manage and long-to-search lists (did you
consider using trees for that BTW?)
Also, you'll have to maintain different lists for differemt
modifications of the same SoC. That will complicate the code prety
much.

> (The ARM pxa27x patch uses the cpufreq scaling routines to scale the LCD
> when frequencies are changed and works well when playing mpeg movies on
> the LCD during frequency scaling operations).

PXA is a hi-end stuff for embedded, so that might be not very illustrative.

> The Operating Points in OpPoint are simply created at compile time, in
> the same manner cpufreq tables are, and registered in
> /sys/power/operating_states directory when the cpu is identified at boot =
time.

So do you say there's no *kernel* interface to create OPs even?
Assume you've got a device which needs scaling and which driver may be
compiled as a module. Thus, you'll have to include OPs that reflect
this driver's clock scaling at the kernel compile time. Which is
nonsense in a way because the clock itself should be switched on
during probe() operation of the device driver.

> OpPoint draws the line about what's needed in the kernel a bit differently
> than Matt's PowerOp code.  OpPoint only puts operating point support in
> the kernel.  Polices for operting states and classes of operating states
> are left to the power manager, in userland.  This simplifies the
> kernel code, no string parsers for operating point parameter construction,
> and makes it easier to customize a solution by customizing the power
> manager.

That sounds nice :)

> OpPoint is a fully functional solution ready for testing and evaluation
> in Andrew's or your tree.

Can you please list the SoCs which this solution has been tested on?

Thanks,
   Vitaly
