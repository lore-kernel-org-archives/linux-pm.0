From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Summary of today's IRC discussion
Date: Fri, 18 Mar 2005 01:25:34 +0100
Message-ID: <20050318002533.GA7038@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503171331071.855-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90956712085102787=="
In-Reply-To: <Pine.LNX.4.44L0.0503171331071.855-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============90956712085102787==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Note: the live IRC log is available (thanks to Bernard!) at
> <http://helicon.ucs.uwa.edu.au/~bernard/irc/%23pm.log>.

First, sorry for my more or less non-presence. I had too much to do
and too little time, too much rain and not enough signal.

To nigel: No, I'm not going to do cpu hotplug on my scrap-metal smp
system. It took 2 hours to build ;-).

[I still hope to get that S3/smp support using cpu hotplug in my
mailbox tommorow morning ;-)]

At one point I asked:
21:52:11< pavelm> I was playing with variable scheduling ticks here, hoping to save some power.
21:52:31< pavelm> How big power savings should I expect?
21:52:48< pavelm> What cpu will benefit most?
21:53:04< pavelm> Is there easy way to measure it?
...noone replied. Does anyone know?

>From reviewing the logs... There's big difference between system sleep
state, and cpu sleep state. It seems to me that Arm "deep sleep" is
more cpu sleep state (which may have some implications outside cpu,
but device is still perceived as functional). That's really different
thing from PC-style suspend to RAM (takes 5 seconds to sleep and
wakeup, and device is not usefull while suspended). I agree that for
arm "deep sleep" vetoing etc makes sense.

We should be carefull to separate cpu sleep states from system sleep
states...

jcrouse: Any small machine would certainly be very welcome. I have
sharp zaurus here, but it is a) getting quite old and b) I use it so
much I don't dare hack it.

> A good way of doing state transformations is needed.  The important case
> is going from generic system states (Standby, STR, STD) to device states.  
> Often ACPI can help provide such a mapping, but many systems don't support
> ACPI and sometimes the ACPI mappings are wrong.  There should be a way to
> override them from userspace, say at boot time.  Also ACPI only knows
> about devices on the motherboard.  But when available (and appropriate!)
> it makes a good starting point.
> 
> In many situations these mapping can be done at the bus level so
> device drivers don't need to worry about it.  There may also be a set
> of mappings available for a device to use, like "PCI", "ACPI",
> "Custom",...

I think this is overdoing it. Most devices go to lowest possible state
for suspend-to-RAM; I'm not sure what ACPI has to say about that,
but... Having 

pci_power_t acpi_please_suggest_good_state(pm_message_t *state, struct
pci_dev *me)

...and similar helpers would probably not hurt, but I doubt they'll
get many users.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============90956712085102787==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90956712085102787==--
