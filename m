From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 1/2] Move swap functions
	to	kernel/power/swap.c.
Date: Thu, 01 Oct 2009 11:28:30 +1000
Message-ID: <4AC405BE.7070304__28907.3106986054$1254360611$gmane$org@crca.org.au>
References: <4AC036F9.5000003@crca.org.au> <200909292224.32795.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909292224.32795.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
> On Monday 28 September 2009, Nigel Cunningham wrote:
>> Move hibernation code's functions for allocating and freeing swap
>> from swsusp.c to swap.c, which is where you'd expect to find them.
> 
> Sorry for the delay.
> 
> Both patches look good, I'm going to add them to suspend-2.6/linux-next
> in the next few days.

Okay; thanks.

I have another patch for allocating the swap prior to starting to write 
the image (working towards removing the index pages and then adding 
readahead & compression). I know the preallocation patch works, but want 
to do a little more testing (make sure it's always calculating correctly 
how many pages are needed) before I send it.

Regards,

Nigel
