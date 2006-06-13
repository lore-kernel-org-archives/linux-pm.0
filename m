From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/2] suspend-to-ram debugging patches
Date: Tue, 13 Jun 2006 14:30:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


Ok,
 some of the people on this list have already seen the first of these two =

patches, but others haven't, and comments are welcome.

These two patches came about due to me debugging my Mac Mini =

suspend/resume, and not being able to make a lot of headway. =


The patches do two things:

 [patch 1]: Add some basic resume trace facilities

	This adds the capability to trace what the last operation was =

	before the machine hung or rebooted. It does so by saving off a =

	few magic hashes into the machine RTC, so that on next bootup =

	(within three minutes!) you can tell which device, and which =

	source code line number was the last one that was traced.

	NOTE! On its own, the patch does nothing. You also need to add =

	trace-points by hand, ie at a minimum add a TRACE_DEVICE(dev)
	in resume_device(), and then TRACE_RESUME() points all along the =

	path you're trying to debug to see which one is the one you hit =

	last.

	IOW, it's very nasty to use, but it's better than "my machine =

	never came back, and doesn't tell me anything, what should I do =

	now?"

 [patch 2]: Fix console handling during suspend/resume

	Some people may hate this, but what it does is to suspend the =

	console handling _properly_, so that if there are messages that =

	happen while the machine is suspending or resuming, they can =

	actually be printed out over a netconsole window, even if the =

	network device was part of the devices going down.

	The reason people may hate it is that it actually means that we =

	don't print the messages at all when the machine is going down. We =

	really can't. Even VGA may be behind a bridge or something, and =

	trying to access it is just totally random luck. So the suspend =

	and resume actually gets a lot more quiet - but in the process it =

	actually gets more reliable.

	This makes netconsole usable over a suspend/resume, for example, =

	instead of just oopsing or doing really bad things because we're =

	trying to use the network device at the same time that it's going =

	down.

	When the resume is done, the normal printk() buffering will have =

	kept all the messages, so they are then printed when the devices =

	actually work again.

	I suspect that we might want to have a "debug mode" that basically =

	doesn't stop the console at all, because sometimes the extra =

	messages are very useful, even if they sometimes also just help =

	break the suspend/resume further. That might make some of the =

	people who otherwise hate this happier.

Actual patches in the next two mails as replies to this one.

[ And note: I'm not on the linux-pm list, so please cc me with any useful =

  commentary ]

			Linus
