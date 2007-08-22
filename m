From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [discuss] [RFC][PATCH -mm 2/4] Hibernation: Turn on
	ACPI during restore if necessary
Date: Wed, 22 Aug 2007 22:47:57 +0200
Message-ID: <200708222247.57714.rjw@sisk.pl>
References: <200708201510.03734.rjw@sisk.pl> <200708211639.02204.rjw@sisk.pl>
	<20070821233629.GA3706@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070821233629.GA3706@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: discuss@x86-64.org
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 22 August 2007 01:36, Pavel Machek wrote:
> On Tue 2007-08-21 16:39:01, Rafael J. Wysocki wrote:
> > On Tuesday, 21 August 2007 09:57, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > If the boot kernel doesn't support ACPI and ACPI is not enabled by the platform
> > > > boot code, it may be possible to enable ACPI after restoring the system memory
> > > > from a hibernation image.  Implement that.
> > > 
> > > ACK... and I guess this should go in early. It is possible to test w/o
> > > rest of patches, (just pass acpi=off to resume kernel, no?),
> > 
> > Yup, that might work.
> > 
> > > and it  should get lot of testing.
> > 
> > Why do you think so?
> 
> Anything that touches acpi is almost guaranteed to produce nice
> fireworks :-). Okay, maybe I'm too paranoid.

Well, there's a catch, but it requires quite a bit more patching.

Namely, some ACPI code may be called from within CPU hotplug, so in
principle we should enable ACPI before that.  Fortunately, on contemporary SMP
machines ACPI is usually enabled by the BIOS, AFAICS, so that should not be
an issue.

Still, I have some patches that handle it, among other things.  I think I'll
just post them (tomorrow).

Greetings,
Rafael
