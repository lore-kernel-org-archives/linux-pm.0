From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
	interrupt handlers
Date: Fri, 08 Oct 2010 14:04:05 -0700
Message-ID: <87sk0gtn0a.fsf__19864.5664415837$1286571926$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1010081220150.27105-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010081220150.27105-100000@netrider.rowland.org>
	(Alan Stern's message of "Fri, 8 Oct 2010 12:22:38 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Thu, 7 Oct 2010, Kevin Hilman wrote:
>
>> > Do you need "normal" resume to work after "atomic" suspend, or is it
>> > sufficient that "atomic" suspend will require "atomic" resume?
>> 
>> hmm... while I'm definitely needing an "atomic" resume after a "normal"
>> suspend, for now I can't think of a case where a "normal" resume would
>> be needed after an "atomic" suspend.  All the cases where I'm currently
>> using an atomic suspend also have a corresponding atomic resume.
>> 
>> As I write this, it wouldn't surprise me down the road to find some HW
>> errata that requires the device in a specific state only before idle,
>> but not caring about the state after idle.  That would be a case where
>> an atomic suspend would be needed, but the resume would be "normal"
>> sometime later when the device is next needed.
>
> Put it this way: Are you okay with just the following two 
> possibilities?
>
> 	(1) Both suspends and resumes always have interrupts enabled.
>
> 	(2) Both suspends and resumes always have interrupts disabled.
>
> In other words, is it okay to rule out the ability of mixing "atomic" 
> and "normal" runtime PM operations?

Yes, I think that's a reasonable limitation.

If a driver/subsystem needs to handle an occasional "atomic" runtime PM
operation, it's callbacks will have to be atomic as well, so I don't see
any reason it can't be made to use only atomic operations.

Kevin
