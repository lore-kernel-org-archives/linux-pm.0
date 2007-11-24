From: Ben Liblit <liblit@cs.wisc.edu>
Subject: Re: cannot resume using USB keyboard/mouse
Date: Sat, 24 Nov 2007 12:29:06 -0600
Message-ID: <47486D72.8080400@cs.wisc.edu>
References: <4747C169.10807@cs.wisc.edu>
	<200711241926.05105.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711241926.05105.maximlevitsky@gmail.com>
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

Maxim Levitsky wrote:
> the UHC1-5, EHCI and EHC2 are the usb1.0 resume devices (ports)
> so I can do
> 
> echo "UHC1" > /proc/acpi/wakeup
> echo "UHC2" > /proc/acpi/wakeup
> 
> ....

Ah hah!

Echoing EHCI and EHC2 into that file has no affect on my system; they 
remain disabled.  But enabling UHC[1-5] works, and my system now resumes 
on USB key presses and mouse clicks as desired.

Thank you very much for your help, Maxim!
