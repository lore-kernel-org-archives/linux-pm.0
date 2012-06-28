From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: a few questions about Runtime PM
Date: Thu, 28 Jun 2012 09:58:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206280953460.1752-100000@iolanthe.rowland.org>
References: <4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3@SCYBEXDAG03.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D0BDB1B0D72DF43A9D4C0B62FC1DDDE028423D3@SCYBEXDAG03.amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Zhang, QianFeng" <QianFeng.Zhang@amd.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Jun 2012, Zhang, QianFeng wrote:

>             I am looking through the IO device Runtime PM implementation on Linux (Fedora 16).  There are some questions that
> need you help to clarify for me,  here they are

Please tell your email client to wrap lines after 72 columns or so.

> 1)       For those IO devices that could not be waked up through ACPI GPEs or native PCI Express PME ,  can  Runtime suspend/resume be used ?

Yes, it can be used.  If the drivers need wakeup support then the
devices have to have some other wakeup mechanism, such as an IRQ.  If 
the drivers don't need wakeup support then obviously the device doesn't 
have to provide it.

> 2)       In  rtl8169's implementation of  Runtime suspend/resume, there is a  routine rtl8169_check_link_status(), which  always invokes
>        pm_schedule_suspend() if the Link line is dis-connected,  pm_request_resume() if the Link line is connected.  And rtl8169_check_link_status
>       itself is called through the transmit time out handler, which invokes rtl8169_reset_task.     So rtl8169_check_link_status,  as an opportunity point
>        for Runtime PM for its network interface ,  does not require any  wake-up signaling, right?   The only Hardware Level requirement for rtl1869_check_link_status
>        to work in this way is  that  the  link status register can always be read  no matter the network interface is in  off or on status.

I don't know the answers to these questions.

> 3)      How should the Block IO adapter devices like the SCSI Controller or FC Adapters  should do  Runtime PM ?   In my understand,  these
>       Devices should be auto-suspended when there is no IO request pending for a predefined duration,  and they should be resumed when
>      a new IO request issued by the block layer.  So these devices may use a different wake up method that has no dependency on  PCI Express PME or
>      ACPI GPE.

I don't know about FC adapters.  SCSI controllers do not need wakeup.

Alan Stern
