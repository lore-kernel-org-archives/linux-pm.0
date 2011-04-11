From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Mon, 11 Apr 2011 13:07:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104111306310.1975-100000@iolanthe.rowland.org>
References: <BANLkTi=Q8N-=gjiS6M1b-krjqceVHfk8GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=Q8N-=gjiS6M1b-krjqceVHfk8GQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Apr 2011, Jiejing.Zhang  wrote:

> Hi,
> 
> Does anyone have comments on this driver?
> 
> Best regards,
> Zhang Jiejing
> 
> 
> 2011/4/7 Jiejing Zhang <kzjeef@gmail.com>
> 
> > From: Zhang Jiejing <jiejing.zhang@freescale.com>
> >
> > This patch add function to check each device's suspend time
> > consumption. If any driver takes more time that the threshold (default
> > 0.5 ms), it will print a warnning message including the device and bus
> > name on the console.  You can change the threshold on-the-fly by
> > modify file '/sys/power/device_suspend_time_threshold' to adjust this
> > value,the unit is in microsecond.

Bear in mind that rotating disk drives typically take several hundred 
milliseconds to spin down.  The warning would always trigger.  That 
doesn't seem particularly useful.

Alan Stern
