From: "Dasgupta, Romit" <romit@ti.com>
Subject: Re: [PATCH 1/1] PM: Making bdi threads non-freezable
Date: Tue, 3 Nov 2009 12:12:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EC179__7119.08789021454$1257230614$gmane$org@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBC66@dbde02.ent.ti.com>
	<200911021943.49943.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911021943.49943.rjw@sisk.pl>
Content-Language: en-US
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
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> Subject: Re: [PATCH 1/1] PM: Making bdi threads non-freezable
> 
> On Monday 02 November 2009, Dasgupta, Romit wrote:
> > Fixes the case when bdi threads are in the refrigerator but file system sync
> > can happen after this. This is possible in MMC when
> CONFIG_MMC_UNSAFE_RESUME is
> > not set.
> 
> What's going to happen if we attemt to suspend the underlying block device(s)
> when the bdi thread are doing their job?  Is there any synchronisation
> mechanism for that?
> 
There is no explicit synchronization AFAICT. However, it looks like the call to 'del_gendisk' would invoke 'sync_filesystem' down the line. 'sync_filesystem' would end with synchronous writes of inodes followed by a call to '__sync_blockddev'. 
After this call I believe there should not be any activity pending for the blockdevice. So this should not lead to any race. My tests on the development board did not show any issues. But some FS experts may comment.

Regards,
-Romit
