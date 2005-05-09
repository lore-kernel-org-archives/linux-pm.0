From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Disabling Devices
Date: Mon, 9 May 2005 12:46:43 +0200
Message-ID: <20050509104643.GB25275@atrey.karlin.mff.cuni.cz>
References: <20050509021528.GB27448@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98093587645700397=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050509021528.GB27448@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============98093587645700397==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> One potentially important aspect of power management is the ability for the
> user to disable a device that he or she does not intend to use.  Our current
> model does not allow for this.  Calling PMSG_SUSPEND won't cut it, because it
> might enable wake events and is expecting the system to sleep.  It seems we
> need to implement something specifically for this case.  Also, there is the
> posibility of resource rebalancing, which requires yet another slightly
> different behavior.
> 
> Consider if a user wanted to disable a pci bus...  If the bus was just
> suspended, it would be straightforward, put all the children to sleep and
> then turn off the bus.  However, in the case of disabling it (as in "do not
> use me") all of the child devices would actually need to be unregistered.

I think you should talk to hotplug people from high-end
machines. "Disable PCI bus" seems very similar to "hey, I want to
unplug that PCI bus". And they have to the ethernet case for
hot-pluggable PCI cards, too.

								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.

--===============98093587645700397==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============98093587645700397==--
