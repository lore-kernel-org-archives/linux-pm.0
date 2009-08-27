From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/6] PM: Allow serio input devices to
	suspend/resume asynchronously
Date: Thu, 27 Aug 2009 22:58:35 +0200
Message-ID: <200908272258.35861.rjw__28135.9588647776$1251406735$gmane$org@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl> <200908262224.19110.rjw@sisk.pl>
	<20090827204106.1132B526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827204106.1132B526EC9@mailhub.coreip.homeip.net>
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

On Thursday 27 August 2009, Dmitry Torokhov wrote:
> On Wed, Aug 26, 2009 at 10:24:19PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Set async_suspend for all serio input devices, so that they can be
> > suspended and resumed asynchronously with other devices they don't
> > depend on in a known way (i.e. devices which are not their parents
> > or children and to which they are not connected via struct pm_link
> > objects).
> > 
> 
> As I mentioned not yet, please - i8042 may be unhappy if you pound
> all its ports at once. I should have a solution for it though.

OK, I'll drop this patch.

Thanks,
Rafael
