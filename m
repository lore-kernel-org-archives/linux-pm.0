From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 19:17:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707151915570.28934-100000__35874.0633623258$1184541576$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.64.0707151253141.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707151253141.25614@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007 david@lang.hm wrote:

> > (1) Filesystems mounted before the hibernation are untouchable
> >
> >    When there's a memory snapshot, either in the form of a hibernation image,
> >    or in the form of the "old" kernel and processes available to the "new"
> >    kexeced kernel responsible for saving their memory, the filesystems mounted
> >    before the hibernation should not be accessed, even for reading, because
> >    that would cause their on-disk state to be inconsistent with the snapshot
> >    and might lead to a filesystem corruption.
> 
> AFAIK this is only the case with ext3, all other filesystems could be 
> accessed read-only safely
> 
> this is arguably a bug with ext3 (and has been discussed as such), but 
> right now the ext3 team has decided not to change this bahavior so 
> hibernate needs to work around it. but don't mistake a work-around for a 
> single (admittedly very popular) filesystem with a hard and fast 
> directive.

Isn't is possible to avoid this problem by mounting an ext3 filesystem 
as readonly ext2?  Provided the filesystem isn't dirty it should be 
doable.  (And provided the filesystem doesn't use any ext3 extensions 
that are incompatible with ext2.)

Alan Stern
