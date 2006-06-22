From: Pavel Machek <pavel@ucw.cz>
Subject: Re: windfarm got signal
Date: Thu, 22 Jun 2006 15:12:17 +0200
Message-ID: <20060622131216.GA2959@openzaurus.ucw.cz>
References: <1150847482.16662.13.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1150847482.16662.13.camel@johannes>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> after cpu hotplug I decided to write some fake suspend routines for
> ppc64 that always fail to see what all the drivers would say... The
> first thing I saw was during the phase where all threads are stopped,
> that windfarm got a signal!
> =

> Shortly after that, the fans were revved up fully but I guess that's
> expected if the wf control loop exits.
> =

> So now I'm trying to see *why* it got a signal there. Any ideas? Is that
> expected with pm and windfarm just does the wrong thing there by taking
> the signal as a reason to exit the control thread?
> =

> [code in question is windfarm_core.c:wf_thread_func]

See kernel/power/process.c

-- =

64 bytes from 195.113.31.123: icmp_seq=3D28 ttl=3D51 time=3D448769.1 ms    =
     =
