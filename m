From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Fri, 09 Feb 2007 09:33:32 +1100
Message-ID: <1170974012.2620.384.camel@localhost.localdomain>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
	<17867.40281.175422.116673@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <17867.40281.175422.116673@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


> Are you sure this is necessary?  IIRC, the if (!cpu_is_offline(cpu)) a
> little bit further down is there to cope with this exact situation.
> And cpu hotplug already works on G4 SMP powermacs, where we can't
> physically remove the cpu either - we just put it into sleep mode with
> interrupts disabled, which is what we would be doing on a G5 powermac
> also.

I've always had doubts about wether SLEEP with EE off was legal and
wouldn't actually still go out of sleep when getting an interrupt... In
that case, at least on CPUs where the DEC acts "level" triggered, we
need to at least reset the DEC to some sane value.

Ben.
