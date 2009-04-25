From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if it's in use
Date: Sat, 25 Apr 2009 14:33:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904251432250.20179-100000@netrider.rowland.org>
References: <49F34440.5020304@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49F34440.5020304@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Sat, 25 Apr 2009, Michael Trimarchi wrote:

> Ok, I understand, so how to know the devices dependences? There is a way 
> to express
> this relation? Because if it is not possible a single flag can be used

Nobody knows all the device dependencies.  That's why we're afraid that 
if you change the list, something will break.

> > This will set the dont_suspend flag for all devices in the subtree 
> > starting at topdev.
> >   
> Yes this is possible, but you walk all list twice.

So what?  Walking the list is very quick, and you're not on a 
time-critical path.

Alan Stern
