From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] usb: avoid PM error messages during resume
	if a device was disconnected
Date: Mon, 23 Mar 2009 22:30:18 +0100
Message-ID: <200903232230.19330.elendil__43258.9595475749$1237844152$gmane$org@planet.nl>
References: <200903232211.51154.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903232211.51154.elendil@planet.nl>
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
To: linux-usb@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 23 March 2009, Frans Pop wrote:
> Currently if a laptop is suspended e.g. while docked and then resumed
> after undocking it, the following errors get generated because the USB
> hub in the docking station and the devices connected to it are no
> longer available:
> pm_op(): usb_dev_resume+0x0/0x10 returns -19 
> PM: Device 1-2 failed to resume: error -19
> pm_op(): usb_dev_resume+0x0/0x10 returns -19
> PM: Device 1-2.2 failed to resume: error -19
> pm_op(): usb_dev_resume+0x0/0x10 returns -19
> PM: Device 1-2.3 failed to resume: error -19
>
> As the removal of USB devices while a system is suspended is a
> relatively common use case and in most cases not an error, just return
> success on -ENODEV. The user gets informed anyway as the USB subsystem
> generates regular disconnect messages for the devices shortly
> afterwards:
> usb 1-2: USB disconnect, address 3 
> usb 1-2.2: USB disconnect, address 4
> usblp0: removed
> usb 1-2.3: USB disconnect, address 5
>
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>

Forgot to mention that the patch is intended on top of Rafael's "Rework 
disabling of interrupts during suspend-resume" series.
