From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM / hibernate xfs lock up / xfs_reclaim_inodes_ag
Date: Tue, 16 Aug 2011 20:05:59 +0200
Message-ID: <201108162006.00200.rjw@sisk.pl>
References: <4E1C70AD.1010101@u-club.de>
	<20110810214327.GA9320@atrey.karlin.mff.cuni.cz>
	<4E4A64D4.4000005@u-club.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E4A64D4.4000005@u-club.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Christoph <cr2005@u-club.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 16, 2011, Christoph wrote:
> On 10.08.2011 23:43, Pavel Machek wrote:
> > Hi!
> > 
> >>>> Why don't you simply submit a patch to do that?
> >>>
> >>> a) I don't know how to test suspend/hibernate
> >>> b) I don't have any hardware I can test it on.
> 
> 
> Hi!
> 
> I do apologize fmy silence but I've been in a serious productions the last
> weeks.
> 
> If there any patches to test, let me know. I can run some decent stress tests.

Well, please try the one attached to
https://bugzilla.kernel.org/show_bug.cgi?id=33622#c10

Thanks,
Rafael
