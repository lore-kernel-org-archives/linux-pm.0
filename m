From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/9] PM: Asynchronous suspend of devices
Date: Thu, 10 Sep 2009 20:43:56 +0200
Message-ID: <200909102043.56993.rjw__45364.3651133918$1252608309$gmane$org@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl>
	<20090910183750.GA23356@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090910183750.GA23356@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 10 September 2009, Pavel Machek wrote:
> Hi!
> > 
> > The following series of patches implements asynchronous suspend and resume of
> > devices.
> > 
> > All of the patches have already been discussed, please refer to the changelogs
> > for details.
> > 
> > The patches are targeted at 2.6.33, so if there are no major objections, I'll
> > put them into the linux-next branch of the suspend-2.6 tree after .31-rc1 is
> > out.
> 
> Patches 1-6 look mostly ok to me, I guess you can add my Acked-by.

Thanks!

> The rest is fine, too, but I'm not sure if we really need so much of
> debugging infrastructure...

I believe it will be useful.

Thanks,
Rafael
