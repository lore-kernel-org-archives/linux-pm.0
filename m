From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] Disabling Devices
Date: Wed, 11 May 2005 10:39:06 +0200
Message-ID: <20050511083906.GB6222@openzaurus.ucw.cz>
References: <20050509021528.GB27448@neo.rr.com>
	<Pine.LNX.4.44L0.0505091012400.5325-100000@iolanthe.rowland.org>
	<20050509150452.GC27448@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86530838184821213=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050509150452.GC27448@neo.rr.com>
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

--===============86530838184821213==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > As another issue, how should we handle surprise removal between suspend and
> > > resume?  It seems like we would need to tell the resume method about this.
> > 
> > I don't know how it should be handled in other subsystems.  With USB, we 
> > detect the removal at or close to the time when we attempt to resume the 
> > device.  Of course USB is peculiar, in that the drivers don't bind 
> > directly to the devices (they bind to interfaces within the devices).  
> > Hence by the time the drivers' ->resume gets called, there's a good chance 
> > we already know the device is gone.
> > 
> > But even if we didn't know, it wouldn't matter much.  The driver would
> > encounter a rash of errors as it tried to communicate with the missing
> > device, and they would end abruptly when we learned that the device had
> > been disconnected.
> 
> Most drivers aren't this smart, and not every bus will be happy with drivers
> tearing through the remains of previously removed hardware.
> 

...so fix the drivers. If the device fails, they should handle it. And bus should
handle it, too...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============86530838184821213==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86530838184821213==--
