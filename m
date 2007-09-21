From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 1/2] Merge power-management source files
Date: Fri, 21 Sep 2007 14:44:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709211442140.4344-100000@iolanthe.rowland.org>
References: <20070921174032.GA13137@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070921174032.GA13137@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Sep 2007, Greg KH wrote:

> On Thu, Sep 20, 2007 at 02:05:03PM -0400, Alan Stern wrote:
> > This proposed patch applies to 2.6.23-rc6-mm1.  It merges the suspend.c 
> > and resume.c files in drivers/base/power into main.c, while making some 
> > public symbols private.
> > 
> > If nobody objects, I will submit it to Andrew Morton.
> 
> Why Andrew?  I thought I had to handle all of the drivers/base/* stuff
> :)

To tell the truth, I wasn't sure how all this was supposed to work.  
Rafael has been making a lot of changes to the PM infrastructure 
(though almost all of them affect the files in kernel/power, not 
drivers/base/power) and his work goes into -mm.

But never mind, I will shortly send the changes to you so they can go
into your tree.

Alan Stern
