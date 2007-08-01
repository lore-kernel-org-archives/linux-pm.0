From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 17:56:07 +0300
Message-ID: <20070801145607.GB8480__37023.7184725285$1185985171$gmane$org@mellanox.co.il>
References: <20070801135820.GA8266@mellanox.co.il>
	<Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hugh Dickins <hugh@veritas.com>
Cc: len.brown@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@redhat.com, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Borislav Deianov <borislav@users.sourceforge.net>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

> Quoting Hugh Dickins <hugh@veritas.com>:
> Subject: Re: 2.6.21-rc1: T60 ACPI issues
> 
> On Wed, 1 Aug 2007, Michael S. Tsirkin wrote:
> 
> > Hi!
> > ACPI appears to have been broken with 2.6.23-rc1 on my T60
> > Userspace from ubuntu dapper.
> 
> (Whereas I'm using a T43p with openSUSE 10.2.)
> 
> > 
> > 1. During boot, I see a lot of messages like this:
> > [   41.034204] acpi LNXSYSTM:00: uevent: unsupported action-string; this will be ignored in a future kernel version
> 
> (I've not seen those.)
> 
> > 
> > 2. Pressing Fn/F4 does not trigger suspend to ram
> >    This normally triigers ACPI event which triggers suspend to RAM on Ubuntu
> >    (echo mem > /sys/power/state works)
> 
> I'll bet this is your CONFIG_THINKPAD_ACPI_INPUT_ENABLED=y.
> I got the same, see my "THINKPAD_ACPI_INPUT_ENABLED seems regressive"
> mail to Henrique and lkml an hour ago.

This? http://lkml.org/lkml/2007/8/1/176


> > 
> > 3. After suspend to RAM, system wakes up but laptop's screen is blank,
> >    switching VTs etc does not help.
> >    External screen wakes up OK though.
> >    dmesg output from boot attached.
> 
> (I've not had that.)

Bingo.
sudo rmmod thinkpad_acpi cures both 2 and 3.
Thanks for pointing this out.

Henrique, if there's a patch to test, pls let me know.
Or maybe CONFIG_THINKPAD_ACPI_INPUT_ENABLED should be N by default.

-- 
MST
