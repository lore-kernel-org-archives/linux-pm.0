From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy	inputs
Date: Mon, 28 Apr 2008 19:54:13 -0300
Message-ID: <20080428225413.GD3489__23811.2202533104$1209423422$gmane$org@khazad-dum.debian.net>
References: <200803201408.33466.david-b@pacbell.net>
	<1209386885.884.9.camel@yakui_zhao.sh.intel.com>
	<20080428213553.GA3489@khazad-dum.debian.net>
	<200804281520.05683.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804281520.05683.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Apr 2008, David Brownell wrote:
> > Which calls for a new standard interface to let userpace control that,
> > doesn't it?  Issues with wake-up devices are not uncommon, the user

[...]

> That "new standard interface" has been in the kernel for quite
> some time now:  /sys/devices/.../power/wakeup attributes, which
> default to "enabled" for wake-capable devices.  Set to "disabled"
> if it's not behaving on your system for some reason.  It's part
> of the driver model infrastructure.

Ok.  That answers my point.  Can we override the defaults with whatever
information ACPI might have about them?

I certainly would not expect (or appreciate) that this:

$ cat /proc/acpi/wakeup 
Device  S-state   Status   Sysfs node
LID       S3    *enabled   
SLPB      S3    *enabled   
UART      S3     disabled  pnp:00:09
EXP0      S4     disabled  pci:0000:00:1c.0
EXP1      S4     disabled  
EXP2      S4     disabled  pci:0000:00:1c.2
EXP3      S4     disabled  
PCI1      S4     disabled  pci:0000:00:1e.0
USB0      S3     disabled  pci:0000:00:1d.0
USB1      S3     disabled  pci:0000:00:1d.1
USB3      S3     disabled  pci:0000:00:1d.3
USB7      S3     disabled  pci:0000:00:1d.7
AC9M      S4     disabled  

(which is mostly following what I told the BIOS to do), to suddely have
more lines set to "enable" :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
