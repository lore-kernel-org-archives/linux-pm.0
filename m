From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 18:21:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031814440.8010-100000__35040.6339545318$1183501584$gmane$org@iolanthe.rowland.org>
References: <20070703212002.GA28895@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703212002.GA28895@srcf.ucam.org>
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

> On Tue, Jul 03, 2007 at 05:16:37PM -0400, Alan Stern wrote:
> > On Tue, 3 Jul 2007, Matthew Garrett wrote:
> > > But that's fine - "Are we undergoing a systemwide suspend" is an easy 
> > > question to ask. Freezing processes instead means that most of those 
> > > paths will never be tested.
> > 
> > The question is easy to ask, but it's not so easy to figure out what
> > you should do if the answer is Yes.  Freezing processes instead means
> > that those "untested" paths -- in many, many drivers -- won't have to 
> > exist at all.
> 
> We're used to the idea of applications blocking when a resource they're 
> using goes away - NFS has done it forever. 

You persist in evading my point.  I'm not worried about applications;  
I'm worried about drivers.

Let me put it explicitly: You're writing a driver.  You're working on
the read, write, or probe method.  You add code to check if a system
sleep is underway.  Suppose the answer is Yes -- what does your driver
do next?

Make your answer as detailed as you reasonably can.  And be careful to 
arrange things so that an ongoing I/O operation doesn't get messed up 
when your suspend method is called.

Alan Stern
