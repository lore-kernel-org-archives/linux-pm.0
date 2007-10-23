From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: lockdep report in hibernate code
Date: Tue, 23 Oct 2007 17:56:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710231750370.21581-100000@netrider.rowland.org>
References: <200710232339.08968.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710232339.08968.rjw@sisk.pl>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Oct 2007, Rafael J. Wysocki wrote:

> > The problem here is that the buffer mutexes are not distinguishable.
> 
> I don't quite get the "which lock already depends on the new lock" part.
> 
> Well, I have always had problems with understanding what lockdep actually
> traces ...

The basic idea is simple enough.  Lockdep looks for events which seem 
to be problematic, such as lock A being acquired while lock B is held 
if earlier on somebody acquired B while holding A.

The difficulty lies in the "_seem_ to be" part -- lockdep can't keep 
track of each and every individual lock in the system.  Instead it 
groups them into categories based on the structures they lie in.  So if 
A and A' are both pm_mutex members but belonging to two different 
structures, lockdep won't be able to tell them apart without help.  If 
someone acquires A then B, and someone else acquires B then A', lockdep 
will report a violation.

Alan Stern
