From: David Engraf <david.engraf@netcom.eu>
Subject: Re: [PATCH] [PM] Fixes missing PM entries in sysfs
	without CONFIG_PM_SLEEP
Date: Tue, 05 Aug 2008 16:45:43 +0200
Message-ID: <48986797.5090007__5384.872647892$1217948155$gmane$org@netcom.eu>
References: <Pine.LNX.4.44L0.0808051020220.2518-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0808051020220.2518-100000@iolanthe.rowland.org>
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
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Is there an option to make a patch for the recent 2.6.26.1 kernel, so
that I can use the next 2.6.26.2 kernel instead of waiting a few months
for the next big release?

Thanks David Engraf


Alan Stern wrote:
> On Tue, 5 Aug 2008, Dasgupta, Romit wrote:
>
>   
>> A minor change below: Removed old goto label PMError and introduced SysFSError.
>> Tested with CONFIG_PM, CONFIG_PM_SLEEP, without CONFIG_PM and ofcourse with CONFIG_USB_SUSPEND. Works fine.
>>     
>
> Strictly speaking, I suppose the statement label should be 
> DPMSysfsError.
>
> On the other hand, the corresponding label for
> device_add_class_symlinks() is SymlinkError, not
> DeviceAddClassSymlinksError.  The label for device_add_attrs() is
> AttrsError, not DeviceAddAttrsError.  And the label for
> bus_add_device() is BusError, not BusAddDeviceError.
>
> Following those precedents, it seems appropriate that the label for
> dpm_sysfs_add() should be DPMError.  I'll make the change and submit
> the patch.
>
> Alan Stern
>
>   
