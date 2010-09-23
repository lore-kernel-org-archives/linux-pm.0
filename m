From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 0/7] Runtime PM updates for autosuspend
Date: Thu, 23 Sep 2010 17:22:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009231702340.1667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael and Greg:

The following series of emails contains my proposed patches for the
runtime PM core, leading up to a general "autosuspend" implementation.  
This is going to be one of those difficult cross-subsystem things,
because the first patch in the series affects sysfs whereas the rest
affect PM.  (In addition, there are two other patches I'm not going to
include here that update USB to take advantage of the new PM
facilities.  Ultimately there will be changes to the SCSI, block, and
IDE layers as well -- they're not written yet.)

We can decide on the best plan for merging these later on.  For now I 
would simply like to post them for review and comments.  These are not 
yet necessarily in final form, but I think they are pretty close.  They 
apply on top of 2.6.36-rc5.

Alan Stern


1/7:	Add sysfs_merge_group() and sysfs_unmerge_group() routines
	for later use by PM and USB.

2/7:	Move the runtime PM accounting routines away from the functions
	that do the actual work.

3/7:	Replace runtime PM boolean arguments with bitflags.

4/7:	Merge the synchronous and asynchronous runtime PM routines.

5/7:	Regroup the public entry points for runtime PM into three
	simple functions.

6/7:	Add the "no_callbacks" flag.

7/7:	Implement autosuspend.
