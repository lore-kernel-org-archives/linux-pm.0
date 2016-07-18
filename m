From: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
Subject: Re: [PATCH v2 00/10] Exynos IOMMU: proper runtime PM support (use
	device dependencies)
Date: Mon, 18 Jul 2016 18:43:02 +0200
Message-ID: <578D0716.6060106@math.uni-bielefeld.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
	<5787B2B0.9020809@math.uni-bielefeld.de>
	<5788E352.3040801@math.uni-bielefeld.de>
	<a15e438a-7fa0-3a4d-e6e2-13425512dddd@samsung.com>
	<578CB6DB.90608@math.uni-bielefeld.de>
	<6939949e-4c8e-cba0-9858-b37d1ba01869@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6939949e-4c8e-cba0-9858-b37d1ba01869-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hey Marek,


Marek Szyprowski wrote:
> Dear Tobias
> 
> 
> On 2016-07-18 13:00, Tobias Jakobi wrote:
>> Marek Szyprowski wrote:
>>> On 2016-07-15 15:21, Tobias Jakobi wrote:
>>>> Tobias Jakobi wrote:
>>>>> Hello Marek,
>>>>>
>>>>> I've tested the patchset on 4.7-rc7 and noticed that it breaks
>>>>> reboot on
>>>>> my ODROID-X2.
>>>>>
>>>>> Going to check where exactly things break.
>>>> Sadly it's the last patch where everything comes together:
>>>> "iommu/exynos: Add proper runtime pm support"
>>>>
>>>> I still have to check if forcing runpm status to 'on' makes a
>>>> difference. I suspect that the aggressive clock gating might be the
>>>> reason?
>>> Thanks for testing. I will check this issue. Could you send me your
>>> .config?
>> This is the config I'm currently using:
>> https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.7-debug.conf
>>
>>
>> Do you think checking this with no_console_suspend makes sense?
> 
> no_console_suspend switch won't provide more information, but I managed
> to reproduce your issue. I'm really confused how enabling runtime pm can
> cause problems with usb/smsc95xx ethernet driver (that is the reason for
> failed reboot). Maybe it is somehow related to the global relations
> between devices and drivers and the fact that creating the runtime pm
> links change the order of operations. I will check this again when
> Rafael send updated patches. Here is the log I got (after waiting some
> time):
thanks for looking into this! I'll try to reproduce this on my board. I
have to admit that I didn't wait too long for the hung task message to
appear.

I wonder if this has something to do with regulator code cutting some
supplies too early. Is this on a X2 or a U2/U3? I'm not sure if we
currently model the regulator setup correctly here (IIRC then buck8 is
supplying the LAN/USB block on U2/U3).


- Tobias


