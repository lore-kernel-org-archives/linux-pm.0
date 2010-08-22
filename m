From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [PATCH] kzalloc params swapped in pm_qos_power_open
Date: Sun, 22 Aug 2010 16:34:11 -0700
Message-ID: <CA1BBBBC9359F04AA639128AC0D5D1E9B44FEF51@orsmsx502.amr.corp.intel.com>
References: <20100822143544.GC23310@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100822143544.GC23310@gallifrey>
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
To: "Dr. David Alan Gilbert" <linux@treblig.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "James.Bottomley@suse.de" <James.Bottomley@suse.de>
List-Id: linux-pm@vger.kernel.org

Your right. :(

Its working by luck, GFP_KERNEL (= 0x10|0x40|0x80 = 0xD0 = 208 ) is not too big and not too small.

acked-by: mark gross <markgross@thegnar.org>

--mark



>-----Original Message-----
>From: Dr. David Alan Gilbert [mailto:linux@treblig.org]
>Sent: Sunday, August 22, 2010 7:36 AM
>To: linux-pm@lists.linux-foundation.org
>Cc: James.Bottomley@suse.de; Gross, Mark
>Subject: [PATCH] kzalloc params swapped in pm_qos_power_open
>
>Hi,
>  I was playing with sparse and it looks like it spotted that
>the kzalloc in pm_qos_power_open in the current Linus's git tree
>seems to have its parameters swapped. I've got a patch below,
>I've only build tested it.
>
>Signed-off-by: David Alan Gilbert <linux@treblig.org>
>---
>**BUILD TESTED ONLY** (against current git)
>
>diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
>index 996a4de..71dcc21 100644
>--- a/kernel/pm_qos_params.c
>+++ b/kernel/pm_qos_params.c
>@@ -348,7 +348,7 @@ static int pm_qos_power_open(struct inode *inode,
>struct file *filp)
>
>        pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
>        if (pm_qos_class >= 0) {
>-               struct pm_qos_request_list *req = kzalloc(GFP_KERNEL,
>sizeof(*req));
>+               struct pm_qos_request_list *req = kzalloc(sizeof(*req),
>GFP_KERNEL);
>                if (!req)
>                        return -ENOMEM;
>
>
>--
> -----Open up your eyes, open up your mind, open up your code -------
>/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>\ gro.gilbert @ treblig.org |                               | In Hex /
> \ _________________________|_____ http://www.treblig.org   |_______/
