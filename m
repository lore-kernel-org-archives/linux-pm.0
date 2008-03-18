From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 3/3] PM: New suspend and hibernation
	callbacks for	PCI bus type
Date: Tue, 18 Mar 2008 11:02:56 +0100
Message-ID: <20080318100256.GC10830__29617.3980845653$1205840972$gmane$org@elf.ucw.cz>
References: <200803170020.55473.rjw@sisk.pl> <200803170025.16149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803170025.16149.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon 2008-03-17 00:25:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Implement new suspend and hibernation callbacks for the PCI busi type.

"bus", I guess.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> ---
>  drivers/pci/pci-driver.c |  497 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pci.h      |    2 
>  2 files changed, 453 insertions(+), 46 deletions(-)

...but big, too :-(.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
