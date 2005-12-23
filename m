From: Holger Macht <hmacht@suse.de>
Subject: Runtime device power management in userspace
Date: Fri, 23 Dec 2005 15:30:47 +0100
Message-ID: <20051223143047.GC16463@f192.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41546095293791274=="
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============41546095293791274==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We implemented device runtime power management in a userspace application
(the powersave daemon). In this specific case, it means to successively
put pci devices into D3 powersave mode with writing a numerical '3' to the
corresponding power state file.

There are two main reasons for us to even doing this:

  1. At first, the obvious reason. As mentioned in our research regarding
     power consumption on this list, there is a very huge potential to
     save battery power.

  2. Due to the fact that this is AFAIK a heavily untested area, as a side
     effect, we like to get reports about broken modules/drivers and maybe
     get them fixed.

It is explicitly ment as an expert option and will be handled in a very
special way in our frontends. The normal user will be warned loud enough
before he can enable this "feature" ;-) We are also seriously aware of the
fact that all this should be done in kernel space one day.

Before starting implementation, we tested on different machines with
different hardware and got surprisingly few problems. The only module we
are at the moment aware of that it is broken, is e100. Sure, there might
be more...

Now that we get more and more votes that this could be very dangerous and
problematic because of the current kernel implementation, we decided to
gather some more comments from involved people and experts in this
area. That's the aim of my post to this list. Opinions are welcome!

Thanks in advance,
       Holger

--===============41546095293791274==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41546095293791274==--
