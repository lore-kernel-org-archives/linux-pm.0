From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: RE: on-ness
Date: Thu, 27 Apr 2006 09:12:31 -0500 (CDT)
Message-ID: <200604271412.k3RECVA2009467@olwen.urbana.css.mot.com>
Content-Type: multipart/mixed; boundary="===============027560726013714287=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Patrick Mochel's message of Wed, 26 Apr 2006 18:39:01 -0700
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: mochel@linux.intel.com
Cc: david-b@pacbell.net, linux-pm@lists.osdl.org, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

--===============027560726013714287==


Let me recast the question a little.

Quite aside from the utility of having names that are meaningful to a
human reader unfamiliar with a particular device, is the problem of
supporting a system-level power policy on top of devices that have
different device-level power states.

So, is the sum of this conversation to this point that it simply isn't
possible to come up with a set of names and attributes that are
meaningful across devices? Or might it be possible to map the set of
special conditions (like the "NoSoftReset" below) to a common vocabulary
that a device could expose to power management and that a generic,
cross-platform power management facility could map to system states and
transitions?

In my domain (consumer devices) it's not such a big deal, because we
pick the devices and can write code [albeit with some effort that we
would rather not expend] to control each device appropriately in the
context of the system's projected use cases. However, even in our domain
we're beginning to need to deal with USB OTG devices being added, and it
would be useful to be able to handle them at least somewhat
intelligently based on attributes that they expose.

scott

| On Mon, Apr 24, 2006 at 04:32:54PM -0500, Woodruff, Richard wrote:
| > > Are they?  Does "off" imply the device will have been reset the next
| > > time it goes to "on"?  If not, there would seem to be two "off"
| > states.
| > > Or maybe more ... PCI_D0 is probably "on", but all of the other PCI
| > > device states seem to be variants of "off", not of "on".
| > 
| > That would seem device specific.  It would seem that applying a reset
| > when moving from "off" (especially that mapped to PCI_D3) would seem
| > reasonable.  As I was told, the rest of the PCI defined states D1-D3 are
| > non-functional.  So they are all OFF states.
| 
| Yes, they are all off in the sense that they are not operable. However, 
| there are definitely different levels of off-ness. When a device is in D3
| then it transitions to D0, it is assumed to perform an internal device
| reset.
| 
| Well, up until the PCI PM Spec 1.2, which adds a field to the PCI PM 
| config space called "NoSoftReset". If a device has that set, then it is
| an indication that the device does not perform a soft reset (and there-
| fore may not lose any state).
| 
| In D1 and D2, the devices will not lose as much state (though the amount
| is device-specific), but more importantly, the device will not perform a
| reset on the transition back to D0, meaning that we don't have to do a
| full reinitialization. 
| 
| [ The memory savings may be insignificant, but saving ourselves from the
| process of reinitialziation is a big plus. For video devices, it's even
| more compelling - the framebuffer may be large, a reinit may take a very
| long time, and we may not even know how to do a full reinit. ]
| 
| > If just happens that in D3 you can safely physically remove the device.
| 
| That's not necessarily true, but it's moot for this thread anyway. 
| 
| > The current pseudo export
| > of these non-functional states doesn't seem so useful.  Having some
| > fuzzy level of idleness seems much better.
| 
| Maybe. What's more important is getting rid of the pseudo states. The
| drivers should export exactly the states that they support, in whatever
| fashion makes the most sense to them. For PCI devices that support basic
| PM, this will be "D0" and "D3". PCI devices that support D1 and D2 will
| export "D1" and "D2" as well. Devices that support other, device-
| specific states will export meaningful names for them. 
| 
| Different concepts of on-ness should be handled in a similar fashion. It
| doesn't really matter if they are sensical strings or if they are digits,
| it's all ASCII as it goes through sysfs, and it all has to get parsed,
| mapped, and verified at some level. 
| 
| > In my current hack attempts I am trying to associate a 'device' D2 state
| > with a local device sleep with an async wake up enabled.  In this state
| > a devices accesses are locked out until the device wake up event
| > happens.  This async wake can be from a device specific wake up or from
| > an associated timer resource.  Current DPM enabled OMAP sprinkles
| > suspend lock outs inside of drivers which re-suspend queued waiters and
| > suspends new requests if the device is in a locked out state.  From many
| > devices this creates a device which just reacts with a higher latency.
| 
| That sounds promising. Got any patches that you care to post? 
| 
| Thanks,
| 
| 
| 	Patrick
| 
| --===============74204344604701977==
| ----------
| _______________________________________________
| linux-pm mailing list
| linux-pm@lists.osdl.org
| https://lists.osdl.org/mailman/listinfo/linux-pm
| 
| --===============74204344604701977==--

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



--===============027560726013714287==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============027560726013714287==--
