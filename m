From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] of/platform: Implement support for dev_pm_ops
Date: Wed, 14 Oct 2009 15:55:40 +1100
Message-ID: <1255496140.2347.36.camel__23215.9979561859$1255496220$gmane$org@pasglop>
References: <20091012155041.GA1071@oksana.dev.rtsoft.ru>
	<fa686aa40910121509n1b7dba87nbe9ddf34f0b4d7c@mail.gmail.com>
	<20091012224410.GA18923@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091012224410.GA18923@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: avorontsov@ru.mvista.com
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 2009-10-13 at 02:44 +0400, Anton Vorontsov wrote:

> I agree that there is some room for improvements in general (e.g.
> merging platform and of_platform devices/drivers), but it's not as
> easy as you would like to think. Let's make it in a separate step
> that don't stop real features from being implemented (e.g.
> hibernate).
> 
> For the six functions that we can reuse I can prepare a cleanup
> patch that we can merge via -mm, or it can just sit and collect
> needed acks and can be merged via any tree. But please, no
> cross-tree dependencies for the cruicial features.

I agree. I'll take the patch for now.

In the long run, I'm all for killing of_platform if we can find
a "proper" way to replace it with platform.

IE. With dev_archdata, any device carries the of device node, so
of_platform doesn't really buy us much anymore.

We could even "default" by populating platform device resources
with standard-parsing of "reg" properties etc...

So for devices who don't actually need anything more, we may get
away re-using platform devices as-is, all we would need is some
kind of conversion table or such to map OF match to platform dev names,
or maybe a secondary match table in the drivers themselves.

Anyway, that's an old discussion, something we still need to sort out...

Ben.
