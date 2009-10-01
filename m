From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/2=5D_Move_swap_functions_to?=
 =?iso-8859-1?q?=09kernel/power/swap=2Ec=2E?=
Date: Thu, 1 Oct 2009 22:53:24 +0200
Message-ID: <200910012253.24465.rjw__7212.21145145154$1254430382$gmane$org@sisk.pl>
References: <4AC036F9.5000003@crca.org.au> <200909292224.32795.rjw@sisk.pl>
	<4AC405BE.7070304@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AC405BE.7070304@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 01 October 2009, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > On Monday 28 September 2009, Nigel Cunningham wrote:
> >> Move hibernation code's functions for allocating and freeing swap
> >> from swsusp.c to swap.c, which is where you'd expect to find them.
> > 
> > Sorry for the delay.
> > 
> > Both patches look good, I'm going to add them to suspend-2.6/linux-next
> > in the next few days.
> 
> Okay; thanks.
> 
> I have another patch for allocating the swap prior to starting to write 
> the image (working towards removing the index pages and then adding 
> readahead & compression). I know the preallocation patch works, but want 
> to do a little more testing (make sure it's always calculating correctly 
> how many pages are needed) before I send it.

Fine by me.

Thanks,
Rafael
