From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] PM: Asynchronous suspend and resume of
	devices
Date: Thu, 27 Aug 2009 21:17:52 +0200
Message-ID: <200908272117.52931.rjw__43730.9625944637$1251401070$gmane$org@sisk.pl>
References: <200908262217.19609.rjw@sisk.pl> <200908270025.34821.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908270025.34821.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 August 2009, Rafael J. Wysocki wrote:
> On Wednesday 26 August 2009, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following patches introduce a mechanism allowing us to execute device
> > drivers' suspend and resume callbacks asynchronously during system sleep
> > transitions, such as suspend to RAM.
> > 
> > The idea is explained in the changelogs of the first two patches.
> > 
> > Comments welcome.
> 
> Forgot to say, the patchset is on top of the linux-next branch of suspend-2.6.

I have two more patches in this series.  The first one introduces a sysfs
switch allowing the user space to block the async suspend/resume.  The second
one gives the user space access to the power.async_suspend flag of devices
through sysfs.

The patches will follow in the next messages.

Thanks,
Rafael
