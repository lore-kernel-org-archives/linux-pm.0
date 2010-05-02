From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Sun, 2 May 2010 17:56:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005021755320.30701-100000__26327.8119070039$1272837446$gmane$org@netrider.rowland.org>
References: <201005022323.30128.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005022323.30128.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 May 2010, Rafael J. Wysocki wrote:

> Hmm.  It doesn't seem to be possible to create two different suspend blockers
> using the same file handle.  So, what exactly is a process supposed to do to
> use two suspend blockers at the same time?

Open the file twice, thereby obtaining two file handles.

Alan Stern
