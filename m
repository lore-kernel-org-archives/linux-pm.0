From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Threads shouldn't inherit PF_NOFREEZE
Date: Thu, 20 Oct 2005 10:42:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510201036530.4977-100000@iolanthe.rowland.org>
References: <1129755676.4577.51.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51934287142553881=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1129755676.4577.51.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============51934287142553881==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 20 Oct 2005, Nigel Cunningham wrote:

> Hi Alan.
> 
> On Wed, 2005-10-19 at 05:29, Alan Stern wrote:
> > The PF_NOFREEZE process flag should not be inherited when a thread is 
> > forked.  This patch (as585) removes the flag from the child.
> > 
> > This problem is starting to show up more and more as drivers turn to the
> > kthread API instead of using kernel_thread().  As a result, their kernel
> > threads are now children of the kthread worker instead of modprobe, and
> > they inherit the PF_NOFREEZE flag.  This can cause problems during system
> > suspend; the kernel threads are not getting frozen as they ought to be.
> > 
> > Alan Stern
> 
> I have this in kthread instead, so that multithreaded userspace
> processes only need to have NOFREEZE set once (before forking). Yes, I
> have one that fits this scenario - I'm working on a userspace storage
> maanger, which will setup and tear down a network connection at
> appropriate times during a suspend-to-disk cycle. The initial version is
> based on nbd and uses two threads because the one that sets up storage
> blocks in a syscall as Pavel & others have written it.
> 
> Anyway, I agree that the general need you're trying to address is real.

Thanks.

I had in mind that any process needing NOFREEZE would have to set it 
shortly after starting up.  That's what all the kernel threads do (the 
ones I've read, anyway).

Yes, this does make life more difficult for user threads.  If you're 
already got some mechanism for setting NOFREEZE in the initial thread, 
then it shouldn't be too hard to have the child arrange to set it as well.  
Of course, this does open up the possibility of a race if the child 
thread is created just as processes are being frozen.

Hope this doesn't add a lot of extra trouble to your work...

Alan Stern


--===============51934287142553881==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51934287142553881==--
