From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Wed, 7 Jul 2010 01:05:09 +0200
Message-ID: <201007070105.10082.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1007061300580.1327-100000@iolanthe.rowland.org>
	<1278449506.3793.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278449506.3793.8.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 06, 2010, Maxim Levitsky wrote:
> Ok, it seems that recent changes really did made /proc/acpi/wakeup
> unnecessary.
> 
...
> 
> I also think that I shouldn't need to set wakeup to enabled on usb
> controller. This should be done automaticly as soon as I set 'enabled'
> on usb device.

That would probably require us to redesign things so that wakeup reference
counters are used instead of the should_wakeup bit.

Rafael
