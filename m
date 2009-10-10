From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Hibernation out-of-memory problem.
Date: Sat, 10 Oct 2009 22:55:44 +0200
Message-ID: <4AD0F4D0.2090809__21058.0996390947$1255371255$gmane$org@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

Hi!

I'm trying to port a graphics DRM device driver over to the new power 
management hooks in

struct dev_pm_ops.

During the "prepare" call, Video RAM contents may be copied either to 
shmem objects or pages allocated using alloc_page().
Unfortunately, this seems to lead to the hibernation process running out 
of free pages.

One possible cause is that the function swsusp_shrink_memory() is called 
before the prepare() call, and therefore doesn't free up enough memory.

What would be the correct way around this? Should swsusp_shrink_memory() 
be moved to after prepare(), or is it possible to get some kind of 
notification after user space processes is stopped, but before 
swsusp_shrink_memory()?

Thanks
Thomas
