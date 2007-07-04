From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 10:38:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041030540.25704-100000__45937.0080302053$1183559975$gmane$org@netrider.rowland.org>
References: <20070703224215.GA30081@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703224215.GA30081@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Matthew Garrett wrote:

> On Tue, Jul 03, 2007 at 06:21:42PM -0400, Alan Stern wrote:
> > On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > > We're used to the idea of applications blocking when a resource they're 
> > > using goes away - NFS has done it forever. 
> > 
> > You persist in evading my point.  I'm not worried about applications;  
> > I'm worried about drivers.
> > 
> > Let me put it explicitly: You're writing a driver.  You're working on
> > the read, write, or probe method.  You add code to check if a system
> > sleep is underway.  Suppose the answer is Yes -- what does your driver
> > do next?
> 
> Leave the process blocked and defer any i/o until after resume. Why does 
> it need to be any more complicated than that?

(1) The driver will undoubtedly hold some mutex or semaphore at the 
time it checks whether a system sleep is underway.  You will have to 
drop it before blocking and then reacquire it afterward.

(2) The driver may have been called by some other routine which holds a 
mutex needed for resuming the device.  In this case the driver _can't_ 
drop the mutex and so the resume will deadlock.


Okay, I agree that (1) can be handled without too much effort.  But 
doing it adds an extra test to _every_ driver's I/O pathway.  Freezing 
userspace does not incur all this additional overhead.

(2) shouldn't arise during normal read and write operations, but it
certainly _will_ arise during probe.

Alan Stern
