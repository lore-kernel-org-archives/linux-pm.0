From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: windfarm got signal
Date: Thu, 22 Jun 2006 16:02:03 +1000
Message-ID: <1150956123.3633.23.camel@localhost.localdomain>
References: <1150847482.16662.13.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
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
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-06-21 at 01:51 +0200, Johannes Berg wrote:
> Hey,
> =

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

I think it's the way the freezer works ... it sends a pseudo signal to
all kernel threads who are then supposed to do something like test for
PF_FREEZE or something like that.

Ben.
