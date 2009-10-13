From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: Hibernation out-of-memory problem.
Date: Tue, 13 Oct 2009 21:25:13 +0200
Message-ID: <4AD4D419.9000302@vmware.com>
References: <4AD0F4D0.2090809@vmware.com> <200910122317.59973.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910122317.59973.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday 10 October 2009, Thomas Hellstrom wrote:
>   
>> Hi!
>>
>> I'm trying to port a graphics DRM device driver over to the new power 
>> management hooks in
>>
>> struct dev_pm_ops.
>>
>> During the "prepare" call, Video RAM contents may be copied either to 
>> shmem objects or pages allocated using alloc_page().
>> Unfortunately, this seems to lead to the hibernation process running out 
>> of free pages.
>>
>> One possible cause is that the function swsusp_shrink_memory() is called 
>> before the prepare() call, and therefore doesn't free up enough memory.
>>
>> What would be the correct way around this? Should swsusp_shrink_memory() 
>> be moved to after prepare(), or is it possible to get some kind of 
>> notification after user space processes is stopped, but before 
>> swsusp_shrink_memory()?
>>     
>
> There are suspend/hibernation notifiers that can be used for this purpose.
>
> Thanks,
> Rafael
>   
Thanks, Rafael. I tried that and it works fine.

Now, it may be that others will hit this problem as well, as the 
documentation in <linux/pm.h> states that it is safe to make
GFP_KERNEL allocations from within a prepare() callback. Such 
allocations executed in the prepare() preceeding a freeze() will 
probably make the amount of previously freed memory insufficient.

Thanks,

Thomas
