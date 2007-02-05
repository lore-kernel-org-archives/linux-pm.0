From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH revision 2] windfarm: dont die on suspend
	thread signal
Date: Tue, 06 Feb 2007 10:04:34 +1100
Message-ID: <1170716674.2620.147.camel@localhost.localdomain>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
	<20070205224325.GA8453@lst.de>
	<1170716074.30959.13.camel@johannes.berg>
	<1170716641.2620.145.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170716641.2620.145.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Christoph Hellwig <hch@lst.de>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-02-06 at 10:04 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2007-02-05 at 23:54 +0100, Johannes Berg wrote:
> > When the windfarm thread gets a suspend signal it will die instead of
> > freezing. This fixes it.
> =

> Don't we still need to call try_to_freeze() ?

Forget it... of course we do.

Ben.
