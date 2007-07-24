From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Power Management framework proposal
Date: Wed, 25 Jul 2007 07:38:58 +1000
Message-ID: <1185313138.5439.285.camel__16737.6974401579$1185313230$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185125189.2714.13.camel@laptopd505.fenrus.org>
	<1185229405.5439.148.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707241313580.6590@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707241313580.6590@asgard.lang.hm>
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

On Tue, 2007-07-24 at 13:14 -0700, david@lang.hm wrote:
> > I think we need a set of constraints that trickle down the power
> tree
> > and limit what a given driver can do locally.
> 
> what sort of contraints are you thinking of?

A parent power state defines what states children can be in. For
example. A way to express those dependencies would be nice. Or
alternatiely, the power state of all the children defines the power
state a parent can go in automatically.

Ben.
