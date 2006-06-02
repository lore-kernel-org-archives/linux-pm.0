From: <rasmit.ranjan@wipro.com>
Subject: Problem in HCD resume
Date: Fri, 2 Jun 2006 17:38:24 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201F695B0@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi,
	I was trying suspend/resume of OHCI based host controller. I
suspend the device interface, device/port and the roothub interface/bus
selectively through sysfs.
According to Power Management sub-system if I resume the roothub
interface the all the downsteam devices( device/port and device
interface) should be resumed. That means power state file of
roothub,port/device,device interface should be 0. But power state of the
port/device remains 3. 
	I tried finding out the reasons. I went through the kernel code.
What I found out is, resuming any node is initiated through
usb_generic_device API. In that API first we change the
dev->power.power_state.event = PM_EVENT_ON which is the notification to
PM sub-system that now the device is not in suspended state, it is on
now and the power state file of the node is changed to 0. When I traced
the path for my case i.e. resuming the bus.
Here it goes:

Usb_generic_resume-->hub_resume-->hcd_bus_resume-->ohci_bus_resume-->fin
ish_device_resume.

Actually finish_device_resume is called from hub_resume and the
parameter passed to finish_device_resume is the usb_device structure
representing the device connected. Then for all the interfaces of the
device finish_device_resume calls usb_generic_resume.
So it is clear that expect the device all other node`s resume is
initiated from usb_generic_resume and this is the only API which does
dev->power.power_state.event = PM_EVENT_ON. As for device resume this is
not done, its power state remains 3 although the device is actually
resumed. 

Is my understanding correct? If yes then is it a known issue ? I am
using kernel 2.6.15.4.
So is ther any patch available for this?

Please suggest.

Thanks,
Rasmit.
    


_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
