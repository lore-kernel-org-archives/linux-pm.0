From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Fri, 15 Apr 2011 00:53:36 +0200
Message-ID: <201104150053.37037.rjw__5059.74892662397$1302821632$gmane$org@sisk.pl>
References: <20110414222525.GA24365@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110414222525.GA24365@mac.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, April 15, 2011, Tino Keitel wrote:
> Hi,
> 
> with 2.6.38, I enabled wakeup from suspend to RAM with the USB keyboard
> this way:
> 
> echo USB2 > /proc/acpi/wakeup
> 
> This does not work anymore with 2.6.39-rc3. Wakeup using the keyboard
> won't work, and the USB2 line in /proc/acpi/wakeup doesn't change to
> "enabled" after the echo command.
> 
> Is this intended? If yes, what is the new way to enable keyboard
> wakeup?

No, it's supposed to work IIRC.  I'll have a look at that code tomorrow.

Thanks,
Rafael
