From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: comments on irc log
Date: Fri, 18 Mar 2005 13:32:11 +1100
Message-ID: <1111113131.25179.73.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3016474973334542=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============3016474973334542==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Folks !

Sorry, I couldn't make it for a 2am meeting, and I suspect I had way too
much Guiness in my system to be useful at midnight anyway yesterday :)

I've browsed the IRC log and have a few notes/comments/replies:

21:38:01< pavelm> At one point someone at intel was looking onto s-t-ram on smp machine...
21:38:13< pavelm> ...is he/she still working on that?
21:38:51< pavelm> Airplane-like machine was toshiba laptop; I did nnot open it.
21:39:24< pavelm> DC=dual core... aha, I parsed it wrong.

Pavel: Paulus has that working on an SMP PowerMac. The simplest/safest way to do that
is to implement some kind of hotplug CPU (even if the CPU isn't physically turned off,
just "park" it in some kind of sleep loop or so), and only trigger the system-wide STR
after you have stopped all CPUs but one. He left usrland the responsibility to do that.

Of course, it also depends how the wakeup works on SMP systems, I suspect it's fairly
platform specific. On those macs, all CPUs come up in ROM, and the ROM keeps all but
one in a sleep loop, like on boot, and we get them back with a soft-reset, like on boot.

21:43:34< nigel> Luming: I was meaning one where the chip itself gets completely powered down and needs a complete reconfigure on wake.
21:43:39< pavelm> ;-< well, when BIOS at least posts the card, things are easy.

Note that I have some code for POST'ing some radeon's that might be adapt-able. The only
"issue" is I don't know how to extract from the x86 BIOS ROM the proper sequence of values
for the SDRAM mode register (SDRAM chip init). This is write-only obviously so I can't just
read the values before sleep and POST the chip with those like I do for the rest of the
chip. I know values for Mac laptops, not x86.

21:52:11< pavelm> I was playing with variable scheduling ticks here, hoping to save some power.
21:52:31< pavelm> How big power savings should I expect?
21:52:48< pavelm> What cpu will benefit most?
21:53:04< pavelm> Is there easy way to measure it?

I played with that too on some PPCs and was surprised by the absence of benefit, but I might
have done something wrong, I need to instrument the stuff better.



23:26:39< nigel> I wonder if we should just have an enter_state() call.
23:26:59< mochel> nigel: that's been suggested before 
23:27:00< db> nigel:  enter_state(state) would then be suspend(state)???
23:27:06< mochel> yes

I have this crazy idea that we could have a single "new" enter_state(), and keep
suspend/resume for system state transitions.

Basically, my idea there is that enter_state() is the actual low level driver
state change function. It is called when userland picks a state in sysfs, or
we could deal with the various bus state dependencies if we want etc...

We could keep suspend/resume separate for the system-wide suspend, and have
them implement the policy of converting a system wide suspend/resume into the
appropriate enter_state() for the driver.

"Old" or "Simple" drivers would just suspend/resume and not implement
enter_state, more complex/subtle drivers would do the above.

I haven't quite thought out the implications, it's just an idea that came to mind
as I was reading the log...
 
23:27:23< alan> nigel: The PM core still needs to tell suspends and resumes apart.
23:27:38< nigel> You mean system states, or run time?
23:27:41 * lenb returns
23:27:42< alan> Whether they use separate callbacks is an implementation detail.
23:27:47< nigel> I'm thinking of both.
23:27:56< mochel> the core only needs system states 
23:28:05< jcrouse> right
23:28:22< db> mochel: if core only needs S0/S1/S2... [ sticking to ACPI model for the moment]
23:28:25< mochel> it then should tell the drivers that they need to enter a state compatible w/ that system state
23:28:27< nigel> True. But the state a driver is in is affected by both.

I think system states, driver/device states and bus states are 3 different things.

I would say a scenario is:

 - Driver picks a device state based on a system state
 - Bus states updates based on child device states
 - Bus state might be force-able in which case it triggers child device states  changes

Bus states could be bus-type specific. Drivers could represent an array of states with names
as I proposed, with a dependency to bus states explained as bit masks (optionally maybe a
function to resolve dependencies for drivers that have special constraints ?)

Policy of what device state to chose for system state is driver specific, could be done the
way I exposed above with my idea of separating suspend/resume from enter_state.

Again, just crazy ideas coming to mind as I read. I'm still recovering from St Patrick's
night :)

23:28:38< alan> The core needs to know about system states, but sysfs needs to understand runtime states a little.
23:28:54< mochel> sysfs is not really an issue
23:28:56< db> mochel: then we need separate layers for driver-specific states D0/D1/D2/... yes?
23:29:03< mochel> db: yes
23:29:17< mochel> we can and should export each bus-specific range of states through sysfs
23:29:25< mochel> (through the devices directories) 
23:29:38< db> So a given system will have (a) system states, (b) driver states, often bus-specific ...

