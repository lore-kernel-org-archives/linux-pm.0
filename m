From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Power Management framework proposal
Date: Wed, 25 Jul 2007 09:47:57 +1000
Message-ID: <1185320877.5439.300.camel__5155.49802589721$1185320978$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<1185229405.5439.148.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707241313580.6590@asgard.lang.hm>
	<1185313138.5439.285.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707241556140.6590@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707241556140.6590@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-24 at 16:02 -0700, david@lang.hm wrote:
> 
> what requirements are needed? (I'm sure that there are others, but 
> hopefully it's possible to avoid requirements like 'the clock speed
> for 
> device A must be >X to allow device B to operate in mode Y') 

I had an idea a while ago, might still be in the pm list archives, of
exposing constraints as opaque bitmaps. The bits have defined meaning
for a given bus, but are opaque to the core.

The devices however, provide tables indicating to the core their list of
power states (with names) and their requirements in term of parent
states (using such bitmasks).

Thus, the core can resolve the dependency requirements without having to
know about the actual meaning of the states of the various busses.

Ben.
