From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] why do we need run disk sync before entering S3
Date: Tue, 12 May 2009 22:01:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905122155550.7989-100000__18835.9615313404$1242180195$gmane$org@netrider.rowland.org>
References: <1242177651.16529.26.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1242177651.16529.26.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 13 May 2009, Zhang Rui wrote:

> Hi, all,
> 
> I did some S3 tests on an eeepc901, the total suspend time(from issue
> the suspend command to power down) is about 2.5s~3s.
> something interesting is that kernel runs disk sync before entering S3
> state, and this takes about 0.7~1.2s.
> my question is that, why do we need this for s2ram?
> can we remove this and run sys_sync for S4 only?

At the risk of sounding foolish, I'd guess that a system in S3 (or more
generally, suspend-to-RAM) is a lot more at risk of losing power or
failing to restore than a normally running system.  (A normally running
system is trivially not at risk of failing to restore!)  Consequently
it makes sense to flush the I/O buffers before entering this state, to
minimize the potential for loss of data.

When you think about it, a system in S4 is actually _less_ likely to 
run into trouble than one in S3, since it can't fail because of loss of 
power.  So if anything, we should remove the disk sync from hibernation 
and leave it in system suspend.

Alan Stern
