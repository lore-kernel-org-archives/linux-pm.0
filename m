From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm 2/2] kexec jump -v12: save/restore device
	state
Date: Mon, 14 Jul 2008 09:48:05 -0400
Message-ID: <20080714134805.GD16673__38350.0123549767$1216043712$gmane$org@redhat.com>
References: <1215401124.4660.5.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1215401124.4660.5.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 07, 2008 at 11:25:24AM +0800, Huang Ying wrote:
> This patch implements devices state save/restore before after kexec.
> 
> 
> This patch together with features in kexec_jump patch can be used for
> following:
> 
> - A simple hibernation implementation without ACPI support. You can
>   kexec a hibernating kernel, save the memory image of original system
>   and shutdown the system. When resuming, you restore the memory image
>   of original system via ordinary kexec load then jump back.
> 
> - Kernel/system debug through making system snapshot. You can make
>   system snapshot, jump back, do some thing and make another system
>   snapshot.
> 
> - Cooperative multi-kernel/system. With kexec jump, you can switch
>   between several kernels/systems quickly without boot process except
>   the first time. This appears like swap a whole kernel/system out/in.
> 
> - A general method to call program in physical mode (paging turning
>   off). This can be used to invoke BIOS code under Linux.
> 

Huang,

You have cited various possible use cases of this patchset. Which is
the specific feature you are planning to use?

Thinking more about it, what's the compelling feature out of this list
which makes this patchset a strong candidate for inclusion?

Regarding hibernation, Rafael does not think this is the way to go 
for future.

Regarding ability to have two kernels in memory at the same time and
be able to jump between these two looks like a cool feature but who
is actually planning to use it?

So I am curious to know, which is the compelling feature you are planning
to use?

Thanks
Vivek
