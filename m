From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 20:19:53 +0200
Message-ID: <48DA84C9.3010707__38920.7692388029$1222280864$gmane$org@gmail.com>
References: <48DA64FC.4020706@gmail.com>
	<Pine.LNX.4.44L0.0809241229070.5963-100000@iolanthe.rowland.org>
	<20080924181403.GA6336@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080924181403.GA6336@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 09/24/2008 08:14 PM, Greg KH wrote:
> On Wed, Sep 24, 2008 at 12:38:45PM -0400, Alan Stern wrote:
>> On Wed, 24 Sep 2008, Jiri Slaby wrote:
>>
>>>> In fact neither of those logs includes USB debugging messages.  Maybe
>>>> you omitted a mkinitrd step.
>>> I don't think so. I don't use neither vanilla nor initrd so this must be the
>>> kernel. Anyway I recompiled with .config linked in and did
>>> # dmesg >dmesg_config.hcd
>>> # zcat /proc/config.gz >>dmesg_config.hcd
>>> in the built kernel. The file is here:
>>> http://decibel.fi.muni.cz/~xslaby/dmesg_config.hcd
>> Still no debugging messages.  It's because you have 
>> CONFIG_DYNAMIC_PRINTK_DEBUG enabled.
> 
> If you have that enabled, you can turn on debugging "on the fly" by
> writing to the debugfs file as described in the documentation for that
> option.

I see, I need to boot to that kernel anyway, with dynamic_printk param this time.

Thanks.
