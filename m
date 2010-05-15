From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Fri, 14 May 2010 22:37:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142235580.11498-100000__20562.7302326777$1273891200$gmane$org@netrider.rowland.org>
References: <4BEC8173.4070500@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BEC8173.4070500@crca.org.au>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Matt Reimer <mattjreimer@gmail.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 May 2010, Nigel Cunningham wrote:

> Hi.

> > Subject: [PATCH] fs: prevent hang on suspend/resume when MMC/SD card present
> >
> > Devices can come and go bus during suspend or resume, when the
> > writeback thread is frozen, resulting in a hang. Prevent the hang
> > by thawing the writeback thread in del_gendisk().

> Why not just make it unfreezeable to start with?

If the writeback thread were unfreezable, it might wake up and try to 
write dirty pages back to disks after they were already suspended.  
That would not lead to good consequences...

Alan Stern
