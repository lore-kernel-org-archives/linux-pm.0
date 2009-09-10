From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/9] PM: Add a switch for disabling/enabling
	asynchronous suspend/resume
Date: Thu, 10 Sep 2009 20:56:39 +0200
Message-ID: <200909102056.39903.rjw__46759.8866242499$1252609149$gmane$org@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl> <200909100138.25839.rjw@sisk.pl>
	<20090910102653.GA30778@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090910102653.GA30778@atrey.karlin.mff.cuni.cz>
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
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Add sysfs attribute kernel/power/pm_async allowing the user space to
> > disable and enable async suspend/resume of devices.
> 
> for bisect reasons, should this go before 5?

It is set to "enabled" by default, so it shouldn't change bisection results.

Thanks,
Rafael
