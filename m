From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: broken suspend,
	sometimes (drm related) [Was: 2.6.24-rc5-mm1]
Date: Mon, 17 Dec 2007 08:55:43 -0800
Message-ID: <200712170855.43556.jbarnes__39766.8914207772$1197915541$gmane$org@virtuousgeek.org>
References: <20071213024050.7d6e5f3e.akpm@linux-foundation.org>
	<47646A6C.7070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47646A6C.7070007@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.sourceforge.net, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> next suspend/resume try:
> BLE drm_addmap_core a: map ffff81007c2d9b00, handle 0000000000000000
> BLE drm_addmap_core c: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_rmmap_locked b: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_addmap_core a: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_addmap_core c: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_rmmap_locked b: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_addmap_core a: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_addmap_core c: map ffff81007c2d9b00, handle ffffc20010092000
> BLE drm_addmap_core a: map ffff81007c2d90c0, handle 8000000000000000
> BLE drm_addmap_ioctl a: map ffff81007c2d96c0, handle 0000000000000000
> BLE drm_addmap_core a: map ffff81007c2d90c0, handle 0000000000000000
> BLE drm_addmap_ioctl a: map ffff81007c2d96c0, handle 0000000000000000
> BLE drm_addmap_core a: map ffff81007c2d9800, handle 0000000000000000
> BLE drm_addmap_core b: map ffff81007c2d9800, handle ffffc20010380000
> BLE drm_addmap_ioctl a: map ffff81007c2d96c0, handle 0000000000000000
> BLE drm_addmap_core a: map ffff81007c2d9e80, handle ffff81007c2d9d40
> BLE drm_addmap_ioctl a: map ffff81007c2d96c0, handle 0000000000000000
> BLE drm_core_ioremap: map ffff81007d0ab050, handle ffffc20010240000
> set status page addr 0x00033000
> BLE drm_core_ioremap: map ffff81007d0ab098, handle ffffc20010096000
> BLE drm_addmap_core a: map ffff81007bd7d440, handle 6632785c63766632
> BLE drm_addmap_ioctl a: map ffff81007bd7d080, handle 0000000000000000
> BLE drm_addmap_core a: map ffff81007bd7d700, handle 6632785c63766632
> BLE drm_addmap_ioctl a: map ffff81007bd7d080, handle 0000000000000000
> BLE drm_addmap_core a: map ffff81007c16f840, handle ffff81007c16f680
> BLE drm_addmap_ioctl a: map ffff81007bd7d080, handle 0000000000000000
> BLE drm_addmap_core a: map ffff81007c16f2c0, handle ffff81007cc33e10
> BLE drm_addmap_ioctl a: map ffff81007c16f640, handle 0000000000000000
> BLE drm_core_ioremapfree a: map ffff81007d0ab050, handle ffffc20010240000
> BLE drm_core_ioremapfree b: map ffff81007d0ab050, handle ffffc20010240000
> BLE drm_core_ioremapfree a: map ffff81007d0ab098, handle ffffc20010096000
> BLE drm_core_ioremapfree b: map ffff81007d0ab098, handle ffffc20010096000
> BLE drm_rmmap_locked a: map ffff81007c2d9800, handle ffffc20010380000
> BLE drm_rmmap_locked b: map ffff81007c2d9b00, handle ffffc20010092000
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> PM: Entering mem sleep
> sd 2:0:0:0: [sdc] Synchronizing SCSI cache
> sd 2:0:0:0: [sdc] Stopping disk
> sd 1:0:0:0: [sdb] Synchronizing SCSI cache
> sd 1:0:0:0: [sdb] Stopping disk
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> sd 0:0:0:0: [sda] Stopping disk
> drm_sysfs_suspend
> BAD BAD BAD ffff81007c2d9800 0000000000000000
> suspend_device(): drm_sysfs_suspend+0x0/0x40() returns -5
> Could not suspend device card0: error -5
> sd 0:0:0:0: [sda] Starting disk
>
> I;m out of ideas, please give me a clue.

This sounds a lot like a problem we had recently.  The driver wasn't 
preserving its mappings across X startup/shutdown (drm open/close) and so 
you'd see crashes like this.  It should be fixed already in DRM git.

Jesse
