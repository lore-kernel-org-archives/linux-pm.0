From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 08:48:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707200845200.19248@asgard.lang.hm>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<200707172217.01890.rjw@sisk.pl> <87odiag45q.fsf@jbms.ath.cx>
	<200707151433.34625.rjw@sisk.pl> <200707172320.16279.rjw@sisk.pl>
	<40fa2626aff7b6b590ad6aa4737fc873@bga.com>
	<1184942918.13737.23.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184942918.13737.23.camel@caritas-dev.intel.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007, Huang, Ying wrote:

> 
> On Fri, 2007-07-20 at 09:01 -0500, Milton Miller wrote:
>> Simplifying kjump: the proposal for v3.
>>
>> The current code is trying to use crash dump area as a safe, reserved
>> area to run the second kernel.   However, that means that the kernel
>> has to be linked specially to run in the reserved area.   I think we
>> need to finish separating kexec_jump from the other code paths.
>>
>> (1) add a new command line argument that specifies the kexec_jump
>> target area (or just size?)
>>
>> (2) add a kjump flag to the flags parameter, used by kexec_load.   When
>> loading a jump kernel, it is loaded like a normal kernel, however,
>> additional control pages are allocated to (a) save this kenrel's use of
>> the kexec_jump target area (b) save the backed up region that is used
>> by all kernels like crash dump, and (c) space for invoking
>> relocate_new_kernel that will get its args from the execution entry
>> point and will restore the kernel then call resume and suspend.
>
> Backuping target memory before kexec and restoring it after kexec is
> planed feature for kexec jump. But I will work on image writing/reading
> first.

if we can get a list of what memory is safe to backup/restore then the 
reading/writing of the image should be able to be done in userspace.

>> (3) replace jump_huf_pfn with two command line addresses that specify
>> the (a) return point for after resume, and (b) the return point for
>> after image save.   Actually these can be done in userspace; the second
>> restore kernel can just specify the null copy list and the entry points
>> supplied by the suspended kernel.  To do resume we also need (c) where
>> to store resume address for the save kernel.
>
> There is many free spaces in jump_buf_pfn page now. I think passing the
> needed information through jump_buf_pfn is more convenient than through
> kernel command line. That is, the jump_buf_pfn can be seen as a meta
> interface, which is passed to kexeced kernel though command line, while
> other information can be passed though jmp_buf_pfn.



>> The seperation should be whoever builds a scatter copy list builds the
>> inverse list.  This is why I propose simple jump entry points.  I
>> expect just a few instructions to establish arguments for the call to
>> the exstinging relocate_new_kernel code.
>
> If the "scatter copy" is replaced by "scatter swap", we need not the
> inverse list, and the state of kexeced kernel can be backuped too. There
> are "scatter copy" support in normal kexec implementation in
> "relocate_kernel".

what do you mean by "scatter swap"?

David Lang
