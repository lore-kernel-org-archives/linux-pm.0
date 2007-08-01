From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 18:55:10 +0300
Message-ID: <20070801155510.GA11758__22854.8200837851$1185983792$gmane$org@mellanox.co.il>
References: <20070801135820.GA8266@mellanox.co.il>
	<Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
	<20070801145607.GB8480@mellanox.co.il>
	<20070801154749.GK23111@khazad-dum.debian.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070801154749.GK23111@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: len.brown@intel.com, ibm-acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@redhat.com, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

> Quoting Henrique de Moraes Holschuh <hmh@hmh.eng.br>:
> Subject: Re: 2.6.21-rc1: T60 ACPI issues
> 
> (CC changed from Borislav to ibm-acpi-devel).
> 
> On Wed, 01 Aug 2007, Michael S. Tsirkin wrote:
> > > > 2. Pressing Fn/F4 does not trigger suspend to ram
> > > >    This normally triigers ACPI event which triggers suspend to RAM on Ubuntu
> > > >    (echo mem > /sys/power/state works)
> > > 
> > > I'll bet this is your CONFIG_THINKPAD_ACPI_INPUT_ENABLED=y.
> > > I got the same, see my "THINKPAD_ACPI_INPUT_ENABLED seems regressive"
> > > mail to Henrique and lkml an hour ago.
> 
> [...]
> 
> > > > 3. After suspend to RAM, system wakes up but laptop's screen is blank,
> > > >    switching VTs etc does not help.
> > > >    External screen wakes up OK though.
> > > >    dmesg output from boot attached.
> > > 
> > > (I've not had that.)
> > 
> > Bingo.
> > sudo rmmod thinkpad_acpi cures both 2 and 3.
> > Thanks for pointing this out.
> 
> I can see how it would help with (2), as that prompty tells the firmware to
> issue its default ACPI events for Fn+F4 upon removal.  But I have *NO* idea
> what thinkpad_acpi might be doing that is causing issues with the wake up
> after a resume.

My guess is that upon resume, I normally get some other acpi event
which gets blocked with CONFIG_THINKPAD_ACPI_INPUT_ENABLED.

> Please open a bug in bugzilla.kernel.org about it, and attach the full debug
> output of a suspend+resume cycle with and without thinkpad-acpi loaded.
> 
> Also, please try the same with thinkpad-acpi loaded, but
> CONFIG_THINKPAD_ACPI_INPUT_ENABLED set to N.  If the problem goes away,
> please retest, but set hotkey_enable to 1 and do an "cat
> /sys/bus/platform/devices/thinkpad_acpi/hotkey_recommended_mask >
> /sys/bus/platform/devices/thinkpad_acpi/hotkey_mask" before the sleep.

what's hotkey_enable?

> You will probably need to enable a bunch of debug options in ACPI and
> thinkpad-acpi to get good enough logs.  It is probably worth posting the
> acpid logs too: the real difference might be there.

-- 
MST
