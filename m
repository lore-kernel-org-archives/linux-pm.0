From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Possible subjects for IRC discussion
Date: Wed, 16 Mar 2005 22:44:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503162218100.6156-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============85629025734340436=="
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

--===============85629025734340436==
Content-Type: TEXT/PLAIN; charset=US-ASCII

For anyone who manages to read this message in time...

Here are some things we could talk about:

	How should device power states be represented in the kernel?
	One option: pointer to some kind of structure.

	How should parents be notified about power state changes in
	their children?  Internally at the bus-subsystem level, or
	should the PM core provide some facility?

	Can we name device power states so they can be displayed in
	sysfs?  To what extent can these names be bus-independent?  What
	about complex states that represent multiple settings (different
	clocks and so on)?

	If the user interface involves telling the kernel what state to
	put a device into by writing the state's name to the sysfs
	attribute file, the kernel needs to know which name represents
	Full Power.  Otherwise it won't be able to tell whether it should
	call the driver's ->resume or ->suspend!  Should we always use
	some conventional name (like "on") to represent full power?

	Kernel power management facilities exist in order to carry out
	user policy.  What forms can that policy take, and what does the
	kernel need to implement?  Some examples:

		Change device D from power state X to power state Y after
		N seconds of inactivity.

		Put device D in power state Z whenever Suspend To Ram 
		occurs.

		Put device D in power state X right now.

	Are there any other forms of policy the kernel can carry out?
	How should even these simple policies be conveyed from userspace
	to the kernel?

	The user interface needs a way to tell the kernel whether a
	device is enabled for wakeup signals.  It also needs a way to
	tell the kernel whether a device should be resumed whenever a
	software I/O request arrives on the device's queue.  How should 
	this information be conveyed?

	What messages need to be sent to userspace when device power
	changes occur?  What sort of changes should generate such a 
	message?  What mechanism should be used for sending the messages?  
	(This is for device power management of course; system power
	management will require its own set of messages.)

Alan Stern


--===============85629025734340436==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============85629025734340436==--
