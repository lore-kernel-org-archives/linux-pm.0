From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Power Mangement Interfaces
Date: Thu, 05 Apr 2007 16:32:04 +0800
Message-ID: <1175761924.23121.38.camel@localhost.localdomain>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703310957.49409.david-b@pacbell.net>
	<1175703359.7388.10.camel@johannes.berg>
	<200704041144.15300.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704041144.15300.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-04-04 at 11:44 -0700, David Brownell wrote:
> On Wednesday 04 April 2007 9:15 am, Johannes Berg wrote:
> > =

> > How would I go about representing the lid as a device?  It's an honest
> > question, I'd actually like to do and replace the /proc/pmu/options file
> > it but don't know where I should put it etc.
> =

> I'm not sure I understand the question.  ACPI has a special "acpi_device"
> node (not backed by any "real" device, PNPACPI etc) with a driver that
> hooks up to the input subsystem.  Same is true for a couple other fixed
> function buttons.  I'd expect non-ACPI platforms would do something very
> similar, except using platform_device and looking less cryptic.
> =

> As for hooking things up to the driver model wakeup event stuff, ACPI
> doesn't do that yet.  I've got some patches in the works;
Good to know. Please add linux-acpi@vger.kernel.org to the cc list when
you want to send them out. :>

Thanks,
Rui
