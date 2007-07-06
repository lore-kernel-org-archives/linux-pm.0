From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 15:45:17 +1000
Message-ID: <87r6nmozki.fsf@rimspace.net>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051528.34754.oliver@neukum.org>
	<20070705134632.GA22177@srcf.ucam.org>
	<200707051609.25887.rjw@sisk.pl>
	<20070705142318.GA22598@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705142318.GA22598@srcf.ucam.org> (Matthew Garrett's message
	of "Thu, 5 Jul 2007 15:23:18 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> writes:
> On Thu, Jul 05, 2007 at 04:09:24PM +0200, Rafael J. Wysocki wrote:
>> On Thursday, 5 July 2007 15:46, Matthew Garrett wrote:
>> > I have a model for STD that avoids the need to freeze the entirity of 
>> > userspace, but I need to find some more time to flesh it out.
>> 
>> You can just describe it, as far as I'm concerned. :-)
>
> The basic model is that nobody's really described a use-case where we 
> actually care about restoring system state. What people want is to be 
> able to restore application state. So, arguably, what we want isn't to 
> save the entire kernel state and application state in one go because we 
> can reconstruct a huge amount of that afterwards.

[...]

> I've mocked up a basic implementation using cryopid, but it's somewhat
> limited by the lack of support for sockets. I'd like to move more of
> the smarts into the kernel (Hurray, checkpointing!) and then see how
> much hardware support ends up horifically broken.

You might want to look at the checkpoint / migration support in the
OpenVZ kernel in relation to this.  That does work to dump the state of
a running "virtual environment" complete with applications to disk, move
it to another running kernel and restore the content.

That might, perhaps, help with the prototype of this?

Regards,
	Daniel
