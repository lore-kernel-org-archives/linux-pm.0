From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: apm_emulation regression
Date: Fri, 14 Dec 2007 11:05:12 +1100
Message-ID: <1197590712.15741.197.camel@pasglop>
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
	<200712140110.44406.rjw@sisk.pl>
	<1197590675.15741.195.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1197590675.15741.195.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org


On Fri, 2007-12-14 at 11:04 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2007-12-14 at 01:10 +0100, Rafael J. Wysocki wrote:
> > 
> > Hmm.
> > 
> > I'm not that familiar with the APM emulation code, but the description
> > of the
> > problem above suggests that the APM emulation can install a suspend
> > notifier for this purpose.
> 
> It can use the new notifier that happens before freezing yes. Johannes,
> I think that's pretty much what my old powermac implementation did
> (using my private notifier scheme I had there), might be worth reviving
> that bit and sticking it into the generic apm_emu ...

Note that you may want to improve on it with a timeout in case userspace
doesn't ack...

Ben.
