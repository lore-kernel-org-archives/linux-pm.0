From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: r8152 livelocks during pm_runtime_suspend
Date: Fri, 30 Mar 2018 15:37:12 +0200
Message-ID: <6cbd7b19-23e2-ab03-ed59-7c66b1c88986@suse.cz>
References: <d1e1a702-753f-ec83-ed71-7e3649b20757@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <d1e1a702-753f-ec83-ed71-7e3649b20757@suse.cz>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: hayeswang@realtek.com
Cc: USB list <linux-usb@vger.kernel.org>, ML netdev <netdev@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/30/2018, 03:17 PM, Jiri Slaby wrote:
> Hi,
> 
> I have seen r8152 from my docking station to kill my box several times
> in the last few days. The notebook is new, so I don't know if this is a
> regression.

Forgot to add, I am seeing this in dmesg:
[   13.353239] r8152 4-1.2:1.0 (unnamed net_device) (uninitialized):
Using pass-thru MAC addr d8:9e:f3:f6:6d:0c
[   13.365082] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   13.390990] r8152 4-1.2:1.0 eth1: v1.09.9
[   13.399314] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   13.552529] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   13.561268] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   13.736582] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   14.198646] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[   14.537233] Netfilter messages via NETLINK v0.30.
[   14.544740] ip_set: protocol 6
[   16.697657] r8152 4-1.2:1.0 eth1: carrier on
[   16.697724] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   16.847718] NET: Registered protocol family 17
[   20.629344] fuse init (API version 7.26)
[   21.371334] Bluetooth: RFCOMM TTY layer initialized
[   21.371343] Bluetooth: RFCOMM socket layer initialized
[   21.371353] Bluetooth: RFCOMM ver 1.11
[   21.753577] tun: Universal TUN/TAP device driver, 1.6
[   25.992820] retire_capture_urb: 2491 callbacks suppressed
[  118.054869] NOHZ: local_softirq_pending 08
[  118.056988] NOHZ: local_softirq_pending 08
[  185.562659] NOHZ: local_softirq_pending 08

08 seems to be NET_RX_SOFTIRQ. So is this related?

Kernel version: 4.15.14

