From: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 15:24:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011516540.15447__21095.1229710647$1185985158$gmane$org@blonde.wat.veritas.com>
References: <20070801135820.GA8266@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801135820.GA8266@mellanox.co.il>
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
Cc: len.brown@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@linux-foundation.org, linux-acpi@vger.kernel.org, mingo@redhat.com, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Michael S. Tsirkin wrote:

> Hi!
> ACPI appears to have been broken with 2.6.23-rc1 on my T60
> Userspace from ubuntu dapper.

(Whereas I'm using a T43p with openSUSE 10.2.)

> 
> 1. During boot, I see a lot of messages like this:
> [   41.034204] acpi LNXSYSTM:00: uevent: unsupported action-string; this will be ignored in a future kernel version

(I've not seen those.)

> 
> 2. Pressing Fn/F4 does not trigger suspend to ram
>    This normally triigers ACPI event which triggers suspend to RAM on Ubuntu
>    (echo mem > /sys/power/state works)

I'll bet this is your CONFIG_THINKPAD_ACPI_INPUT_ENABLED=y.
I got the same, see my "THINKPAD_ACPI_INPUT_ENABLED seems regressive"
mail to Henrique and lkml an hour ago.

> 
> 3. After suspend to RAM, system wakes up but laptop's screen is blank,
>    switching VTs etc does not help.
>    External screen wakes up OK though.
>    dmesg output from boot attached.

(I've not had that.)

Hugh
