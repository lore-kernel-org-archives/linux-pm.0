From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 12:09:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707121206240.25614@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<1184251423.9346.55.camel@caritas-dev.intel.com>
	<m14pk9fuqa.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m14pk9fuqa.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Eric W. Biederman wrote:

>> 2. Do not reserve memory for kexec kernel. That is, backup needed memory
>> before kexec and restore them after kexec.
>> 3. Support the in-place kexec? The relocatable kernel is not necessary
>> if this can be implemented.
>
> It sounds like what you really want is the normal kexec path enhanced
> so that you can return to the kernel you started with.
>
> The normal kexec path already knows how to do the memory shuffle so
> it can do on demand memory allocation.  That code just needs to
> enhanced slightly so that you allocate an extra page, setup an inverse
> scatter gather list for restoring the pages, and teach relocate_kernel.S
> to preserve it's destination pages by using the inverse scatter gather
> list.
>
> The normal kexec path already calls device_shutdown and the like to
> stop devices from running.  Although again that code path is not
> prepared to restore the devices.

we shouldn't need a restore code path if the new kernel re-detects 
everything. if kexec already shuts down all the devices we may not need to 
implement anything new here (although there may be room for future 
performance optimization)

> ...
>
> For prototyping I would:
> - reserve a chunk of memory (possibly with the crashkernel= option)
>  and run a relocatable kernel out of it.
>
>  By using the normal kexec you can boot a relocatable restore kernel
>  in that reserved region. It is an extra step but it makes things
>  work today.
>
> - I would use the normal sys_kexec_load.
>
> - I would debug/tweak the user space and the code to reenter the
>  old kernel.  I.e. the device driver stop/start code.
>
>  Once it was basically working I would the update normal kexec
>  memory copy code in relocate.S to preserve the destination pages.

for prototyping there's no need to use the same kernel.

>> 4. Image writing/reading. (Only user space application is needed).
>
> And possibly a few fixes to /dev/mem.  This is pretty much the same
> process as generating a core dump so there should be some synergy with that.

what fixes are you thinking of?

you are makeing this sound very simple ;-)

David Lang
