From: Jan Scholz <scholz@fias.uni-frankfurt.de>
Subject: Re: [regression,
	bisected] adb trackpad disappears after suspend to ram
Date: Thu, 04 Jun 2009 00:17:54 +0200
Message-ID: <87tz2xynal.fsf__19897.0514153645$1244067825$gmane$org@scholz.fias.uni-frankfurt.de>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<877hzty0hm.fsf@scholz.fias.uni-frankfurt.de>
	<200906032200.55563.rjw@sisk.pl> <200906032220.19915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906032220.19915.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 3 Jun 2009 22:20:19 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Jan Scholz <scholz@fias.uni-frankfurt.de>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Wednesday 03 June 2009, Rafael J. Wysocki wrote:                        
> [--snip--]                                                                 
>>                                                                          
>> In that case I have no idea why it breaks.                               
>
> Well, in fact I think there is an interrupt we shouldn't disable on        
> suspend,                                                                   
> but we need to figure out which one it is.                                 
>
> Can you please send me /proc/interrupts from your system?                  

Here you are:

           CPU0       
 21:         58   MPIC 1    Edge      PMac Output
 24:       3146   MPIC 1    Level     ide1
 25:     145796   MPIC 1    Level     VIA-PMU
 26:         79   MPIC 1    Level     keywest i2c
 29:        196   MPIC 1    Level     ohci_hcd:usb2
 30:          0   MPIC 1    Edge      PMac Input
 39:      22058   MPIC 1    Level     ide0
 40:          2   MPIC 1    Level     ohci1394
 41:          0   MPIC 1    Level     eth0
 42:       3612   MPIC 1    Level     keywest i2c
 47:       5551   MPIC 1    Level     GPIO1 ADB
 48:      18938   MPIC 1    Level     radeon@pci:0000:00:10.0
 52:       5310   MPIC 1    Level     b43
 61:          0   MPIC 1    Edge      Sound Headphone Detection
 63:          0   MPIC 1    Level     ehci_hcd:usb1, ohci_hcd:usb3, ohci_hcd:usb4
BAD:          0