Heh, funny, close to what I wrote :) Yes, I think we need to separate those, and I would
even split bus states & driver states. Drivers can have plenty of local states that aren't
bus specific (they can have a rich set of local PM states I mean) and the bus would
eventually only create a dependency to some of those stats.

BTW. David, can't your clock stuff be simply represented in terms of bus & device states as
well ? In most case, it's not PCI, so it could be defined as special bus types with states
matching the various clock states.
 
23:29:40< mochel> i.e. each bus type should export states for that device
23:29:53< db> ... all using the same pointer type
23:29:58< mochel> then we need a userspace utility that distinguishes between them
23:30:15< nigel> Don't you then end up with some ugly mess inside drivers where you figure out what to do for different combinations of  runtime and system states?
23:30:28< mochel> nigel: yes, but better there than in the core
23:30:34< mochel> we can provide helpers in the buses
23:30:44< mochel> because most devices will be the same 
23:31:01 * mochel will be back in 2 minutes 
23:31:10< jcrouse> If the bus handled the system state -> device state translation, then it makes the drivers much easier

I think the driver should choose, but we could provide "defaults" for drivers who don't
want to bother.

23:31:11< db> so that makes a third way to use states:  transform them
23:31:18< nigel> Hmmm... I suppose you can't avoid that... ok.
23:31:20< bernard> Also, should transitions be restricted to only to/from the "on" state (whatever that may be, eg D0)? Or should there be some wrapper code for suspend/enter_state that first puts the device back into D0, then suspend?

No, system states are, device states are more flexible. Devices and busses can have specific restrictions
(like PCI spec mandates a transition to D0 iirc when coming from a deeper state) but that is to be
handled locally, either at the bus or device level.

23:31:42< db> not all busses are as regular as PCI or USB, note ... platform devices on embedded hardware, e.g.
23:32:15< db> bernard:  gaack.  please, no arbitrary restrictions.  busses may have some though.
23:32:21< nigel> I'm not sure about enforcing going to full power first.
23:32:34< alan> Wrapper code is up to the driver.

Agreed.

23:33:02< db> nigel: I'm sure about NOT enforcing it.  E.g. for PCI, unless driver needs it, D1 to D2 is fine.
23:33:09< nigel> :>
23:33:31< nigel> I was expressing my reservations gently :>
23:33:32< bernard> db: okay. Pavel's pm_message_t insists that transitions are only ever made into or out of D0. (I guess because it makes life easier for existing drivers' PM code).
23:33:59< bernard> rather, where pm_message_t was headed
23:34:13< alan> Doesn't pm_message_t allow FREEZE -> SUSPEND?

No. Once frozen, you can't talk to your devices, you parent (bus) may be frozen too, so you
can't send the necessary commands to your device to suspend it. FREEZE and SUSPEND in the
current simple model share the fact that once you are frozen, no activity can take place
since your parent (bus) can be frozen too preventing communication with the device. 

23:34:52< nigel> We wouldn't use it if it did.
23:34:56< db> bernard: I think that "revert-to-D0" style rule came from Patrick's original driver model stuff; ask him

It is a PCI requirement iirc, no ?

23:35:01< nigel> Freeze is only used during the atomic copy.

Well, I'm toying with the idea of extending freeze to kexec 

23:35:10< bernard> quoting Documentation/power/devices.txt (in Pavel's tree) "Transitions are only from a resumed state to a suspended state, never between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen, FREEZE -> SUSPEND or SUSPEND -> FREEZE can not)."
23:35:13< nigel> After that we want devices on for writing the atomic copy.
23:35:24-!- pavelma [~pavel-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org] has joined #pm
23:35:33< alan> This is a separate question not mentioned in my email.
23:35:45< alan> In principle the image can be written without waking up every device.

Yes, partial tree suspend. It was decided that we would bother about it when we have the stuff
working well enough as it is though :) If we start going to device local states, sysfs originated
transitions, etc, though, we'll probably end up with a mecanism capable of that. That is
triggering a wake of the storage device which will "cascade" upward along the tree.