> I have the NIC connected all the time. And when I return to the notebook
> after a while, the networking is dead. Looking at the stack traces, it
> is clear, that r8152 was attempted to be autosuspended and waits in
> napi_disable for NAPI_STATE_SCHED bit to be cleared:
> [22001.018437] kworker/2:0     D    0 16267      2 0x80000000
> [22001.018441] Workqueue: pm pm_runtime_work
> [22001.018443] Call Trace:
> [22001.018453]  schedule+0x2f/0x90
> [22001.018455]  schedule_timeout+0x1ce/0x540
> [22001.018474]  msleep+0x29/0x30
> [22001.018477]  napi_disable+0x25/0x60
> [22001.018483]  rtl8152_suspend+0x20a/0x2d0 [r8152]
> [22001.018493]  usb_suspend_both+0x8d/0x200 [usbcore]
> [22001.018510]  usb_runtime_suspend+0x2a/0x70 [usbcore]
> [22001.018514]  __rpm_callback+0xbc/0x1f0
> [22001.018519]  rpm_callback+0x4f/0x70
> [22001.018526]  rpm_suspend+0x11d/0x6d0
> [22001.018532]  pm_runtime_work+0x73/0xb0
> [22001.018535]  process_one_work+0x269/0x6c0
> [22001.018541]  worker_thread+0x2b/0x3d0
> [22001.018547]  kthread+0x113/0x130
> [22001.018556]  ret_from_fork+0x24/0x50
> 
> The assembly:
>> ffffffff81716730 <napi_disable>:
>> ffffffff81716730:       e8 eb b7 2e 00          callq  ffffffff81a01f20 <__fentry__>
>> ffffffff81716735:       55                      push   %rbp
>> ffffffff81716736:       48 89 fd                mov    %rdi,%rbp
>> ffffffff81716739:       53                      push   %rbx
>> ffffffff8171673a:       48 8d 5f 10             lea    0x10(%rdi),%rbx
>> ffffffff8171673e:       f0 80 4f 10 04          lock orb $0x4,0x10(%rdi)
>> ffffffff81716743:       f0 0f ba 6f 10 00       lock btsl $0x0,0x10(%rdi)
>> ffffffff81716749:       73 11                   jae    ffffffff8171675c <napi_disable+0x2c>
>> ffffffff8171674b:       bf 01 00 00 00          mov    $0x1,%edi
>> ffffffff81716750:       e8 ab ac a0 ff          callq  ffffffff81121400 <msleep>
>> ffffffff81716755:       f0 0f ba 2b 00          lock btsl $0x0,(%rbx)
>> ffffffff8171675a:       72 ef                   jb     ffffffff8171674b <napi_disable+0x1b>
> 
> 
> 
> 
> 
> There are other tasks in D state, of course, like these, waiting for the
> device to become pm-up:
> [22001.018749] kworker/3:1     D    0 16798      2 0x80000000
> [22001.018753] Workqueue: events rtl_work_func_t [r8152]
> [22001.018755] Call Trace:
> [22001.018767]  schedule+0x2f/0x90
> [22001.018769]  rpm_resume+0xf9/0x860
> [22001.018777]  rpm_resume+0x592/0x860
> [22001.018783]  __pm_runtime_resume+0x3a/0x50
> [22001.018789]  usb_autopm_get_interface+0x1d/0x50 [usbcore]
> [22001.018793]  rtl_work_func_t+0x3e/0x405 [r8152]
> [22001.018801]  process_one_work+0x269/0x6c0
> [22001.018807]  worker_thread+0x2b/0x3d0
> [22001.018813]  kthread+0x113/0x130
> [22001.018822]  ret_from_fork+0x24/0x50
> [22001.019713] tcpdump         D    0 17119   4265 0x00000004
> [22001.019716] Call Trace:
> [22001.019728]  schedule+0x2f/0x90
> [22001.019730]  rpm_resume+0xf9/0x860
> [22001.019738]  rpm_resume+0x592/0x860
> [22001.019744]  __pm_runtime_resume+0x3a/0x50
> [22001.019750]  usb_autopm_get_interface+0x1d/0x50 [usbcore]
> [22001.019754]  rtl8152_ioctl+0x30/0x140 [r8152]
> [22001.019758]  dev_ifsioc+0x115/0x3f0
> [22001.019763]  dev_ioctl+0x14b/0x680
> [22001.019775]  sock_do_ioctl+0x41/0x50
> [22001.019778]  sock_ioctl+0x1c2/0x2f0
> [22001.019781]  do_vfs_ioctl+0x91/0x680
> [22001.019789]  SyS_ioctl+0x74/0x80
> [22001.019794]  do_syscall_64+0x76/0x1c0
> 
> ...
> 
>> Showing all locks held in the system: 
>> 1 lock held by in:imklog/1371:
>>  #0:  (&f->f_pos_lock){+.+.}, at: [<00000000a0b38807>] __fdget_pos+0x3f/0x50
>> 1 lock held by Qt bearer threa/3003:
>>  #0:  (rtnl_mutex){+.+.}, at: [<0000000021e0bca0>] __netlink_dump_start+0x4c/0x1b0
>> 1 lock held by Qt bearer threa/2825:
>>  #0:  (rtnl_mutex){+.+.}, at: [<0000000021e0bca0>] __netlink_dump_start+0x4c/0x1b0
>> 1 lock held by DNS Res~ver #40/17041:
>>  #0:  (rtnl_mutex){+.+.}, at: [<0000000021e0bca0>] __netlink_dump_start+0x4c/0x1b0
>> 1 lock held by Qt bearer threa/3110:
>>  #0:  (rtnl_mutex){+.+.}, at: [<0000000021e0bca0>] __netlink_dump_start+0x4c/0x1b0
>> 1 lock held by DNS Res~ver #16/17044:
>>  #0:  (rtnl_mutex){+.+.}, at: [<0000000021e0bca0>] __netlink_dump_start+0x4c/0x1b0
>> 2 locks held by bash/4561:
>>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e3d76e61>] tty_ldisc_ref_wait+0x24/0x50
>>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000091462d05>] n_tty_read+0xc3/0x850
>> 3 locks held by kworker/2:0/16267:
>>  #0:  ((wq_completion)"pm"){+.+.}, at: [<00000000b9dc0832>] process_one_work+0x1e3/0x6c0
>>  #1:  ((work_completion)(&dev->power.work)){+.+.}, at: [<00000000b9dc0832>] process_one_work+0x1e3/0x6c0
>>  #2:  (&tp->control){+.+.}, at: [<00000000ca575b90>] rtl8152_suspend+0x2b/0x2d0 [r8152]
>> 2 locks held by kworker/3:1/16798:
>>  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000b9dc0832>] process_one_work+0x1e3/0x6c0
>>  #1:  ((work_completion)(&(&tp->schedule)->work)){+.+.}, at: [<00000000b9dc0832>] process_one_work+0x1e3/0x6c0
>> 1 lock held by tcpdump/17119: 
>>  #0:  (rtnl_mutex){+.+.}, at: [<0000000023a6461d>] dev_ioctl+0x13d/0x680
>> 2 locks held by less/17187: 
>>  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e3d76e61>] tty_ldisc_ref_wait+0x24/0x50
>>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000091462d05>] n_tty_read+0xc3/0x850
> 
> 
> For now, I disabled pm-runtime on the device by:
> echo on > /sys/bus/usb/devices/4-1.2/power/control
> 
> Any ideas what's wrong? napi_disable from runtime suspend? Double
> napi_disable on the path? Some missing pm_runtime_get_sync somewhere?
> 
> Full dmesg after sysrq-t:
> https://www.fi.muni.cz/~xslaby/sklad/panics/r8152.txt
> 
> thanks,
> 


-- 
js
suse labs
