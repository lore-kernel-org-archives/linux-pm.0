From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Sat, 15 May 2010 12:53:57 +1000
Message-ID: <4BEE0CC5.60804__44428.8195031278$1273892179$gmane$org@crca.org.au>
References: <Pine.LNX.4.44L0.1005142235580.11498-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005142235580.11498-100000@netrider.rowland.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Matt Reimer <mattjreimer@gmail.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On 15/05/10 12:37, Alan Stern wrote:
> On Fri, 14 May 2010, Nigel Cunningham wrote:
>
>> Hi.
>
>>> Subject: [PATCH] fs: prevent hang on suspend/resume when MMC/SD card present
>>>
>>> Devices can come and go bus during suspend or resume, when the
>>> writeback thread is frozen, resulting in a hang. Prevent the hang
>>> by thawing the writeback thread in del_gendisk().
>
>> Why not just make it unfreezeable to start with?
>
> If the writeback thread were unfreezable, it might wake up and try to
> write dirty pages back to disks after they were already suspended.
> That would not lead to good consequences...

If it syncs data as it should when we freeze processes, there won't be 
any problem. Perhaps this is just an argument against making syncing 
optional?

Regards,

Nigel
