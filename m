From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Mon, 3 May 2010 17:03:11 +0200
Message-ID: <201005031703.11448.rjw__45880.6772636764$1272899151$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005021755320.30701-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005021755320.30701-100000@netrider.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 02 May 2010, Alan Stern wrote:
> On Sun, 2 May 2010, Rafael J. Wysocki wrote:
> 
> > Hmm.  It doesn't seem to be possible to create two different suspend blockers
> > using the same file handle.  So, what exactly is a process supposed to do to
> > use two suspend blockers at the same time?
> 
> Open the file twice, thereby obtaining two file handles.

Well, that's what I thought.

I must admit I'm not really comfortable with this interface.  IMO it would
be better if _open() created the suspend blocker giving it a name based on
the name of the process that called it.  Something like
"<process name>_<timestamp>" might work at first sight.

Alternatively, "<process_name><number>", where <number> is 0 for the first
suspend blocker created by the given process, 1 for the second one etc., also
seems to be doable.

Rafael
