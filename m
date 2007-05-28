From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 14:01:40 +0200
Message-ID: <1180353701.4242.68.camel@lov.localdomain>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
	<1180343171.4242.15.camel@lov.localdomain>
	<5C7E12A9-DCEB-40AA-B3E6-4A54F4FE8047@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5C7E12A9-DCEB-40AA-B3E6-4A54F4FE8047@cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael-Luke Jones <mlj28@cam.ac.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Rob Landley <rob@landley.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-05-28 at 11:26 +0100, Michael-Luke Jones wrote:
> On 28 May 2007, at 10:06, Kay Sievers wrote:
> 
> > The underlying issue are the driver authors, that's not so easy to
> > fix. :)
> 
> Sorry, I know this maybe be unintentional, but comments like this  
> make me somewhat angry.

It was the response to "pushing a bodge upstream", while we just try to
make things working. :)
We are fighting that broken firmware-loader model for years, but every
driver author seems to have its own idea how that should work in theory,
but they are not even willing to switch to the existing version that is
expected to work better.

> If there is no decent documentation as to how to do it the right way  
> (tm), how do you expect people to do it the right way (tm)?
> 
> > Any timeout for a
> > firmware-request is just a broken concept, the request should wait
> > forever, to be fulfilled or canceled from userspace when it's ready.
> 
> What I wrote above is especially true when the in-kernel APIs  
> themselves do things the wrong way (tm) themselves. Thus, even more  
> thought is required to work around this imperfect behaviour in a sane  
> manner. And without documentation, every single device driver author  
> has to go through this thought process themselves. Unsurprisingly,  
> they often get it wrong. But as there's no decent documentation to do  
> it right, it's *not* their fault. I'd suggest it's more the fault of  
> the core kernel devs who fail to fix up a questionable firmware  
> loading interface, then fail to document how to work around its  
> shortcomings.
> 
> Again, apologies if this sounds angry, I don't want to start an  
> argument. But as someone just starting out here, this kind of thing  
> can be very frustrating, as even with the best will in the world,  
> achieving the right way (tm) is basically impossible if those in the  
> know about what the right way (tm) is fail to share this information.

In our development model, users of an interface are expected to improve
it, because nobody else really knows what's needed. That unfortunately
didn't happen so far.

We get this kind of conversation every few months since a few years now.
I wonder, if we will see code, or at least come up with a better idea
this time. :)

Kay
