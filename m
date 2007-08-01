From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 13:18:25 -0300
Message-ID: <20070801161825.GN23111__11515.1456477635$1185986285$gmane$org@khazad-dum.debian.net>
References: <20070801135820.GA8266@mellanox.co.il>
	<Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
	<20070801145607.GB8480@mellanox.co.il>
	<20070801154749.GK23111@khazad-dum.debian.net>
	<20070801155510.GA11758@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070801155510.GA11758@mellanox.co.il>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Cc: len.brown@intel.com, ibm-acpi-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@redhat.com, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, 01 Aug 2007, Michael S. Tsirkin wrote:
> My guess is that upon resume, I normally get some other acpi event
> which gets blocked with CONFIG_THINKPAD_ACPI_INPUT_ENABLED.

*Nothing* should be using any such events like that (that is an bug by
itself), but let's find out if that's what happening first.

acpid logs can probably tell you that.

> > Please open a bug in bugzilla.kernel.org about it, and attach the full debug
> > output of a suspend+resume cycle with and without thinkpad-acpi loaded.
> > 
> > Also, please try the same with thinkpad-acpi loaded, but
> > CONFIG_THINKPAD_ACPI_INPUT_ENABLED set to N.  If the problem goes away,
> > please retest, but set hotkey_enable to 1 and do an "cat
> > /sys/bus/platform/devices/thinkpad_acpi/hotkey_recommended_mask >
> > /sys/bus/platform/devices/thinkpad_acpi/hotkey_mask" before the sleep.
> 
> what's hotkey_enable?

/sys/bus/platform/devices/thinkpad_acpi/hotkey_enable.

Please read the full thinkpad-acpi documentation (it is in
Documentation/thinkpad-acpi.txt in the kernel tree).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
