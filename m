From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/9] PM: Add a switch for
	disabling/enabling	asynchronous suspend/resume
Date: Thu, 10 Sep 2009 20:59:01 +0200
Message-ID: <20090910185901.GB23356__14511.2103237354$1252609319$gmane$org@elf.ucw.cz>
References: <200909100127.11252.rjw@sisk.pl> <200909100138.25839.rjw@sisk.pl>
	<20090910102653.GA30778@atrey.karlin.mff.cuni.cz>
	<200909102056.39903.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909102056.39903.rjw@sisk.pl>
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

On Thu 2009-09-10 20:56:39, Rafael J. Wysocki wrote:
> On Thursday 10 September 2009, Pavel Machek wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Add sysfs attribute kernel/power/pm_async allowing the user space to
> > > disable and enable async suspend/resume of devices.
> > 
> > for bisect reasons, should this go before 5?
> 
> It is set to "enabled" by default, so it shouldn't change bisection results.

Well, 5 enables it, 6 makes it configurable. So if you need async
disabled for a bisect, hitting commit between 5 and 6 will enable it
for you...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
