From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Thu, 30 Oct 2008 18:43:01 +0100
Message-ID: <E1KvbXx-0002dH-4j__34597.8096397177$1225388802$gmane$org@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0810301301540.2513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0810301301540.2513-100000@iolanthe.rowland.org>
	(message from Alan Stern on Thu, 30 Oct 2008 13:07:27 -0400 (EDT))
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Oct 2008, Alan Stern wrote:
> Okay.  Don't forget things like ioctl for sockets -- they often involve 
> doing I/O directly to the network interface device.

Yeah, ioctls should probably just always be protected (at least
initially), regardless of what type of file they are done on.

> What happens to a task accessing a non-regular file on a fuse 
> filesystem?  :-)

The same as on any other filesystem, i.e. the fs is only involved as
far as calling init_special_inode(), the rest is taken care of by the
VFS.

Tejun Heo recently posted patches to fuse which enable emulating a
char device from userspace.  That is another matter, obviously we'd
want to keep the "allow suspend during I/O" property of fuse in that
case, even though there's a char device involved (but no hardware, at
least not on that level).

Miklos
