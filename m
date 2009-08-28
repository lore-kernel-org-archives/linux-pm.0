From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 7 updated] PM: Add a switch for
	disabling/enabling asynchronous suspend/resume
Date: Fri, 28 Aug 2009 21:42:05 +0200
Message-ID: <200908282142.05812.rjw__4926.16349733925$1251488523$gmane$org@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl> <200908280022.40522.rjw@sisk.pl>
	<20090828055520.E561A526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090828055520.E561A526EC9@mailhub.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 28 August 2009, Dmitry Torokhov wrote:
> On Fri, Aug 28, 2009 at 12:22:40AM +0200, Rafael J. Wysocki wrote:
> > +/* kernel/power/main.c */
> > +extern int pm_async_enabled;
> >  
> 
> Sorry, forgot about this in the first mail - why don't we make it a
> bool?

I didn't do that because of the

sprintf(buf, "%d\n", pm_async_enabled)

in pm_async_show(), where it clearly is treated as an int.

Thanks,
Rafael
