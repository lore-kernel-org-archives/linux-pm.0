From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/6] TTY: use appropriate printk priority
	level
Date: Thu, 3 Feb 2011 14:13:46 -0800
Message-ID: <20110203221346.GA477__44174.8791178272$1296771945$gmane$org@kroah.com>
References: <20110125235700.GR8008@google.com>
	<1296084570-31453-5-git-send-email-msb@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1296084570-31453-5-git-send-email-msb@chromium.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mandeep Singh Baines <msb@chromium.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 26, 2011 at 03:29:28PM -0800, Mandeep Singh Baines wrote:
> printk()s without a priority level default to KERN_WARNING. To reduce
> noise at KERN_WARNING, this patch set the priority level appriopriately
> for unleveled printks()s. This should be useful to folks that look at
> dmesg warnings closely.
> 
> Signed-off-by: Mandeep Singh Baines <msb@chromium.org>

This doesn't apply to the latest linux-next tree, care to resend it
after refreshing it?

thanks,

greg k-h