23:35:47< pavelma> Sorry, poor signal inside, rain outside.
23:35:59< alan> Hi Pavel!
23:36:03 * db greets pavel ... no horses today?
23:36:28-!- bernard changed the topic of #pm to: linux-pm discussion. Logged live at http://helicon.ucs.uwa.edu.au/~bernard/irc/%23pm.log
23:36:36< pavelma> horses will have to wait for my battery running out.
23:37:13< db> We don't seem to be progressing very far on states.
23:37:19< alan> Time for next topic?...
23:37:29< mochel> yes, 
23:37:31< db> We have a working agreement (I think) that they're pointer-to-struct,
23:37:39< alan> Can complex states be given names simple enough to use with sysfs?
23:37:43< mochel> but first can we have some administritiva? 
23:37:56< alan> mochel: go ahead.
23:37:58< db> maybe with name embedded, and are used in suspend() calls, sysfs, and bus mapping glue.
23:38:01< pavelma> alan: read faq in swsusp.txt for why partial resume in swsusp is bad idea.

Note that entering FREEZE and exiting it is very fast. Currently, we suspend everything tho, but
once drivers start knowing the difference, it will be as there is no HW PM to be done.


23:45:26< mochel> alan: is it right to assume that we agree that system power states are generic,  but need to be translated to bus-specific states?
23:45:35< alan> mochel: Exactly.

Agreed, though I would be richer and define device states. In fact, device states and bus states could
be the same thing if you consider the bus states as beeing the device state of the bus controller
device though.

But my point is that individual drivers want to expose richer states than the normal
bus states, they may have locally several PM modes with various performances for
example that they want to expose in sysfs. I think we should cover device states
and maybe just have bus states just be device states of the bus controllers, and
deal with cascading dependencies.

Heh, strange, it sounds like what I wrote a while ago :)

So well defined busses like PCI or USB would have a strict definition of the
bus states, taht is the pci_bus driver states (yes, we are getting pci bus drivers,
we need those anyway and I've seen separate work toward this) and the {e,o,u}hci
states.

23:45:51< pavelma> alan: I lost about half of conversation...
23:45:57< mochel> and the best way to do that is to encapsulate them in bus-specific type 
23:45:59< mochel> ?

Hrm...

23:46:03< db> Or driver-specific ones.  Repeat:  not everything's as regular as pci or usb 

Agreed.

23:46:04< nigel> What about those funny states that one platform had? I forgot the names now.
23:46:25< mochel> jcrouse: heh, they're in everyone's mind. we've a lot to do in 4 months :) 
23:46:34< jcrouse> no doubt
23:46:38< alan> pavelma: You can catch up later on Bernard's feed.
23:46:40< lenb> alan: on ACPI-enabled systems, for motherboard devices, the BIOS provides a mapping between system and device states -- though Linux doesn't look at it yet.

That's fine. If we split and decide that, for example, suspend/resume are responsible
for this mapping, drivers are welcome to just call ACPI to get it. Or we could have
the core do the mapping if the driver doesn't provide a mapping function, and the core
could call ACPI on machines where it exist. But I want the driver to have the possibility
of beeing in control, to decide either not to use ACPI or override it's decision.

23:46:40< db> nigel:  most non-pc platforms don't support pc platform states...
23:46:53< nigel> Systems states I mean.
23:47:10< mochel> So, we pass system state to drivers, which then must translate it to an appropriate device state for the given system state.

Agreed.

23:47:14< db> s/platform state/syste state/
23:47:18< alan> Bus and device drivers should strive to use ACPI mappings when available.

We should only define bus states (or driver states for bus controllers, see above).

Wether we define them the same way ACPI does is a matter of how good ACPI definition
is, I haven't seen it, but it should probably be discussed bus per bus.

23:47:29< mochel> s/available/appropriate/
23:47:41< mochel> ACPI is not *always* right :) 
23:47:48-!- pavelm [~pavel-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org] has quit [Remote host closed the connection]
23:47:53< alan> Available _and_ appropriate.
23:48:08< mochel> i figured the latter assumed the former..
23:48:22< db> acpi states were supposed to be considerd in pci_choose_state() for example
23:48:30< lenb> Yes, I'm okay with Linux being able to over-ride what the BIOS tells it, but no reason to invent a new language and mapping if ACPI gives us one already on many systems.
23:48:45< mochel> lenb: definitely

Provided the mapping provided by ACPI is sane ;) but again, I haven't seen it. I don't feel like groking
the whole of ACPI spec, so it would be nice if you could do a short abstract of it for us...
  
23:48:51< alan> Is there an easy way to get the mapping from ACPI?
23:48:55< mochel> ditto for other firmwares
23:49:00< db> On systems that support ACPI, how will we know to ignore its mappings?

Drivers have override function, platform may override too.


23:52:21< db> mochel:  I'm thinking about embedded hardware, like ARM, that will never touch ACPI.   Ever.

Or pmac, I hope :)

Ok, enough for now...

Ben.



--===============3016474973334542==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============3016474973334542==--
