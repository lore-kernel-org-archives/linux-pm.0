From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: cannot resume using USB keyboard/mouse
Date: Sun, 25 Nov 2007 00:18:01 +0200
Message-ID: <200711250018.01883.maximlevitsky@gmail.com>
References: <4747C169.10807@cs.wisc.edu>
	<200711241926.05105.maximlevitsky@gmail.com>
	<47486D72.8080400@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47486D72.8080400@cs.wisc.edu>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 24 November 2007 20:29:06 Ben Liblit wrote:
> Maxim Levitsky wrote:
> > the UHC1-5, EHCI and EHC2 are the usb1.0 resume devices (ports)
> > so I can do
> > 
> > echo "UHC1" > /proc/acpi/wakeup
> > echo "UHC2" > /proc/acpi/wakeup
> > 
> > ....
> 
> Ah hah!
> 

You are welcome.
Note that the names like UHC1 are system depedent,
those are names that are present in ACPI tables,
so you need to read this file first, and then guess which one is which
You can also check the "Sysfs node" column, and then using sysfs or lspci figure out the device function.
But I guess that in your case the USB controllers have same "UHC[1-5]" name.
And btw since most(if not all) keyboard/mice/... are USB 1 devices, the EHCI setting won't work anyway.

Best regards,
	Maxim Levitsky
