From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] PM / Hibernate: Don't mark pages dirty when
 reading pages while thawing
Date: Thu, 13 Jan 2011 13:36:15 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1101131333071.1899__4330.06395255706$1294922311$gmane$org@localhost6.localdomain6>
References: <20110113055612.GF13496@thunk.org>
	<1294898351-26156-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1294898351-26156-1-git-send-email-tytso@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-pm@lists.linux-foundation.org, Ext4 Developers List <linux-ext4@vger.kernel.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, 13 Jan 2011, Theodore Ts'o wrote:
> Everything was sync'ed before the hibernation, so no pages could be
> dirty.  So this causes a lot of wasted I/O activity right after
> resuming from hibernation.
> 
> Worse, it also causes pages from files that were opened read/only to
> be marked writeble which makes them subject to writeback.  This was
> discovered when ext4 was changed to so that the jinode pointer was not
> initialized unless the file was opened read/write, and this caused
> things to blow up.  But that just unmasked a problem, since the pages
> belonging to the file in question should have never been marked dirty
> in the first place.  It increases the chances the text blocks for
> executables like /usr/bin/killall will get corrupted when they are
> needlessly written, and of course it means extra write cycles to the
> SSD.
> 
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: linux-pm@lists.linux-foundation.org
> ---
>  kernel/power/block_io.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
> index 83bbc7c..108a4f3 100644
> --- a/kernel/power/block_io.c
> +++ b/kernel/power/block_io.c
> @@ -49,8 +49,6 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
>  	if (bio_chain == NULL) {
>  		submit_bio(bio_rw, bio);
>  		wait_on_page_locked(page);
> -		if (rw == READ)
> -			bio_set_pages_dirty(bio);
>  		bio_put(bio);
>  	} else {
>  		if (rw == READ)
> -- 
> 1.7.3.1
> 
> 

I did some test with this patch applied, but sadly it didn't help.
The testcase was reduced to one hibernation followed by a sync.

Regards,
Sebastian
