From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 0/7] Runtime PM updates for autosuspend
Date: Fri, 24 Sep 2010 22:06:18 +0200
Message-ID: <201009242206.18131.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009241122380.1744-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009241122380.1744-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 24, 2010, Alan Stern wrote:
> On Fri, 24 Sep 2010, Rafael J. Wysocki wrote:
> 
> > On Thursday, September 23, 2010, Alan Stern wrote:
> > > Rafael and Greg:
> > 
> > Hi,
> > 
> > > The following series of emails contains my proposed patches for the
> > > runtime PM core, leading up to a general "autosuspend" implementation.  
> > > This is going to be one of those difficult cross-subsystem things,
> > > because the first patch in the series affects sysfs whereas the rest
> > > affect PM.  (In addition, there are two other patches I'm not going to
> > > include here that update USB to take advantage of the new PM
> > > facilities.  Ultimately there will be changes to the SCSI, block, and
> > > IDE layers as well -- they're not written yet.)
> > > 
> > > We can decide on the best plan for merging these later on.  For now I 
> > > would simply like to post them for review and comments.  These are not 
> > > yet necessarily in final form, but I think they are pretty close.  They 
> > > apply on top of 2.6.36-rc5.
> > > 
> > > Alan Stern
> > > 
> > > 
> > > 1/7:	Add sysfs_merge_group() and sysfs_unmerge_group() routines
> > > 	for later use by PM and USB.
> > > 
> > > 2/7:	Move the runtime PM accounting routines away from the functions
> > > 	that do the actual work.
> > > 
> > > 3/7:	Replace runtime PM boolean arguments with bitflags.
> > > 
> > > 4/7:	Merge the synchronous and asynchronous runtime PM routines.
> > > 
> > > 5/7:	Regroup the public entry points for runtime PM into three
> > > 	simple functions.
> > > 
> > > 6/7:	Add the "no_callbacks" flag.
> > > 
> > > 7/7:	Implement autosuspend.
> > 
> > The series generally looks good to me, except for a few comments, mostly
> > related to the names of various things I sent in my replies to the specific
> > patches.
> 
> Your points were all well taken.  I'll revise the patches and submit
> them.  Do you think it's too late for them to appear in the next merge
> window?

No, it's not.  I actually would like to push them for .37.

Thanks,
Rafael
