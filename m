From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Thu, 1 Jul 2010 20:58:20 +0200
Message-ID: <201007012058.20758.rjw@sisk.pl>
References: <1277940699.4138.29.camel@localhost.localdomain>
	<201007010140.08158.rjw@sisk.pl>
	<1277944121.3994.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277944121.3994.1.camel@localhost.localdomain>
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

On Thursday, July 01, 2010, Maxim Levitsky wrote:
> On Thu, 2010-07-01 at 01:40 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 01, 2010, Maxim Levitsky wrote:
> > > Hi,
> > > 
> > > 
> > > This is my desktop, and I don't use it much.
> > > I updated the kernel from 2.6.33 to 2.6.35-rc3, and my usb mouse (usb
> > > 1.1 of course) doesn't wake the system anymore.
> > 
> > Please wait for 2.6.35-rc4 to appear and see if there's any difference.
> Why should I?
> I always compile from git.

Well, you didn't say that.

> Just pulled Linus' tree, and nothing changed.

If you have an Ethernet adapter in that box and you can set up for Wake-on-LAN,
please check if that works.

Rafael
