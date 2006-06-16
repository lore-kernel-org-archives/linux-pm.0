From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 21:37:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152057140.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<20060615191925.GA1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
	<1150421189.7725.81.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151927580.5498@g5.osdl.org>
	<1150429033.7725.118.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150429033.7725.118.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> Ok, but I still have a hard time figuring out what you call by "save"
> then... =


Well, I think X and fbcon are examples of where you do actually save =

state, totally separately from the "suspend" thing, and where saving it at =

boot time is obviously not practical.

The same is true of any virtual devices.

But perhaps even more importantly, I think it's a _lot_ easier for most =

device driver writers to have an explicit save event, especially since =

this will be conditional on the configuration having CONFIG_PM.

And I think it's better to make things explicit for driver writers than =

expect them to get it right implicitly. Especially since in many cases the =

state you want to restore ends up depending on a lot of other things, it's =

often just _easier_ to have a "save state" phase that the driver writer =

knows is called before suspend, and which can (for example), just blindly =

save off the config space, and then at resume time we just blast it back =

out.

Same goes for just saving/restoring some firmware memory area or similar, =

for example. Yeah, we could ask user space to do it for us, but wouldn't =

it be nice if "it just worked", and we made the interfaces obvious enough =

that it's easy for a writer to make it so?

In contrast, keeping track of things one field at a time is actually =

pretty painful, even if you do have all the information, and even if you =

don't strictly need to save off what ends up being just another way of =

saying the same thing..

> I tend to think we are close to my concept of "prepare for suspend" that
> I exlained separately.

And, btw, I think "prepare_for_suspend()" is a perfectly fine alternate =

name for "save_state". Maybe even better. I don't at all disagree about =

that approach or the naming.

> I'm still not sure I totally understand what save_state exactly _is_ in
> your view of things since most of the time there is either no state to
> "save" or it makes no sense to save stuff that will get invalidated and
> need to be reconstructed as you properly explained...

Basically, outside of power management, there is a lot of state that =

simply doesn't need to _ever_ be saved, exactly because we don't actually =

lose that state.

So I would want us to have an explicit callback to save any potential =

state and just generally tell the driver to perhaps disconnect from any =

user-level stuff etc, rather than have the driver have to keep track of =

and remember that on its own.

But yes, if you think it would be more obvious to call it =

"prepare_for_suspend", I have no problem with that. It doesn't change the =

basic functionality.

I would want most devices to be able to have a suspend function that =

_literally_ just does

	pcibios_enable_device(dev, PCI_D0);

and it would be clear that interrupts have long since been disabled, and =

there can be no memory allocations, and by then "printk()" won't actually =

show anything at all, and you cannot return an error, because we have long =

since passed the point of no return.

THAT is what I care about. The current setup actually works for me, but it =

works at least partially exactly because I basically shut off the console =

"too early". I would really have preferred to shut off the console much =

much later, but since currently all the preparatory work actually also =

ends up shutting things down, that simply isn't an issue.

So for any individual driver, the split into "prepare" and "suspend" will =

never help. That's not the point. The point is purely that we can do =

general and global things in _between_ the point where "all drivers are =

prepared and have said that they are ready to suspend", and the final "go =

go go" moment.

I suspect a lot of drivers don't even need much of a prepare. And others =

will _literally_ just do something simple and stupid like

	static int prepare_to_suspend(struct pci_dev *dev, pm_message_t state)
	{
		pci_power_t pstate =3D pci_choose_state(pdev, state);

		if (state !=3D PCI_D3hot && state !=3D PCI_D3cold)
			return -EINVAL;
		.. allocate save area for IO registers, save them there ..
		pci_save_state(dev);
		return 0;
	}

exactly so that we can tell _ahead_ of time if something would fail, and =

so that we can keep the console open longer.

In my crazier moments, I actually want to do _three_ phases: my really =

preferred thing would be

 - phase 1: allocate memory, save state, and return errors

   After phase 1, we are guaranteed to not need any more memory =

   allocations.

 - phase 2: send commands to flush write caches, spin down

   After phase 2, we know we don't have to wait any more, and this is the =

   point where we disable the console and disable all interrupts

 - phase 3: actually power down chips.

   There is no "after phase 3". The CPU powering down was the last part.

but I'm still busy trying to just push for a second phase, so I'm not even =

going to mention that next crazy plan to you.

Oops.

		Linus
