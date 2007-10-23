From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: lockdep report in hibernate code
Date: Wed, 24 Oct 2007 00:18:02 +0200
Message-ID: <200710240018.02655.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0710231750370.21581-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710231750370.21581-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 23 October 2007 23:56, Alan Stern wrote:
> On Tue, 23 Oct 2007, Rafael J. Wysocki wrote:
> 
> > > The problem here is that the buffer mutexes are not distinguishable.
> > 
> > I don't quite get the "which lock already depends on the new lock" part.
> > 
> > Well, I have always had problems with understanding what lockdep actually
> > traces ...
> 
> The basic idea is simple enough.  Lockdep looks for events which seem 
> to be problematic, such as lock A being acquired while lock B is held 
> if earlier on somebody acquired B while holding A.
> 
> The difficulty lies in the "_seem_ to be" part -- lockdep can't keep 
> track of each and every individual lock in the system.  Instead it 
> groups them into categories based on the structures they lie in.  So if 
> A and A' are both pm_mutex members but belonging to two different 
> structures, lockdep won't be able to tell them apart without help.  If 
> someone acquires A then B, and someone else acquires B then A', lockdep 
> will report a violation.

Yes, which is what I think is happening in this particular case.  More
precisely, we get pm_mutex while holding a buffer mutex, so lockdep is warning
when we get another buffer mutex afterwards.

Greetings (not sure what to do about that),
Rafael