> 
> # reboot
> 
> Broadcast message from root@target (ttySAC1) (Mon Jul 18 13:33:38 2016):
> 
> The system is going down for reboot NOW!
> INIT: Switching to runlevel: 6
> INIT: Sending processes the TERM signal
> [info] Using makefile-style concurrent boot in runlevel 6.
> [ ok ] Stopping cgroup management proxy daemon: cgproxy[....] Stopping
> internet superserver: inetd.
> [....] Stopping cgroup management daemon: cgmanagermax77686-rtc
> max77686-rtc: RTC alarm IRQ: 119
> [ ok ] Shutting down ALSA...done.
> random: nonblocking pool is initialized
> [info] Saving the system clock.
> [info] Hardware Clock updated to Mon Jul 18 13:33:40 UTC 2016.
> [ ok ] Asking all remaining processes to terminate...done.
> [ ok ] All processes ended within 1 seconds...done.
> [ ok ] Stopping rpcbind daemon....
> [ ok ] Deconfiguring network interfaces...done.
> [ ok ] Unmounting temporary filesystems...done.
> [ ok ] Deactivating swap...done.
> EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> [info] Will now restart.
> smsc95xx 1-2:1.0 eth0: Failed to read reg index 0x00000114: -110
> smsc95xx 1-2:1.0 eth0: Error reading MII_ACCESS
> smsc95xx 1-2:1.0 eth0: MII is busy in smsc95xx_mdio_read
> smsc95xx 1-2:1.0 eth0: Failed to read MII_BMSR
> INFO: task kworker/0:1:410 blocked for more than 120 seconds.
>       Not tainted 4.7.0-rc7-debug+ #155
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/0:1     D c06850a8     0   410      2 0x00000000
> Workqueue: events_freezable mmc_rescan
> Backtrace:
> [<c0684e90>] (__schedule) from [<c068560c>] (schedule+0x44/0xb0)
>  r10:00000000 r9:eebe1d88 r8:c0686234 r7:00000000 r6:00000002 r5:7fffffff
>  r4:7fffffff
> [<c06855c8>] (schedule) from [<c068a398>] (schedule_timeout+0x154/0x1b0)
> [<c068a244>] (schedule_timeout) from [<c0686250>]
> (wait_for_common+0xe0/0x174)
>  r8:c0686234 r7:00000000 r6:00000002 r5:eebe1d8c r4:7fffffff
> [<c0686170>] (wait_for_common) from [<c0686430>]
> (wait_for_completion+0x18/0x1c)
>  r10:00000001 r9:00000000 r8:00000000 r7:eebe1d88 r6:eebe1d78 r5:ee260000
>  r4:eebe1de4
> [<c0686418>] (wait_for_completion) from [<c04e72c8>]
> (mmc_wait_for_req+0xc8/0x15c)
> [<c04e7200>] (mmc_wait_for_req) from [<c04e73c8>]
> (mmc_wait_for_cmd+0x6c/0xa4)
>  r8:eef73d00 r7:00000003 r6:ee260000 r5:c0a02448 r4:eebe1de4 r3:00000000
> [<c04e735c>] (mmc_wait_for_cmd) from [<c04edbf4>]
> (mmc_send_status+0x8c/0xb0)
>  r7:eebe1eb0 r6:ee260000 r5:ee260000 r4:00000000
> [<c04edb68>] (mmc_send_status) from [<c04eaf80>] (mmc_alive+0x18/0x1c)
>  r4:ee260000
> [<c04eaf68>] (mmc_alive) from [<c04e93d0>]
> (_mmc_detect_card_removed+0x40/0x90)
> [<c04e9390>] (_mmc_detect_card_removed) from [<c04eba80>]
> (mmc_detect+0x2c/0x78)
>  r5:ee2602bc r4:ee260000
> [<c04eba54>] (mmc_detect) from [<c04e96ac>] (mmc_rescan+0x1b0/0x324)
>  r5:ee2602bc r4:ee260368
> [<c04e94fc>] (mmc_rescan) from [<c013a818>] (process_one_work+0x194/0x414)
>  r8:eef73d00 r7:eebe1eb0 r6:eef70280 r5:ee260368 r4:eea24080 r3:c04e94fc
> [<c013a684>] (process_one_work) from [<c013ab0c>]
> (worker_thread+0x34/0x4d4)
>  r10:eef70280 r9:c0a02100 r8:00000008 r7:eef70280 r6:eea24098 r5:eef702b4
>  r4:eea24080
> [<c013aad8>] (worker_thread) from [<c0141e18>] (kthread+0xf8/0x11c)
>  r10:00000000 r9:00000000 r8:00000000 r7:c013aad8 r6:eea24080 r5:00000000
>  r4:eea29d00
> [<c0141d20>] (kthread) from [<c0107ff0>] (ret_from_fork+0x14/0x24)
>  r7:00000000 r6:00000000 r5:c0141d20 r4:eea29d00
> 2 locks held by kworker/0:1/410:
>  #0:  ("events_freezable"){.+.+.+}, at: [<c013a7ac>]
> process_one_work+0x128/0x414
>  #1:  ((&(&host->detect)->work)){+.+.+.}, at: [<c013a7ac>]
> process_one_work+0x128/0x414
> 
> 
> Best regards
