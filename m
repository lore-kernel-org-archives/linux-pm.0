From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re:
	=?utf-8?q?=5BPATCH_1/9=5D_Consolidate_driver=5Fprobe?=
	=?utf-8?q?=5Fdone=28=29_loops_into=09one_place?=
Date: Sun, 22 Feb 2009 05:29:39 +0000 (UTC)
Message-ID: <loom.20090222T052417-460@post.gmane.org>
References: <200902140157.40869.rjw@sisk.pl> <200902140159.08252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

Rafael J. Wysocki <rjw <at> sisk.pl> writes:

> From: Arjan van de Ven <arjan <at> linux.intel.com>
> 
> there's a few places that currently loop over driver_probe_done(), and
> I'm about to add another one. This patch abstracts it into a helper
> to reduce duplication.
[snip]
> +int wait_for_device_probe(void)
> +{
> +	/* wait for the known devices to complete their probing */
> +	while (driver_probe_done() != 0)
> +		msleep(100);
> +	async_synchronize_full();
> +	return 0;
> +}
[snip]
> Index: linux-2.6/init/do_mounts.c
> ===================================================================
> --- linux-2.6.orig/init/do_mounts.c
> +++ linux-2.6/init/do_mounts.c
[snip]
> @@ -399,6 +403,7 @@ void __init prepare_namespace(void)
>  		while (driver_probe_done() != 0 ||
>  			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
>  			msleep(100);
> +		async_synchronize_full();
>  	}

Note that even this loop can be consolidated.  The while loop above can be
equivalently rewritten as

  while ((ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
    msleep(100);
  while (driver_probe_done() != 0)
    msleep(100);

which, with your patch applied is equivalent to

  while ((ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
    msleep(100);
  wait_for_device_probe();

- Hari
