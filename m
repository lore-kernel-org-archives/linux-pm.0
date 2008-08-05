From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] [PM] Fixes missing PM entries in sysfs
 without CONFIG_PM_SLEEP
Date: Tue, 5 Aug 2008 10:26:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808051020220.2518-100000__10561.3001775511$1217946535$gmane$org@iolanthe.rowland.org>
References: <B85A65D85D7EB246BE421B3FB0FBB593013C9AE7E8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593013C9AE7E8@dbde02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Engraf <david.engraf@netcom.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Aug 2008, Dasgupta, Romit wrote:

> A minor change below: Removed old goto label PMError and introduced SysFSError.
> Tested with CONFIG_PM, CONFIG_PM_SLEEP, without CONFIG_PM and ofcourse with CONFIG_USB_SUSPEND. Works fine.

Strictly speaking, I suppose the statement label should be 
DPMSysfsError.

On the other hand, the corresponding label for
device_add_class_symlinks() is SymlinkError, not
DeviceAddClassSymlinksError.  The label for device_add_attrs() is
AttrsError, not DeviceAddAttrsError.  And the label for
bus_add_device() is BusError, not BusAddDeviceError.

Following those precedents, it seems appropriate that the label for
dpm_sysfs_add() should be DPMError.  I'll make the change and submit
the patch.

Alan Stern
