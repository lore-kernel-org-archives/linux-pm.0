From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH wq#for-2.6.39] workqueue: add
	system_freezeable_wq
Date: Tue, 8 Feb 2011 10:32:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102081029430.2100-100000__32274.3869889111$1297179286$gmane$org@iolanthe.rowland.org>
References: <20110208151453.GC6558@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110208151453.GC6558@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Feb 2011, Tejun Heo wrote:

> On Tue, Feb 08, 2011 at 10:10:46AM -0500, Alan Stern wrote:
> > On Tue, 8 Feb 2011, Tejun Heo wrote:
> > 
> > > From de62c151df9b6568c67977920267392c432f340a Mon Sep 17 00:00:00 2001
> > > From: Tejun Heo <tj@kernel.org>
> > > Date: Tue, 8 Feb 2011 10:39:03 +0100
> > > 
> > > Add system wide freezeable workqueue.
> > 
> > The preferred spelling is "freezable".
> 
> Hmmm... workqueue always has used freezeable (even before cmwq
> changes).  It seems like mass renaming is in order.  :-(

The name of create_freezeable_workqueue was misspelled originally and
then never changed.  But other code and most of the comments and 
documentation are spelled correctly -- grep for both spellings and 
you'll see.

Agreed, some renaming and editing is in order.

Alan Stern
