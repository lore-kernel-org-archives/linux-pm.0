From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation out-of-memory problem.
Date: Mon, 12 Oct 2009 23:17:59 +0200
Message-ID: <200910122317.59973.rjw@sisk.pl>
References: <4AD0F4D0.2090809@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AD0F4D0.2090809@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Saturday 10 October 2009, Thomas Hellstrom wrote:
> Hi!
> 
> I'm trying to port a graphics DRM device driver over to the new power 
> management hooks in
> 
> struct dev_pm_ops.
> 
> During the "prepare" call, Video RAM contents may be copied either to 
> shmem objects or pages allocated using alloc_page().
> Unfortunately, this seems to lead to the hibernation process running out 
> of free pages.
> 
> One possible cause is that the function swsusp_shrink_memory() is called 
> before the prepare() call, and therefore doesn't free up enough memory.
> 
> What would be the correct way around this? Should swsusp_shrink_memory() 
> be moved to after prepare(), or is it possible to get some kind of 
> notification after user space processes is stopped, but before 
> swsusp_shrink_memory()?

There are suspend/hibernation notifiers that can be used for this purpose.

Thanks,
Rafael
