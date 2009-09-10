From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/9] PM: Asynchronous suspend of devices
Date: Thu, 10 Sep 2009 20:37:50 +0200
Message-ID: <20090910183750.GA23356__935.927549335425$1252608000$gmane$org@elf.ucw.cz>
References: <200909100127.11252.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909100127.11252.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!
> 
> The following series of patches implements asynchronous suspend and resume of
> devices.
> 
> All of the patches have already been discussed, please refer to the changelogs
> for details.
> 
> The patches are targeted at 2.6.33, so if there are no major objections, I'll
> put them into the linux-next branch of the suspend-2.6 tree after .31-rc1 is
> out.

Patches 1-6 look mostly ok to me, I guess you can add my Acked-by. The
rest is fine, too, but I'm not sure if we really need so much of
debugging infrastructure...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
