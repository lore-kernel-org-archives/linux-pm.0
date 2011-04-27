From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 10:49:47 -0700
Message-ID: <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 26, 2011 at 10:22 PM, MyungJoo Ham <myungjoo.ham@samsung.com> w=
rote:
> Hello,
>
> 2011/4/26 Rafael J. Wysocki <rjw@sisk.pl>:
>> Hi,
>>
>> To start with let me say I don't have any fundamental objections at this=
 point,
>> although I'm not 100% sure I understand correctly how this feature is su=
pposed
>> to be used. =A0My understanding is that if a device is known to have mul=
tiple
>> OPPs, its subsystem and driver may call dvfs_add_device() for it, which =
will
>> cause it to be periodically monitored and put into the "optimum" OPP usi=
ng
>> the infrastructure introduced by your patch (on the basis of the given
>> usage profile and with the help of the given governor). =A0Is that corre=
ct?
>
> Yes, that is correct.

I'm a little confused about the design for this, and OPP as well.  OPP
matches a struct device * and a frequency to a voltage, which is not a
generically useful pairing, as far as I can tell.  On Tegra, it is
quite possible for a single device to have multiple clocks that each
have different voltage requirements, for example the display block can
have an interface clock as well as a pixel clock.  Simplifying this to
dev + freq =3D voltage seems very OMAP specific, and will be difficult
or impossible to adapt to Tegra.

Moreover, from a silicon perspective, there is always a simple link
from a single frequency to a minimum voltage for a given circuit.
There is no need to group them into OPPs, which seem to have a group
of clocks and their frequencies that map to a single voltage.  That is
an artifact of the way TI specifies voltages.

I don't think DVFS is even the right place for any sort of governor.
DVFS is very simple - to increase to a specific clock speed, the
voltage must be immediately be raised, with minimum or no delay, to a
specified value that is specific to that clock.  When the frequency is
lowered, the voltage should be decreased.  There is a tiny bit of
policy to determine when to delay dropping the voltage in case the
frequency will immediately be raised again, but nowhere near the
complexity of what is shown here.

I proposed in a different thread on LKML that DVFS be handled within
the generic clock implementation.  Platforms would register a
regulator and a table of voltages for each struct clock that required
DVFS, and the voltages would be changed on normal clk_* requests.
This maintains compatibility with existing clk_* calls.

There is a place for a GPU, etc., frequency governor, but it is a
completely separate issue from DVFS, and should not be mixed in.  I
could have a GPU that is not voltage scalable, but could still benefit
from lowering the frequency when it is not in use.  A devfreq
interface sounds perfect for this, as long as it only ends up calling
clk_* functions, and those functions handle getting the voltage
correct.
